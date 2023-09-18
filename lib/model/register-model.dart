class RegisterModel {
  bool? success;
  bool? error;
  String? message;
  Details? details;

  RegisterModel({this.success, this.error, this.message, this.details});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    message = json['message'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  String? loginId;
  String? name;
  String? place;
  String? adress;
  String? contact;
  String? sId;
  int? iV;

  Details(
      {this.loginId,
        this.name,
        this.place,
        this.adress,
        this.contact,
        this.sId,
        this.iV});

  Details.fromJson(Map<String, dynamic> json) {
    loginId = json['login_id'];
    name = json['Name'];
    place = json['Place'];
    adress = json['Adress'];
    contact = json['Contact'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_id'] = this.loginId;
    data['Name'] = this.name;
    data['Place'] = this.place;
    data['Adress'] = this.adress;
    data['Contact'] = this.contact;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}