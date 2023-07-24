import 'package:mxc_logic/src/domain/entities/entities.dart';

class NFTCollection {
  const NFTCollection(
      {required this.address, required this.tokens, required this.name});

  final List<NFT> tokens;
  final String name;
  final String address;
}
