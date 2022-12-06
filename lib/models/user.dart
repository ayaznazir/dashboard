class User {
  String? token;
  Status? status;

  User({this.token, this.status});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class Status {
  bool? success;
  int? code;
  String? message;

  Status({this.success, this.code, this.message});

  Status.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    code = json['Code'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Code'] = this.code;
    data['Message'] = this.message;
    return data;
  }
}