class Account {
  Account({
    required this.name,
    required this.privateKey,
    required this.address,
    this.mns,
    required this.isCustom,
    // this.alias
  });

  /// Use this as index for added accounts.
  String name;
  String privateKey;
  String address;
  String? mns;

  /// Means Is It imported.
  bool isCustom;
  // String? alias;
}
