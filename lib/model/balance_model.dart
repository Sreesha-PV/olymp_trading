class Balance{
  double? availableBalance;

  Balance({this.availableBalance});

  Balance.fromJson(Map<String, dynamic> json) {
    var data = json["data"];
    availableBalance = data['available_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available_balance'] = this.availableBalance;
    return data;
  }
}



