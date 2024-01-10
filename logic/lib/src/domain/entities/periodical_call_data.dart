import 'dart:convert';

// Most frequent 15M~ 15
// Very frequent 1H~ 60
// Frequent 3H~ 180
// Infrequent 6H~ 360
// Very infrequent 12H~ 720
// Least frequent 24H~ 1440

enum PeriodicalCallDuration {
  mostFrequent,
  veryFrequent,
  frequent,
  inFrequent,
  veryInFrequent,
  leastFrequent
}

extension PeriodicalCallDurationExtension on PeriodicalCallDuration {
  String toStringFormatted() {
    String enumString = name.split('.').last; // Remove the enum type prefix
    final time = getPeriodicalCallDurationHint(enumString);
    List<String> words =
        enumString.split(RegExp('(?=[A-Z])')); // Split by capital letters
    String result = words
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
    return '$result $time';
  }

  int toMinutes() => getPeriodicalCallDurationMinute(name);
}

String getPeriodicalCallDurationHint(String enumString) {
  late String result;

  if (enumString == PeriodicalCallDuration.mostFrequent.name) {
    result = '~15 M';
  } else if (enumString == PeriodicalCallDuration.veryFrequent.name) {
    result = '~1 H';
  } else if (enumString == PeriodicalCallDuration.frequent.name) {
    result = '~3 H';
  } else if (enumString == PeriodicalCallDuration.inFrequent.name) {
    result = '~6 H';
  } else if (enumString == PeriodicalCallDuration.veryInFrequent.name) {
    result = '~12 H';
  } else if (enumString == PeriodicalCallDuration.leastFrequent.name) {
    result = '~24 H';
  } else {
    result = 'Unknown';
  }
  return result;
}

int getPeriodicalCallDurationMinute(String enumString) {
  late int result;

  if (enumString == PeriodicalCallDuration.mostFrequent.name) {
    result = 15;
  } else if (enumString == PeriodicalCallDuration.veryFrequent.name) {
    result = 60;
  } else if (enumString == PeriodicalCallDuration.frequent.name) {
    result = 180;
  } else if (enumString == PeriodicalCallDuration.inFrequent.name) {
    result = 360;
  } else if (enumString == PeriodicalCallDuration.veryInFrequent.name) {
    result = 720;
  } else if (enumString == PeriodicalCallDuration.leastFrequent.name) {
    result = 1440;
  } else {
    result = 0;
  }
  return result;
}

class PeriodicalCallData {
  factory PeriodicalCallData.getDefault() => PeriodicalCallData(
      lowBalanceLimit: 1000,
      expectedGasPrice: 300,
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

  // In MXC
  double lowBalanceLimit;
  // In MXC
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
