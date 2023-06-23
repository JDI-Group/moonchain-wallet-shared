class WannseeBalanceModel {
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
}
