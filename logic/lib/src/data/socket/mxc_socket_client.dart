import 'dart:async';
import 'package:mxc_logic/src/data/socket/phoenix/phoenix_client.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

abstract class IMXCSocketClient {
  Future<bool> connect(String url);
  bool isConnected();
  void disconnect();
  Future<Stream<Message>?> subscribeToEvent(
    String event,
  );
  String get endpoint;

  Stream<dynamic>? getCloseStream();
}

class MXCSocketClient {
  MXCSocketClient._internal();

  factory MXCSocketClient() {
    return _singleton;
  }

  static final MXCSocketClient _singleton = MXCSocketClient._internal();

  IMXCSocketClient? _socketClient;

  void initialize() {
    _socketClient = PhoenixClient();
  }

  bool isConnected() {
    return _socketClient!.isConnected();
  }

  Stream<dynamic>? getCloseStream() {
    return _socketClient!.getCloseStream();
  }

  Future<bool> connect(String web3WebSocketUrl) async {
    if (_socketClient!.endpoint.isEmpty) {
      // not connected at all
      return await _socketClient!.connect(web3WebSocketUrl);
    } else if (isConnected() && _socketClient!.endpoint == web3WebSocketUrl) {
      // request to connect to same url
      return true;
    } else {
      // connect with new url
      _socketClient!.disconnect();
      return await _socketClient!.connect(web3WebSocketUrl);
    }
  }

  void disconnect() async {
    if (_socketClient != null) {
      _socketClient!.disconnect();
    }
  }

  Future<Stream<Message>?> subscribeToEvent(
    String event,
  ) async {
    return _socketClient!.subscribeToEvent(event);
  }
}
