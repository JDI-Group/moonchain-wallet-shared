import 'package:http/http.dart';
import 'package:mxc_logic/src/domain/entities/network_type.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import 'app_config.dart';
import 'contract_service.dart';

class ContractLocator {
  ContractLocator._();

  static Map<NetworkType, ContractService> instance =
      <NetworkType, ContractService>{};

  static Future<ContractLocator> setup() async {
    if (instance[NetworkType.Wannsee] == null) {
      for (final network in NetworkType.enabledValues) {
        instance[network] = await createInstance(network.config);
      }
    }

    return ContractLocator._();
  }

  ContractService getInstance(NetworkType network) {
    return instance[network]!;
  }

  static Future<ContractService> createInstance(
      AppConfigParams networkConfig) async {
    final rpcWSAddress = networkConfig.web3RpcWebsocketUrl;
    final client = Web3Client(
      networkConfig.web3RpcHttpUrl,
      Client(),
      socketConnector: rpcWSAddress != null
          ? () {
              return IOWebSocketChannel.connect(rpcWSAddress).cast<String>();
            }
          : null,
    );
    // every contract has a address to interact & also has an ABI
    // final contract = await ContractParser.fromAssets(
    //     'TargaryenCoin.json', networkConfig.contractAddress);

    return ContractService(client, contract: null);
  }
}
