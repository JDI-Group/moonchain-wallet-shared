class MXCUrls {
  static String extractCIDFromUrl(String ipfsUrl) {
    if (ipfsUrl.startsWith('ipfs://')) {
      String cid = ipfsUrl.substring(7);
      return cid;
    } else {
      throw ('Invalid IPFS URL');
    }
  }
}
