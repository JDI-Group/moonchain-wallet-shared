class TransactionPriorityFeeEstimation {
  const TransactionPriorityFeeEstimation({
    required this.maxFeePerGas,
    required this.maxPriorityFeePerGas,
  });

  /// The maximum fee user is willing to spend extra on each unit of gas
  final double maxPriorityFeePerGas;

  /// The maximum fee user willing to spend on each unit of gas
  final double maxFeePerGas;

  /// Returns a copy of this object with the specified fields updated.
  TransactionPriorityFeeEstimation copyWith({
    double? maxFeePerGas,
    double? maxPriorityFeePerGas,
  }) {
    return TransactionPriorityFeeEstimation(
      maxFeePerGas: maxFeePerGas ?? this.maxFeePerGas,
      maxPriorityFeePerGas: maxPriorityFeePerGas ?? this.maxPriorityFeePerGas,
    );
  }
}
