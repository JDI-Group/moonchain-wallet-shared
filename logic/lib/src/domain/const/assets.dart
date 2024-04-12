class Assets {
  static const String mxcLogic = 'mxc_logic';

  static const String dappStoreJson =
      'packages/$mxcLogic/assets/cache/MEP-1759-DApp-store/dapp-store.json';
  static String dappStore(String dappName) =>
      'packages/$mxcLogic/assets/cache/MEP-1759-DApp-store/dapp_store/$dappName';
  static String dappsThumbnail(String image) =>
      'packages/$mxcLogic/assets/cache/MEP-1759-DApp-store/mxc_dapps_thumbnails/$image.png';
}
