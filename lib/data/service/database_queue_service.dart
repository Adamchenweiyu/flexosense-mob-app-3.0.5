import 'dart:async';
import 'dart:collection';
import 'package:drift/drift.dart';
import 'package:flex_sense/application/util/logger.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';

/// Database operation types
enum DatabaseOperationType {
  insertImuList,
  insertMagneticList,
  insertPressure,
  deleteImuUpTo,
  deleteMagneticUpTo,
  deletePressureUpTo,
}

/// Database operation wrapper
class DatabaseOperation {
  final DatabaseOperationType type;
  final dynamic data;
  final DateTime timestamp;
  final String? deviceAddress;

  DatabaseOperation({
    required this.type,
    required this.data,
    required this.timestamp,
    this.deviceAddress,
  });
}

/// Queue-based database service to handle concurrent operations safely
class DatabaseQueueService {
  static final DatabaseQueueService _instance = DatabaseQueueService._internal();
  factory DatabaseQueueService() => _instance;
  DatabaseQueueService._internal();

  late AppDatabase _database;
  final Queue<DatabaseOperation> _operationQueue = Queue<DatabaseOperation>();
  final StreamController<DatabaseOperation> _operationController = StreamController<DatabaseOperation>.broadcast();
  bool _isProcessing = false;
  Timer? _batchTimer;
  DateTime? _processingStartTime;
  
  // Configuration
  static const int _maxBatchSize = 100; // Process up to 100 operations at once
  static const Duration _batchTimeout = Duration(milliseconds: 50); // Process every 50ms
  static const Duration _maxProcessingTime = Duration(seconds: 30); // Max processing time before warning

  /// Initialize the database queue service
  Future<void> initialize(AppDatabase database) async {
    _database = database;
    _startQueueProcessor();
    Log.i('DatabaseQueueService initialized');
  }

  /// Start the queue processor
  void _startQueueProcessor() {
    _operationController.stream.listen((operation) {
      _operationQueue.add(operation);
      _processQueueIfNeeded();
    });
  }

  /// Process queue if conditions are met
  void _processQueueIfNeeded() {
    if (_isProcessing) return;
    
    // Process immediately if queue is full
    if (_operationQueue.length >= _maxBatchSize) {
      _processBatch();
      return;
    }
    
    // Start batch timer if not already running
    _batchTimer ??= Timer(_batchTimeout, () {
      if (_operationQueue.isNotEmpty) {
        _processBatch();
      }
      _batchTimer = null;
    });
  }

  /// Process a batch of operations
  Future<void> _processBatch() async {
    if (_isProcessing || _operationQueue.isEmpty) return;
    
    _isProcessing = true;
    _processingStartTime = DateTime.now();
    _batchTimer?.cancel();
    _batchTimer = null;
    
    try {
      final operations = <DatabaseOperation>[];
      final batchSize = _operationQueue.length > _maxBatchSize ? _maxBatchSize : _operationQueue.length;
      
      // Extract operations from queue
      for (int i = 0; i < batchSize; i++) {
        if (_operationQueue.isNotEmpty) {
          operations.add(_operationQueue.removeFirst());
        }
      }
      
      if (operations.isNotEmpty) {
        await _executeBatch(operations);
      }
    } catch (e) {
      Log.e('Error processing database batch: $e');
    } finally {
      _isProcessing = false;
      _processingStartTime = null;
      
      // Continue processing if there are more operations
      if (_operationQueue.isNotEmpty) {
        _processQueueIfNeeded();
      }
    }
  }

