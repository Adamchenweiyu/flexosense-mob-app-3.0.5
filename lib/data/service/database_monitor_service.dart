import 'dart:async';
import 'package:flex_sense/application/util/logger.dart';
import 'package:flex_sense/data/service/database_queue_service.dart';

/// Service to monitor database queue performance and health
class DatabaseMonitorService {
  static final DatabaseMonitorService _instance = DatabaseMonitorService._internal();
  factory DatabaseMonitorService() => _instance;
  DatabaseMonitorService._internal();

  Timer? _monitorTimer;
  final List<QueueMetrics> _metricsHistory = [];
  static const int _maxHistorySize = 100; // Keep last 100 measurements

  /// Start monitoring the database queue
  void startMonitoring() {
    _monitorTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _collectMetrics();
    });
    Log.i('Database monitoring started');
  }

  /// Stop monitoring
  void stopMonitoring() {
    _monitorTimer?.cancel();
    _monitorTimer = null;
    Log.i('Database monitoring stopped');
  }

  /// Collect current metrics
  void _collectMetrics() {
    final queueService = DatabaseQueueService();
    final metrics = QueueMetrics(
      timestamp: DateTime.now(),
      queueSize: queueService.queueSize,
      isProcessing: queueService.isProcessing,
    );
    
    _metricsHistory.add(metrics);
    
    // Keep only recent history
    if (_metricsHistory.length > _maxHistorySize) {
      _metricsHistory.removeAt(0);
    }
    
    // Log warning if queue is getting too large
    if (metrics.queueSize > 500) {
      Log.w('Database queue size is high: ${metrics.queueSize} operations pending');
    }
    
    // Log warning if processing seems stuck (only for actual stuck state)
    if (queueService.isStuck) {
      final processingDuration = queueService.processingDuration;
      Log.w('Database queue processing is stuck - processing for ${processingDuration?.inSeconds}s');
    }
  }

  /// Get current queue status
  QueueStatus getCurrentStatus() {
    final queueService = DatabaseQueueService();
    return QueueStatus(
      queueSize: queueService.queueSize,
      isProcessing: queueService.isProcessing,
      averageQueueSize: _calculateAverageQueueSize(),
      maxQueueSize: _calculateMaxQueueSize(),
    );
  }

  /// Calculate average queue size over recent history
  double _calculateAverageQueueSize() {
    if (_metricsHistory.isEmpty) return 0.0;
    
    final recentMetrics = _metricsHistory.length > 10 
        ? _metricsHistory.sublist(_metricsHistory.length - 10)
        : _metricsHistory;
    final total = recentMetrics.fold<int>(0, (sum, metric) => sum + metric.queueSize);
    return total / recentMetrics.length;
  }

  /// Calculate maximum queue size over recent history
  int _calculateMaxQueueSize() {
    if (_metricsHistory.isEmpty) return 0;
    
    return _metricsHistory
        .map((m) => m.queueSize)
        .reduce((a, b) => a > b ? a : b);
  }

  /// Get performance statistics
  PerformanceStats getPerformanceStats() {
    return PerformanceStats(
      totalMeasurements: _metricsHistory.length,
      averageQueueSize: _calculateAverageQueueSize(),
      maxQueueSize: _calculateMaxQueueSize(),
      currentStatus: getCurrentStatus(),
    );
  }

  /// Dispose resources
  void dispose() {
    stopMonitoring();
    _metricsHistory.clear();
  }
}

/// Queue metrics data class
class QueueMetrics {
  final DateTime timestamp;
  final int queueSize;
  final bool isProcessing;

  QueueMetrics({
    required this.timestamp,
    required this.queueSize,
    required this.isProcessing,
  });
}

/// Current queue status
class QueueStatus {
  final int queueSize;
  final bool isProcessing;
  final double averageQueueSize;
  final int maxQueueSize;

  QueueStatus({
    required this.queueSize,
    required this.isProcessing,
    required this.averageQueueSize,
    required this.maxQueueSize,
  });

  @override
  String toString() {
    return 'QueueStatus(queueSize: $queueSize, isProcessing: $isProcessing, avgSize: ${averageQueueSize.toStringAsFixed(1)}, maxSize: $maxQueueSize)';
  }
}

/// Performance statistics
class PerformanceStats {
  final int totalMeasurements;
  final double averageQueueSize;
  final int maxQueueSize;
  final QueueStatus currentStatus;

  PerformanceStats({
    required this.totalMeasurements,
    required this.averageQueueSize,
    required this.maxQueueSize,
    required this.currentStatus,
  });

  @override
  String toString() {
    return 'PerformanceStats(measurements: $totalMeasurements, avgSize: ${averageQueueSize.toStringAsFixed(1)}, maxSize: $maxQueueSize, current: $currentStatus)';
  }
}
