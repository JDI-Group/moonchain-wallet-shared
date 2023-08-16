import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/data/data.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/nft_contract.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/token_contract.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/tweets.dart';

import 'wallet/wallet_address.dart';

class Web3Repository {
  Web3Repository({
    required DatadashSetupStore setupStore,
  }) : _setupStore = setupStore;

  final DatadashSetupStore _setupStore;

  DatadashClient get _web3client => DatadashClient(
        getNetwork: () =>
            _setupStore.getNetwork ??
            Network.fixedNetworks().where((item) => item.enabled).first,
      );

  WalletAddressRepoistory get walletAddress => const WalletAddressRepoistory();

  TokenContractRepository get tokenContract =>
      TokenContractRepository(_web3client);

  NftContractRepository get nftContract => NftContractRepository(_web3client);

  TweetsRepository get tweetsRepository => TweetsRepository(_web3client);
}
