import 'package:equatable/equatable.dart';

class BalanceData extends Equatable {
  const BalanceData({required this.timeStamp, required this.balance});

  final DateTime timeStamp;
  final double balance;

  @override
  List<Object?> get props {
    return [
      timeStamp,
      balance
    ];
  }
}
