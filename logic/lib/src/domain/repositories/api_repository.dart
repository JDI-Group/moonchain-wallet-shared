// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/contract_locator.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/contract_service.dart';

import 'wallet/address.dart';

class ApiRepository {
  ApiRepository({
    required this.authStorageRepository,
  });

  final AuthenticationStorageRepository authStorageRepository;

  AddressService get address => AddressService(authStorageRepository);

  Future<ContractService> get contract async =>
      (await ContractLocator.setup()).getInstance(NetworkType.Wannsee);
}