  /// Execute a batch of operations
  Future<void> _executeBatch(List<DatabaseOperation> operations) async {
    // Group operations by type for better performance
    final imuOperations = <DatabaseOperation>[];
    final magneticOperations = <DatabaseOperation>[];
    final pressureOperations = <DatabaseOperation>[];
    final deleteImuOperations = <DatabaseOperation>[];
    final deleteMagneticOperations = <DatabaseOperation>[];
    final deletePressureOperations = <DatabaseOperation>[];
    
    for (final operation in operations) {
      switch (operation.type) {
        case DatabaseOperationType.insertImuList:
          imuOperations.add(operation);
          break;
        case DatabaseOperationType.insertMagneticList:
          magneticOperations.add(operation);
          break;
        case DatabaseOperationType.insertPressure:
          pressureOperations.add(operation);
          break;
        case DatabaseOperationType.deleteImuUpTo:
          deleteImuOperations.add(operation);
          break;
        case DatabaseOperationType.deleteMagneticUpTo:
          deleteMagneticOperations.add(operation);
          break;
        case DatabaseOperationType.deletePressureUpTo:
          deletePressureOperations.add(operation);
          break;
      }
    }
    
    // Execute operations in batches by type
    await Future.wait([
      if (imuOperations.isNotEmpty) _executeImuBatch(imuOperations),
      if (magneticOperations.isNotEmpty) _executeMagneticBatch(magneticOperations),
      if (pressureOperations.isNotEmpty) _executePressureBatch(pressureOperations),
      if (deleteImuOperations.isNotEmpty) _executeDeleteImuBatch(deleteImuOperations),
      if (deleteMagneticOperations.isNotEmpty) _executeDeleteMagneticBatch(deleteMagneticOperations),
      if (deletePressureOperations.isNotEmpty) _executeDeletePressureBatch(deletePressureOperations),
    ]);
  }

  /// Execute IMU operations batch
  Future<void> _executeImuBatch(List<DatabaseOperation> operations) async {
    final allImuData = <ImuEntityData>[];
    
    for (final operation in operations) {
      if (operation.data is List<ImuEntityData>) {
        allImuData.addAll(operation.data as List<ImuEntityData>);
      }
    }
    
    if (allImuData.isNotEmpty) {
      await _database.batch((batch) {
        batch.insertAll(
          _database.imuEntity,
          allImuData,
          mode: InsertMode.insert,
        );
      });
    }
  }

  /// Execute Magnetic operations batch
  Future<void> _executeMagneticBatch(List<DatabaseOperation> operations) async {
    final allMagneticData = <MagneticEntityData>[];
    
    for (final operation in operations) {
      if (operation.data is List<MagneticEntityData>) {
        allMagneticData.addAll(operation.data as List<MagneticEntityData>);
      }
    }
    
    if (allMagneticData.isNotEmpty) {
      await _database.batch((batch) {
        batch.insertAll(
          _database.magneticEntity,
          allMagneticData,
          mode: InsertMode.insert,
        );
      });
    }
  }

  /// Execute Pressure operations batch
  Future<void> _executePressureBatch(List<DatabaseOperation> operations) async {
    final allPressureData = <PressureEntityData>[];
    
    for (final operation in operations) {
      if (operation.data is PressureEntityData) {
        allPressureData.add(operation.data as PressureEntityData);
      }
    }
    
    if (allPressureData.isNotEmpty) {
      await _database.batch((batch) {
        batch.insertAll(
          _database.pressureEntity,
          allPressureData,
          mode: InsertMode.insertOrReplace,
        );
      });
    }
  }

  /// Execute IMU deletion batch
  Future<void> _executeDeleteImuBatch(List<DatabaseOperation> operations) async {
    // Process deletions sequentially to avoid conflicts
    for (final operation in operations) {
      if (operation.data is DateTime) {
        final cutOffTime = operation.data as DateTime;
        await _database.batch((batch) {
          batch.customStatement(
            'DELETE FROM imu_entity WHERE time <= ?',
            [cutOffTime.millisecondsSinceEpoch],
          );
        });
      }
    }
  }

  /// Execute Magnetic deletion batch
  Future<void> _executeDeleteMagneticBatch(List<DatabaseOperation> operations) async {
    // Process deletions sequentially to avoid conflicts
    for (final operation in operations) {
      if (operation.data is DateTime) {
        final cutOffTime = operation.data as DateTime;
        await _database.batch((batch) {
          batch.customStatement(
            'DELETE FROM magnetic_entity WHERE time <= ?',
            [cutOffTime.millisecondsSinceEpoch],
          );
        });
      }
    }
  }

