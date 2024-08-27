class LoginModel {
  bool? status;
  String? message;
  Record? record;

  LoginModel({this.status, this.message, this.record});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    record =
    json['record'] != null ? new Record.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.record != null) {
      data['record'] = this.record!.toJson();
    }
    return data;
  }
}

class Record {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? profileImg;
  String? authtoken;

  Record(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.profileImg,
        this.authtoken});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    profileImg = json['profileImg'];
    authtoken = json['authtoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['profileImg'] = this.profileImg;
    data['authtoken'] = this.authtoken;
    return data;
  }
}