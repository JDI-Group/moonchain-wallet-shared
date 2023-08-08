enum TokenType { erc_20, erc_721, erc_1155 }

extension TokenTypeExtension on TokenType {
  String toStringValue() {
    switch (this) {
      case TokenType.erc_20:
        return 'ERC-20';
      case TokenType.erc_721:
        return 'ERC-721';
      case TokenType.erc_1155:
        return 'ERC-1155';
      default:
        return 'Unknown';
    }
  }
}
