class ErrorMessages {
  /// If error happens with these messages then we will need to show receive bottom sheet
  static List<String> fundErrors = [
    // User doesn't have enough to pay for native token transfer
    // Zero native token balance or not enough for fee
    'gas required exceeds allowance',
    // Sending more than tokens balance
    'execution reverted: ERC20: transfer amount exceeds balance',
    // Sending more than native token balance
    'insufficient funds for gas * price + value',
    'insufficient funds for transfer',
  ];

  static List<String> errorList = [nonceTooLowError];

  static String nonceTooLowError = 'nonce too low';

  static Map<String, String> errorMessageMapper = {
    nonceTooLowError: 'transaction_finalized',
  };

  static List<String> ignoredErrors = ['already known'];
}
