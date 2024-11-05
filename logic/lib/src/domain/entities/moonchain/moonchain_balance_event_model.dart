import 'package:equatable/equatable.dart';

class MoonchainBalanceEvenModel extends Equatable {

  factory MoonchainBalanceEvenModel.fromJson(Map<String, dynamic> json,) {
    return MoonchainBalanceEvenModel(balance: json['balance'] as String);
  }

  const MoonchainBalanceEvenModel({this.balance});
  final String? balance;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    return data;
  }

  @override
  List<Object?> get props => [balance];
}
