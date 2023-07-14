// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/contract_locator.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/contract.dart';

import 'wallet/wallet_address.dart';

class Web3Repository {
  Web3Repository() : _constracts = ContractLocator.setup();

  final ContractLocator _constracts;

  WalletAddressRepoistory get walletAddress => const WalletAddressRepoistory();

  ContractRepository get contract => _constracts.getInstance(NetworkType.Wannsee);
}
