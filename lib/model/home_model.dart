class HomeModel {
  bool? status;
  String? message;
  List<UserList>? userList;
  int? currentPage;
  int? lastPage;
  int? total;
  int? perPage;

  HomeModel(
      {this.status,
        this.message,
        this.userList,
        this.currentPage,
        this.lastPage,
        this.total,
        this.perPage});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['userList'] != null) {
      userList = <UserList>[];
      json['userList'].forEach((v) {
        userList!.add(new UserList.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    lastPage = json['lastPage'];
    total = json['total'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userList != null) {
      data['userList'] = this.userList!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['lastPage'] = this.lastPage;
    data['total'] = this.total;
    data['perPage'] = this.perPage;
    return data;
  }
}

class UserList {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phoneNo;
  String? status;

  UserList(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.countryCode,
        this.phoneNo,
        this.status});

  UserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    countryCode = json['country_code'];
    phoneNo = json['phone_no'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone_no'] = this.phoneNo;
    data['status'] = this.status;
    return data;
  }
}