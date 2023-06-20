import 'package:mxc_logic/src/data/socket/phoenix/phoenix_client.dart';
import 'package:mxc_logic/src/domain/entities/network_type.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/app_config.dart';

abstract class IMXCSocketClient {
  Future<bool> connect(String url);
  bool isConnected();
  void disconnect();
  void subscribeToEvent(
    String event,
    void Function(Object event) listeningCallBack,
  );
}

class MXCSocketClient {
  MXCSocketClient._internal();

  factory MXCSocketClient() {
    return _singleton;
  }

  static final MXCSocketClient _singleton = MXCSocketClient._internal();

  NetworkType? _networkType;

  IMXCSocketClient? _socketClient;

  void initialize(NetworkType networkType) {
    _networkType = networkType;
    updateClient();
  }

  bool isConnected() {
    return _socketClient!.isConnected();
  }

  Future<bool> connect() async {
    print('_networkType!.name' + _networkType.toString());
    return _socketClient!
        .connect((AppConfig.networks[_networkType])!.web3WebSocketUrl);
  }

  void disconnect() async {
    _socketClient!.disconnect();
  }

  void subscribeToEvent(
    String event,
    void Function(dynamic event) listeningCallBack,
  ) async {
    _socketClient!.subscribeToEvent(event, listeningCallBack);
  }

  // This will return the corresponding websocket client
  void updateClient() {
    switch (_networkType) {
      case NetworkType.Wannsee:
        _socketClient = PhoenixClient();
        break;
      default:
        _socketClient = PhoenixClient();
        break;
    }
  }
}
