import 'dart:convert';

enum PeriodicalCallDuration { fifteen }

class PeriodicalCallData {
  factory PeriodicalCallData.getDefault() => PeriodicalCallData(
      lowBalanceLimit: 10,
      expectedGasPrice: 600000,
      lasEpoch: 0,
      expectedEpochOccurrence: 6,
      duration: 15,
      lowBalanceLimitEnabled: false,
      expectedGasPriceEnabled: false,
      expectedEpochOccurrenceEnabled: false);
  factory PeriodicalCallData.fromJson(String source) =>
      PeriodicalCallData.fromMap(json.decode(source));

  factory PeriodicalCallData.fromMap(Map<String, dynamic> map) {
    return PeriodicalCallData(
      lowBalanceLimit: map['lowBalanceLimit']?.toDouble() ?? 0.0,
      expectedGasPrice: map['expectedGasPrice']?.toDouble() ?? 0.0,
      lasEpoch: map['lasEpoch']?.toInt() ?? 0,
      expectedEpochOccurrence: map['expectedEpochOccurrence']?.toInt() ?? 0,
      duration: map['duration']?.toInt() ?? 0,
      lowBalanceLimitEnabled: map['lowBalanceLimitEnabled'] ?? false,
      expectedGasPriceEnabled: map['expectedGasPriceEnabled'] ?? false,
      expectedEpochOccurrenceEnabled:
          map['expectedEpochOccurrenceEnabled'] ?? false,
    );
  }
  PeriodicalCallData({
    required this.lowBalanceLimit,
    required this.expectedGasPrice,
    required this.lasEpoch,
    required this.expectedEpochOccurrence,
    required this.duration,
    required this.lowBalanceLimitEnabled,
    required this.expectedGasPriceEnabled,
    required this.expectedEpochOccurrenceEnabled,
  });

  // Should have defaults
  double lowBalanceLimit;
  // Gwei
  double expectedGasPrice;
  int lasEpoch;
  int expectedEpochOccurrence;
  // Minutes
  int duration;

  /// Defaults to false
  bool lowBalanceLimitEnabled;
  bool expectedGasPriceEnabled;
  bool expectedEpochOccurrenceEnabled;

  PeriodicalCallData copyWith({
    double? lowBalanceLimit,
    double? expectedGasPrice,
    int? lasEpoch,
    int? expectedEpochOccurrence,
    int? duration,
    bool? lowBalanceLimitEnabled,
    bool? expectedGasPriceEnabled,
    bool? expectedEpochOccurrenceEnabled,
  }) {
    return PeriodicalCallData(
      lowBalanceLimit: lowBalanceLimit ?? this.lowBalanceLimit,
      expectedGasPrice: expectedGasPrice ?? this.expectedGasPrice,
      lasEpoch: lasEpoch ?? this.lasEpoch,
      expectedEpochOccurrence:
          expectedEpochOccurrence ?? this.expectedEpochOccurrence,
      duration: duration ?? this.duration,
      lowBalanceLimitEnabled:
          lowBalanceLimitEnabled ?? this.lowBalanceLimitEnabled,
      expectedGasPriceEnabled:
          expectedGasPriceEnabled ?? this.expectedGasPriceEnabled,
      expectedEpochOccurrenceEnabled:
          expectedEpochOccurrenceEnabled ?? this.expectedEpochOccurrenceEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lowBalanceLimit': lowBalanceLimit,
      'expectedGasPrice': expectedGasPrice,
      'lasEpoch': lasEpoch,
      'expectedEpochOccurrence': expectedEpochOccurrence,
      'duration': duration,
      'lowBalanceLimitEnabled': lowBalanceLimitEnabled,
      'expectedGasPriceEnabled': expectedGasPriceEnabled,
      'expectedEpochOccurrenceEnabled': expectedEpochOccurrenceEnabled,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'PeriodicalCallData(lowBalanceLimit: $lowBalanceLimit, expectedGasPrice: $expectedGasPrice, lasEpoch: $lasEpoch, expectedEpochOccurrence: $expectedEpochOccurrence, duration: $duration, lowBalanceLimitEnabled: $lowBalanceLimitEnabled, expectedGasPriceEnabled: $expectedGasPriceEnabled, expectedEpochOccurrenceEnabled: $expectedEpochOccurrenceEnabled)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PeriodicalCallData &&
        other.lowBalanceLimit == lowBalanceLimit &&
        other.expectedGasPrice == expectedGasPrice &&
        other.lasEpoch == lasEpoch &&
        other.expectedEpochOccurrence == expectedEpochOccurrence &&
        other.duration == duration &&
        other.lowBalanceLimitEnabled == lowBalanceLimitEnabled &&
        other.expectedGasPriceEnabled == expectedGasPriceEnabled &&
        other.expectedEpochOccurrenceEnabled == expectedEpochOccurrenceEnabled;
  }

  @override
  int get hashCode {
    return lowBalanceLimit.hashCode ^
        expectedGasPrice.hashCode ^
        lasEpoch.hashCode ^
        expectedEpochOccurrence.hashCode ^
        duration.hashCode ^
        lowBalanceLimitEnabled.hashCode ^
        expectedGasPriceEnabled.hashCode ^
        expectedEpochOccurrenceEnabled.hashCode;
  }
}
