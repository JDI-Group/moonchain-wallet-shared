import 'package:equatable/equatable.dart';

class WannseeBalanceModel extends Equatable {
  String? balance;

  WannseeBalanceModel({this.balance});

  WannseeBalanceModel.fromJson(Map<String, dynamic> json) {
    balance = json['balance'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    return data;
  }

  @override
  List<Object?> get props => [balance];
}
