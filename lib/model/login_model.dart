  class LoginModel {
  bool? success;
  bool? error;
  String? token;
  int? expiresIn;
  String? loginId;
  int? userRole;
  String? userName;

  LoginModel(
  {this.success,
  this.error,
  this.token,
  this.expiresIn,
  this.loginId,
  this.userRole,
  this.userName});

  LoginModel.fromJson(Map<String, dynamic> json) {
  success = json['success'];
  error = json['error'];
  token = json['token'];
  expiresIn = json['expiresIn'];
  loginId = json['loginId'];
  userRole = json['userRole'];
  userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['success'] = this.success;
  data['error'] = this.error;
  data['token'] = this.token;
  data['expiresIn'] = this.expiresIn;
  data['loginId'] = this.loginId;
  data['userRole'] = this.userRole;
  data['userName'] = this.userName;
  return data;
  }
  }
