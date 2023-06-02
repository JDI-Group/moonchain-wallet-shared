import 'package:mxc_logic/mxc_logic.dart';

import 'wallet/address.dart';

class ApiRepository {
  ApiRepository({required this.authStorageRepository});

  final AuthenticationStorageRepository authStorageRepository;

  AddressService get address => AddressService(authStorageRepository);
}
