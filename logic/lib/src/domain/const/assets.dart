class Assets {
  static const String mxcLogic = 'mxc_logic';

  static const String dappStorePath =
      'packages/$mxcLogic/assets/cache/MEP-1759-DApp-store/';
  static const String dappStoreJson = '${dappStorePath}dapp-store.json';
  static String dappStore(String dappName) =>
      '${dappStorePath}dapp_store/$dappName';
  static String dappsThumbnail(String image) =>
      '${dappStorePath}mxc_dapps_thumbnails/$image.png';

  static const String tokenListPath =
      'packages/$mxcLogic/assets/cache/wannseeswap-tokenlist/';
  static const String tokenListAssetsPath = '${tokenListPath}assets/';
  static const String moonchainTokenListPath =
      '${tokenListPath}tokenlist-mainnet.json';
  static const String genevaTokenListPath = '${tokenListPath}tokenlist.json';
  static const String ethereumTokenListPath =
      '${tokenListPath}tokenlist-ethereum.json';
}
