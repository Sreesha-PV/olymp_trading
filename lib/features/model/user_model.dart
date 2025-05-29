class UserData {
  int? userId;
  String? userUuid;
  String? email;
  String? name;

  UserData({this.userId, this.userUuid, this.email, this.name});

  UserData.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    userId = data['user_id'];
    userUuid = data['user_uuid'];
    email = data['email'];
    name = data['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['user_uuid'] = userUuid;
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}
