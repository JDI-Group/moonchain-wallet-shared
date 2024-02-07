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

PeriodicalCallDuration getPeriodicalCallDurationFromInt(int duration) {
  late PeriodicalCallDuration result;

  switch (duration) {
    case 15:
      result = PeriodicalCallDuration.mostFrequent;
      break;
    case 60:
      result = PeriodicalCallDuration.veryFrequent;
      break;
    case 180:
      result = PeriodicalCallDuration.frequent;
      break;
    case 360:
      result = PeriodicalCallDuration.inFrequent;
      break;
    case 720:
      result = PeriodicalCallDuration.veryInFrequent;
      break;
    case 1440:
      result = PeriodicalCallDuration.leastFrequent;
      break;
    default:
      result = PeriodicalCallDuration.mostFrequent;
  }

  return result;
}

class PeriodicalCallData {
  factory PeriodicalCallData.getDefault() => PeriodicalCallData(
      serviceEnabled: false,
      lowBalanceLimit: 1000,
      expectedTransactionFee: 300,
      lasEpoch: 0,
      expectedEpochOccurrence: 6,
      duration: 15,
      lowBalanceLimitEnabled: false,
      expectedTransactionFeeEnabled: false,
      expectedEpochOccurrenceEnabled: false);
  factory PeriodicalCallData.fromJson(String source) =>
      PeriodicalCallData.fromMap(json.decode(source));

  factory PeriodicalCallData.fromMap(Map<String, dynamic> map) {
    return PeriodicalCallData(
      serviceEnabled: map['serviceEnabled'] ?? false,
      lowBalanceLimit: map['lowBalanceLimit'] as double? ?? 0,
      expectedTransactionFee: map['expectedTransactionFee'] as double? ?? 0,
      lasEpoch: map['lasEpoch'] as int? ?? 0,
      expectedEpochOccurrence: map['expectedEpochOccurrence'] as int? ?? 0,
      duration: map['duration'] as int? ?? 0,
      lowBalanceLimitEnabled: map['lowBalanceLimitEnabled'] ?? false,
      expectedTransactionFeeEnabled:
          map['expectedTransactionFeeEnabled'] ?? false,
      expectedEpochOccurrenceEnabled:
          map['expectedEpochOccurrenceEnabled'] ?? false,
    );
  }
  PeriodicalCallData({
    required this.serviceEnabled,
    required this.lowBalanceLimit,
    required this.expectedTransactionFee,
    required this.lasEpoch,
    required this.expectedEpochOccurrence,
    required this.duration,
    required this.lowBalanceLimitEnabled,
    required this.expectedTransactionFeeEnabled,
    required this.expectedEpochOccurrenceEnabled,
  });

  // In MXC
  double lowBalanceLimit;
  // In MXC
  double expectedTransactionFee;
  int lasEpoch;
  int expectedEpochOccurrence;
  // Minutes
  int duration;

  bool serviceEnabled;

  /// Defaults to false
  bool lowBalanceLimitEnabled;
  bool expectedTransactionFeeEnabled;
  bool expectedEpochOccurrenceEnabled;

  PeriodicalCallData copyWith({
    bool? serviceEnabled,
    double? lowBalanceLimit,
    double? expectedTransactionFee,
    int? lasEpoch,
    int? expectedEpochOccurrence,
    int? duration,
    bool? lowBalanceLimitEnabled,
    bool? expectedTransactionFeeEnabled,
    bool? expectedEpochOccurrenceEnabled,
  }) {
    return PeriodicalCallData(
      serviceEnabled: serviceEnabled ?? this.serviceEnabled,
      lowBalanceLimit: lowBalanceLimit ?? this.lowBalanceLimit,
      expectedTransactionFee:
          expectedTransactionFee ?? this.expectedTransactionFee,
      lasEpoch: lasEpoch ?? this.lasEpoch,
      expectedEpochOccurrence:
          expectedEpochOccurrence ?? this.expectedEpochOccurrence,
      duration: duration ?? this.duration,
      lowBalanceLimitEnabled:
          lowBalanceLimitEnabled ?? this.lowBalanceLimitEnabled,
      expectedTransactionFeeEnabled:
          expectedTransactionFeeEnabled ?? this.expectedTransactionFeeEnabled,
      expectedEpochOccurrenceEnabled:
          expectedEpochOccurrenceEnabled ?? this.expectedEpochOccurrenceEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceEnabled': serviceEnabled,
      'lowBalanceLimit': lowBalanceLimit,
      'expectedTransactionFee': expectedTransactionFee,
      'lasEpoch': lasEpoch,
      'expectedEpochOccurrence': expectedEpochOccurrence,
      'duration': duration,
      'lowBalanceLimitEnabled': lowBalanceLimitEnabled,
      'expectedTransactionFeeEnabled': expectedTransactionFeeEnabled,
      'expectedEpochOccurrenceEnabled': expectedEpochOccurrenceEnabled,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'PeriodicalCallData(serviceEnabled: $serviceEnabled, lowBalanceLimit: $lowBalanceLimit, expectedTransactionFee: $expectedTransactionFee, lasEpoch: $lasEpoch, expectedEpochOccurrence: $expectedEpochOccurrence, duration: $duration, lowBalanceLimitEnabled: $lowBalanceLimitEnabled, expectedTransactionFeeEnabled: $expectedTransactionFeeEnabled, expectedEpochOccurrenceEnabled: $expectedEpochOccurrenceEnabled)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PeriodicalCallData &&
        other.serviceEnabled == serviceEnabled &&
        other.lowBalanceLimit == lowBalanceLimit &&
        other.expectedTransactionFee == expectedTransactionFee &&
        other.lasEpoch == lasEpoch &&
        other.expectedEpochOccurrence == expectedEpochOccurrence &&
        other.duration == duration &&
        other.lowBalanceLimitEnabled == lowBalanceLimitEnabled &&
        other.expectedTransactionFeeEnabled == expectedTransactionFeeEnabled &&
        other.expectedEpochOccurrenceEnabled == expectedEpochOccurrenceEnabled;
  }

  @override
  int get hashCode {
    return serviceEnabled.hashCode ^
        lowBalanceLimit.hashCode ^
        expectedTransactionFee.hashCode ^
        lasEpoch.hashCode ^
        expectedEpochOccurrence.hashCode ^
        duration.hashCode ^
        lowBalanceLimitEnabled.hashCode ^
        expectedTransactionFeeEnabled.hashCode ^
        expectedEpochOccurrenceEnabled.hashCode;
  }
}
