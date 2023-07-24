import 'package:http/http.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/src/domain/entities/network_type.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:ens_dart/ens_dart.dart';

import '../../utils/contract_parser.dart';
import 'app_config.dart';
import 'contract.dart';

class ContractLocator {
  ContractLocator._();

  static Map<NetworkType, ContractRepository> instance =
      <NetworkType, ContractRepository>{};

  static ContractLocator setup() {
    for (final network in NetworkType.enabledValues) {
      instance[network] = createInstance(network.config);
    }

    return ContractLocator._();
  }

  ContractRepository getInstance(NetworkType network) {
    return instance[network]!;
  }

  static ContractRepository createInstance(AppConfigParams networkConfig) {
    final rpcWSAddress = networkConfig.web3RpcWebsocketUrl;
    final web3client = Web3Client(
      networkConfig.web3RpcHttpUrl,
      Client(),
      socketConnector: rpcWSAddress != null
          ? () {
              return IOWebSocketChannel.connect(rpcWSAddress).cast<String>();
            }
          : null,
    );

    return ContractRepository(
      web3client,
      RestClient(),
      networkConfig: networkConfig,
      contract: null,
    );
  }
}
