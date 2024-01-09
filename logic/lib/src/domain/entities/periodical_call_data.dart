import 'dart:convert';

enum PeriodicalCallDuration { fifteen }

class PeriodicalCallData {
  factory PeriodicalCallData.getDefault() => PeriodicalCallData(
      lowBalanceLimit: 10,
      expectedGasPrice: 600000,
      lasEpoch: 0,
      expectedEpochQuantity: 6,
      duration: 15,
      lowBalanceLimitEnabled: false,
      expectedGasPriceEnabled: false,
      expectedEpochQuantityEnabled: false);
  factory PeriodicalCallData.fromJson(String source) =>
      PeriodicalCallData.fromMap(json.decode(source));

  factory PeriodicalCallData.fromMap(Map<String, dynamic> map) {
    return PeriodicalCallData(
      lowBalanceLimit: map['lowBalanceLimit']?.toDouble() ?? 0.0,
      expectedGasPrice: map['expectedGasPrice']?.toDouble() ?? 0.0,
      lasEpoch: map['lasEpoch']?.toInt() ?? 0,
      expectedEpochQuantity: map['expectedEpochQuantity']?.toInt() ?? 0,
      duration: map['duration']?.toInt() ?? 0,
      lowBalanceLimitEnabled: map['lowBalanceLimitEnabled'] ?? false,
      expectedGasPriceEnabled: map['expectedGasPriceEnabled'] ?? false,
      expectedEpochQuantityEnabled:
          map['expectedEpochQuantityEnabled'] ?? false,
    );
  }
  PeriodicalCallData({
    required this.lowBalanceLimit,
    required this.expectedGasPrice,
    required this.lasEpoch,
    required this.expectedEpochQuantity,
    required this.duration,
    required this.lowBalanceLimitEnabled,
    required this.expectedGasPriceEnabled,
    required this.expectedEpochQuantityEnabled,
  });

  // Should have defaults
  double lowBalanceLimit;
  // Gwei
  double expectedGasPrice;
  int lasEpoch;
  int expectedEpochQuantity;
  // Minutes
  int duration;

  /// Defaults to false
  bool lowBalanceLimitEnabled;
  bool expectedGasPriceEnabled;
  bool expectedEpochQuantityEnabled;

  PeriodicalCallData copyWith({
    double? lowBalanceLimit,
    double? expectedGasPrice,
    int? lasEpoch,
    int? expectedEpochQuantity,
    int? duration,
    bool? lowBalanceLimitEnabled,
    bool? expectedGasPriceEnabled,
    bool? expectedEpochQuantityEnabled,
  }) {
    return PeriodicalCallData(
      lowBalanceLimit: lowBalanceLimit ?? this.lowBalanceLimit,
      expectedGasPrice: expectedGasPrice ?? this.expectedGasPrice,
      lasEpoch: lasEpoch ?? this.lasEpoch,
      expectedEpochQuantity:
          expectedEpochQuantity ?? this.expectedEpochQuantity,
      duration: duration ?? this.duration,
      lowBalanceLimitEnabled:
          lowBalanceLimitEnabled ?? this.lowBalanceLimitEnabled,
      expectedGasPriceEnabled:
          expectedGasPriceEnabled ?? this.expectedGasPriceEnabled,
      expectedEpochQuantityEnabled:
          expectedEpochQuantityEnabled ?? this.expectedEpochQuantityEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lowBalanceLimit': lowBalanceLimit,
      'expectedGasPrice': expectedGasPrice,
      'lasEpoch': lasEpoch,
      'expectedEpochQuantity': expectedEpochQuantity,
      'duration': duration,
      'lowBalanceLimitEnabled': lowBalanceLimitEnabled,
      'expectedGasPriceEnabled': expectedGasPriceEnabled,
      'expectedEpochQuantityEnabled': expectedEpochQuantityEnabled,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'PeriodicalCallData(lowBalanceLimit: $lowBalanceLimit, expectedGasPrice: $expectedGasPrice, lasEpoch: $lasEpoch, expectedEpochQuantity: $expectedEpochQuantity, duration: $duration, lowBalanceLimitEnabled: $lowBalanceLimitEnabled, expectedGasPriceEnabled: $expectedGasPriceEnabled, expectedEpochQuantityEnabled: $expectedEpochQuantityEnabled)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PeriodicalCallData &&
        other.lowBalanceLimit == lowBalanceLimit &&
        other.expectedGasPrice == expectedGasPrice &&
        other.lasEpoch == lasEpoch &&
        other.expectedEpochQuantity == expectedEpochQuantity &&
        other.duration == duration &&
        other.lowBalanceLimitEnabled == lowBalanceLimitEnabled &&
        other.expectedGasPriceEnabled == expectedGasPriceEnabled &&
        other.expectedEpochQuantityEnabled == expectedEpochQuantityEnabled;
  }

  @override
  int get hashCode {
    return lowBalanceLimit.hashCode ^
        expectedGasPrice.hashCode ^
        lasEpoch.hashCode ^
        expectedEpochQuantity.hashCode ^
        duration.hashCode ^
        lowBalanceLimitEnabled.hashCode ^
        expectedGasPriceEnabled.hashCode ^
        expectedEpochQuantityEnabled.hashCode;
  }
}
