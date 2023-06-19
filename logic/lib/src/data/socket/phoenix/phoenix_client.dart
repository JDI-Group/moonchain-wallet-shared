import 'package:mxc_logic/src/data/socket/phoenix/phoenix_exception.dart';
import 'package:mxc_logic/src/data/socket/mxc_socket_client.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

class PhoenixClient implements IMXCSocketClient {
  PhoenixClient._internal();

  /// Singleton Phoenix Client, Use connect for initializing the connection and unlock features otherwise you will get PhoenixSocketNotConnected Error.
  /// with a Phoenix backend using WebSockets.
  factory PhoenixClient() {
    return _singleton;
  }
  static final PhoenixClient _singleton = PhoenixClient._internal();

  PhoenixSocket? _socketInstance;

  @override
  bool isConnected() => _socketInstance?.isConnected ?? false;

  /// Connects and initializes the socket instance if was not initialized before.
  @override
  Future<bool> connect(String url) async {
    final newSocket = await PhoenixSocket(url).connect();

    if (newSocket != null) {
      _socketInstance == null;
      _socketInstance = newSocket;
      return true;
    } else {
      return false;
    }
  }

  @override
  void disconnect() async {
    if (isConnected()) {
      _socketInstance!.close();
    }
  }

  @override
  void subscribeToEvent(
      String event, void Function(Message event) listeningCallBack) async {
    if (_socketInstance == null) {
      throw PhoenixSocketNotInitialized(null, "subscribeToEvent");
    }

    if (!isConnected()) {
      throw PhoenixSocketNotConnected(
          Uri.parse(_socketInstance!.endpoint), "subscribeToEvent");
    }

    final subscription = _socketInstance!.addChannel(
      topic: event,
    );

    final subscriptionResponse = await subscription.join().future;

    if (subscriptionResponse.isOk) {
      subscription.messages.listen((event) {
        listeningCallBack(event);
      });
    }
  }
}
