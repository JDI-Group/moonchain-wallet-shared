import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

@internal
class DatadashClient extends Web3Client {
  DatadashClient._({
    required String Function() getRpcHttpUrl,
    required String Function() getRpcWebsocketUrl,
  })  : _getRpcHttpUrl = getRpcHttpUrl,
        _getRpcWebsocketUrl = getRpcWebsocketUrl,
        super(
          getRpcHttpUrl(),
          Client(),
          socketConnector: () {
            return IOWebSocketChannel.connect(getRpcWebsocketUrl())
                .cast<String>();
          },
        );

  factory DatadashClient({
    required String Function() getRpcWebsocketUrl,
    required String Function() getRpcHttpUrl,
  }) {
    return DatadashClient._(
      getRpcWebsocketUrl: getRpcWebsocketUrl,
      getRpcHttpUrl: getRpcHttpUrl,
    );
  }

  final String Function() _getRpcWebsocketUrl;
  final String Function() _getRpcHttpUrl;

  String? get rpcWebsocketUrl => _getRpcWebsocketUrl();

  String? get rpcHttpUrl => _getRpcHttpUrl();
}
