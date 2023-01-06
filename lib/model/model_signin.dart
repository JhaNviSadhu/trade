import 'dart:convert';

ModelSignin modelSiginFromMap(String str) =>
    ModelSignin.fromMap(json.decode(str));

String modelSiginToMap(ModelSignin data) => json.encode(data.toMap());

class ModelSignin {
  ModelSignin({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory ModelSignin.fromMap(Map<String, dynamic> json) => ModelSignin(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.countryShortCode,
    this.countryCode,
    this.mobile,
    this.profileImage,
    this.referCode,
    this.notificationFlag,
    this.tradeCount,
    this.token,
    this.socialLogin,
  });

  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? countryShortCode;
  String? countryCode;
  String? mobile;
  String? profileImage;
  String? referCode;
  String? notificationFlag;
  int? tradeCount;
  String? token;
  int? socialLogin;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        countryShortCode: json["country_short_code"] == null
            ? null
            : json["country_short_code"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        profileImage:
            json["profile_image"] == null ? null : json["profile_image"],
        referCode: json["refer_code"] == null ? null : json["refer_code"],
        notificationFlag: json["notification_flag"] == null
            ? null
            : json["notification_flag"],
        tradeCount: json["trade_count"] == null ? null : json["trade_count"],
        token: json["token"] == null ? null : json["token"],
        socialLogin: json["social_login"] == null ? null : json["social_login"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "country_short_code":
            countryShortCode == null ? null : countryShortCode,
        "country_code": countryCode == null ? null : countryCode,
        "mobile": mobile == null ? null : mobile,
        "profile_image": profileImage == null ? null : profileImage,
        "refer_code": referCode == null ? null : referCode,
        "notification_flag": notificationFlag == null ? null : notificationFlag,
        "trade_count": tradeCount == null ? null : tradeCount,
        "token": token == null ? null : token,
        "social_login": socialLogin == null ? null : socialLogin,
      };
}
