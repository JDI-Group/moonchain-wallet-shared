import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/data/data.dart';
import 'package:mxc_logic/src/domain/repositories/chat/chat_repo.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/google_drive.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/icloud.dart';

import 'wallet/wallet.dart';
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

  NftContractRepository get nftContract => NftContractRepository(_web3client, storageContractRepository, minerRepository,);

  TweetsRepository get tweetsRepository => TweetsRepository(_web3client);

  PricingRepository get pricingRepository => PricingRepository(_web3client);

  DappStoreRepository get dappStoreRepository =>
      DappStoreRepository(_web3client);

  AppVersionRepository get appVersionRepository =>
      AppVersionRepository(_web3client);

  ChainsRepository get chainsRepository => ChainsRepository(_web3client);

  MinerRepository get minerRepository =>
      MinerRepository(_web3client, epochRepository, tokenContract);

  BlueberryRingRepository get blueberryRingRepository => BlueberryRingRepository(
        _web3client,
      );

  EpochRepository get epochRepository => EpochRepository(_web3client);

  LauncherRepository get launcherRepository => LauncherRepository(_web3client);

  IPFSRepository get ipfsRepository => IPFSRepository(_web3client);

  StorageContractRepository get storageContractRepository => StorageContractRepository(_web3client);

  GoogleDriveRepository get googleDriveRepository => GoogleDriveRepository(_web3client);

  ICloudRepository get iCloudRepository => ICloudRepository(_web3client);

  ChatRepository get chatRepository => ChatRepository(_web3client);
}
