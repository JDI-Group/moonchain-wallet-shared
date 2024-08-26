class Nft {
  const Nft({
    required this.address,
    required this.tokenId,
    required this.image,
    required this.name,
  });

  final String address;
  final int tokenId;
  final String? image;
  final String name;
}
