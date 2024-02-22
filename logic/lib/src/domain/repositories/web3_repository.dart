import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/data/data.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/app_version.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/dapp_store.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/epoch.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/miner.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/nft_contract.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/pricing.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/chains.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/token_contract.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/transaction_controller.dart';
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

  TransactionControllerRepository get transactionController =>
      TransactionControllerRepository(_web3client);

  NftContractRepository get nftContract => NftContractRepository(_web3client);

  TweetsRepository get tweetsRepository => TweetsRepository(_web3client);

  PricingRepository get pricingRepository => PricingRepository(_web3client);

  DappStoreRepository get dappStoreRepository =>
      DappStoreRepository(_web3client);

  AppVersionRepository get appVersionRepository =>
      AppVersionRepository(_web3client);

  ChainsRepository get chainsRepository => ChainsRepository(_web3client);

  MinerRepository get minerRepository =>
      MinerRepository(_web3client, epochRepository, tokenContract);

  EpochRepository get epochRepository => EpochRepository(_web3client);
}
