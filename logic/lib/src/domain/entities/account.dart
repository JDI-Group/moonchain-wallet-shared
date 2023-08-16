class Account {
  Account({
    required this.name,
    required this.privateKey,
    required this.address,
    this.mns,
  });

  String name;
  String privateKey;
  String address;
  String? mns;
}
