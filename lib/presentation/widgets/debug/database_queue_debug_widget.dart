import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/service/database_monitor_service.dart';
import 'package:flex_sense/data/service/database_queue_service.dart';

/// Debug widget to monitor database queue status
/// Only show in debug mode
class DatabaseQueueDebugWidget extends StatefulWidget {
  const DatabaseQueueDebugWidget({super.key});

  @override
  State<DatabaseQueueDebugWidget> createState() => _DatabaseQueueDebugWidgetState();
}

class _DatabaseQueueDebugWidgetState extends State<DatabaseQueueDebugWidget> {
  Timer? _updateTimer;
  QueueStatus? _currentStatus;
  PerformanceStats? _performanceStats;

  @override
  void initState() {
    super.initState();
    _startPeriodicUpdate();
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  void _startPeriodicUpdate() {
    _updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentStatus = serviceLocator.get<DatabaseMonitorService>().getCurrentStatus();
          _performanceStats = serviceLocator.get<DatabaseMonitorService>().getPerformanceStats();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Only show in debug mode
    if (!kDebugMode) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 50,
      right: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'DB Queue Status',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            if (_currentStatus != null) ...[
              _buildStatusRow('Queue Size', _currentStatus!.queueSize.toString()),
              _buildStatusRow('Processing', _currentStatus!.isProcessing ? 'Yes' : 'No'),
              _buildStatusRow('Avg Size', _currentStatus!.averageQueueSize.toStringAsFixed(1)),
              _buildStatusRow('Max Size', _currentStatus!.maxQueueSize.toString()),
            ],
            const SizedBox(height: 4),
            if (_performanceStats != null) ...[
              _buildStatusRow('Measurements', _performanceStats!.totalMeasurements.toString()),
            ],
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: _flushQueue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(60, 24),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  child: const Text(
                    'Flush',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 4),
                ElevatedButton(
                  onPressed: _clearDatabase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(60, 24),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  child: const Text(
                    'Clear',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
        Text(
          value,
          style: TextStyle(
            color: _getValueColor(label, value),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getValueColor(String label, String value) {
    if (label == 'Queue Size') {
      final size = int.tryParse(value) ?? 0;
      if (size > 100) return Colors.red;
      if (size > 50) return Colors.orange;
      return Colors.green;
    }
    if (label == 'Processing' && value == 'Yes') return Colors.blue;
    return Colors.white;
  }

  void _flushQueue() async {
    await serviceLocator.get<DatabaseQueueService>().flushQueue();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Database queue flushed'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _clearDatabase() async {
    await serviceLocator.get<DatabaseQueueService>().clearAllData();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Database cleared - restart app to apply new schema'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

/// Overlay widget to show database queue status
class DatabaseQueueOverlay extends StatefulWidget {
  final Widget child;

  const DatabaseQueueOverlay({
    super.key,
    required this.child,
  });

  @override
  State<DatabaseQueueOverlay> createState() => _DatabaseQueueOverlayState();
}

class _DatabaseQueueOverlayState extends State<DatabaseQueueOverlay> {
  bool _showDebugWidget = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_showDebugWidget) const DatabaseQueueDebugWidget(),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showDebugWidget = !_showDebugWidget;
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bug_report,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
