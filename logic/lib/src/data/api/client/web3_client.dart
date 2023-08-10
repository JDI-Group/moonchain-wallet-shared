import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

@internal
class DatadashClient extends Web3Client {
  DatadashClient._({
    required Network Function() getNetwork,
  })  : _getNetwork = getNetwork,
        super(
          getNetwork().web3RpcHttpUrl,
          Client(),
          socketConnector: () {
            return IOWebSocketChannel.connect(getNetwork().web3RpcWebsocketUrl)
                .cast<String>();
          },
        );

  factory DatadashClient({
    required Network Function() getNetwork,
  }) {
    return DatadashClient._(
      getNetwork: getNetwork,
    );
  }

  final Network Function() _getNetwork;

  Network? get network => _getNetwork();
}
