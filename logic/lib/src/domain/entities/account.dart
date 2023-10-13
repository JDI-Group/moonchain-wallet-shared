class Account {
  Account({
    required this.name,
    required this.privateKey,
    required this.address,
    this.mns,
    required this.isCustom,
    // this.alias
  });

  String name;
  String privateKey;
  String address;
  String? mns;
  /// If -1 then It is the import account
  bool isCustom;
  // String? alias;
}
