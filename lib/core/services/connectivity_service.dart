
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();
  
  bool _isConnected = true;
  
  // Stream to listen to connectivity changes
  Stream<bool> get connectionStream => _connectionController.stream;
  
  // Get current connection status
  bool get isConnected => _isConnected;
  
  // Initialize connectivity monitoring
  Future<void> init() async {
    // Check initial connection status
    _isConnected = await checkConnection();
    _connectionController.add(_isConnected);

    // Listen for connectivity changes
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  // Check current connection status
  Future<bool> checkConnection() async {
    try {
      final ConnectivityResult result = await _connectivity.checkConnectivity();
      return _hasConnection(result);
    } catch (_) {
      return false;
    }
  }

  // Update connection status when changed
  void _updateConnectionStatus(ConnectivityResult result) {
    final bool hasConnection = _hasConnection(result);
    if (_isConnected != hasConnection) {
      _isConnected = hasConnection;
      _connectionController.add(_isConnected);
    }
  }

  // Check if any connection exists
  bool _hasConnection(ConnectivityResult result) {
    return result != ConnectivityResult.none;
  }

  // Check if connected to WiFi
  Future<bool> isWiFi() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi;
  }

  // Check if connected to Mobile Data
  Future<bool> isMobileData() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    return result == ConnectivityResult.mobile;
  }
  
  // Dispose resources
  void dispose() {
    _connectionController.close();
  }
}