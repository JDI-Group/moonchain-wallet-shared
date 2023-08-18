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

  Future<bool> connect(String web3WebSocketUrl) async {
    return isConnected()
        ? true
        : await _socketClient!.connect(web3WebSocketUrl);
  }

  void disconnect() async {
    _socketClient!.disconnect();
  }

  Future<Stream<Message>?> subscribeToEvent(
    String event,
  ) async {
    return _socketClient!.subscribeToEvent(event);
  }
}