  /// Execute Pressure deletion batch
  Future<void> _executeDeletePressureBatch(List<DatabaseOperation> operations) async {
    // Process deletions sequentially to avoid conflicts
    for (final operation in operations) {
      if (operation.data is DateTime) {
        final cutOffTime = operation.data as DateTime;
        await _database.batch((batch) {
          batch.customStatement(
            'DELETE FROM pressure_entity WHERE time <= ?',
            [cutOffTime.millisecondsSinceEpoch],
          );
        });
      }
    }
  }

  /// Queue IMU data for insertion
  void queueImuData(List<ImuEntityData> imuData, {String? deviceAddress}) {
    _operationController.add(DatabaseOperation(
      type: DatabaseOperationType.insertImuList,
      data: imuData,
      timestamp: DateTime.now(),
      deviceAddress: deviceAddress,
    ));
  }

  /// Queue Magnetic data for insertion
  void queueMagneticData(List<MagneticEntityData> magneticData, {String? deviceAddress}) {
    _operationController.add(DatabaseOperation(
      type: DatabaseOperationType.insertMagneticList,
      data: magneticData,
      timestamp: DateTime.now(),
      deviceAddress: deviceAddress,
    ));
  }

  /// Queue Pressure data for insertion
  void queuePressureData(PressureEntityData pressureData, {String? deviceAddress}) {
    _operationController.add(DatabaseOperation(
      type: DatabaseOperationType.insertPressure,
      data: pressureData,
      timestamp: DateTime.now(),
      deviceAddress: deviceAddress,
    ));
  }

  /// Queue IMU data deletion up to specified time
  void queueDeleteImuUpTo(DateTime cutOffTime, {String? deviceAddress}) {
    _operationController.add(DatabaseOperation(
      type: DatabaseOperationType.deleteImuUpTo,
      data: cutOffTime,
      timestamp: DateTime.now(),
      deviceAddress: deviceAddress,
    ));
  }

  /// Queue Magnetic data deletion up to specified time
  void queueDeleteMagneticUpTo(DateTime cutOffTime, {String? deviceAddress}) {
    _operationController.add(DatabaseOperation(
      type: DatabaseOperationType.deleteMagneticUpTo,
      data: cutOffTime,
      timestamp: DateTime.now(),
      deviceAddress: deviceAddress,
    ));
  }

  /// Queue Pressure data deletion up to specified time
  void queueDeletePressureUpTo(DateTime cutOffTime, {String? deviceAddress}) {
    _operationController.add(DatabaseOperation(
      type: DatabaseOperationType.deletePressureUpTo,
      data: cutOffTime,
      timestamp: DateTime.now(),
      deviceAddress: deviceAddress,
    ));
  }

  /// Get current queue size
  int get queueSize => _operationQueue.length;

  /// Check if queue is processing
  bool get isProcessing => _isProcessing;

  /// Check if processing is actually stuck (not just busy)
  bool get isStuck {
    if (!_isProcessing || _processingStartTime == null) return false;
    
    final processingDuration = DateTime.now().difference(_processingStartTime!);
    return processingDuration > _maxProcessingTime;
  }

  /// Get processing duration if currently processing
  Duration? get processingDuration {
    if (!_isProcessing || _processingStartTime == null) return null;
    return DateTime.now().difference(_processingStartTime!);
  }

  /// Force process all pending operations
  Future<void> flushQueue() async {
    while (_operationQueue.isNotEmpty || _isProcessing) {
      if (_operationQueue.isNotEmpty) {
        await _processBatch();
      }
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }

  /// Clear all data from database (useful for testing or fixing schema issues)
  Future<void> clearAllData() async {
    try {
      await _database.batch((batch) {
        batch.customStatement('DELETE FROM imu_entity');
        batch.customStatement('DELETE FROM magnetic_entity');
        batch.customStatement('DELETE FROM pressure_entity');
      });
      Log.i('Cleared all sensor data from database');
    } catch (e) {
      Log.e('Error clearing database: $e');
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await flushQueue();
    _batchTimer?.cancel();
    await _operationController.close();
    Log.i('DatabaseQueueService disposed');
  }
}
