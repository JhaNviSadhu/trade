import 'dart:convert';

ModelListTrade modelListTradeFromMap(String str) =>
    ModelListTrade.fromMap(json.decode(str));

String modelListTradeToMap(ModelListTrade data) => json.encode(data.toMap());

class ModelListTrade {
  ModelListTrade({
    this.status,
    this.message,
    this.data,
    this.newTrades,
  });

  int? status;
  String? message;
  List<Trade>? data;
  int? newTrades;

  factory ModelListTrade.fromMap(Map<String, dynamic> json) => ModelListTrade(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Trade>.from(json["data"].map((x) => Trade.fromMap(x))),
        newTrades: json["new_trades"] == null ? null : json["new_trades"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "new_trades": newTrades == null ? null : newTrades,
      };
}

class Trade {
  Trade({
    this.id,
    this.mentorId,
    this.type,
    this.entryPrice,
    this.name,
    this.stock,
    this.exitPrice,
    this.exitHigh,
    this.stopLossPrice,
    this.action,
    this.result,
    this.status,
    this.postedDate,
    this.fee,
    this.isSubscribe,
    this.user,
  });

  int? id;
  int? mentorId;
  String? type;
  int? entryPrice;
  String? name;
  String? stock;
  int? exitPrice;
  int? exitHigh;
  int? stopLossPrice;
  String? action;
  String? result;
  String? status;
  DateTime? postedDate;
  String? fee;
  int? isSubscribe;
  User? user;

  factory Trade.fromMap(Map<String, dynamic> json) => Trade(
        id: json["id"] == null ? null : json["id"],
        mentorId: json["mentor_id"] == null ? null : json["mentor_id"],
        type: json["type"] == null ? null : json["type"],
        entryPrice: json["entry_price"] == null ? null : json["entry_price"],
        name: json["name"] == null ? null : json["name"],
        stock: json["stock"] == null ? null : json["stock"],
        exitPrice: json["exit_price"] == null ? null : json["exit_price"],
        exitHigh: json["exit_high"] == null ? null : json["exit_high"],
        stopLossPrice:
            json["stop_loss_price"] == null ? null : json["stop_loss_price"],
        action: json["action"] == null ? null : json["action"],
        result: json["result"] == null ? null : json["result"],
        status: json["status"] == null ? null : json["status"],
        postedDate: json["posted_date"] == null
            ? null
            : DateTime.parse(json["posted_date"]),
        fee: json["fee"] == null ? null : json["fee"],
        isSubscribe: json["is_subscribe"] == null ? null : json["is_subscribe"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "mentor_id": mentorId == null ? null : mentorId,
        "type": type == null ? null : type,
        "entry_price": entryPrice == null ? null : entryPrice,
        "name": name == null ? null : name,
        "stock": stock == null ? null : stock,
        "exit_price": exitPrice == null ? null : exitPrice,
        "exit_high": exitHigh == null ? null : exitHigh,
        "stop_loss_price": stopLossPrice == null ? null : stopLossPrice,
        "action": action == null ? null : action,
        "result": result == null ? null : result,
        "status": status == null ? null : status,
        "posted_date": postedDate == null
            ? null
            : "${postedDate?.year.toString().padLeft(4, '0')}-${postedDate?.month.toString().padLeft(2, '0')}-${postedDate?.day.toString().padLeft(2, '0')}",
        "fee": fee == null ? null : fee,
        "is_subscribe": isSubscribe == null ? null : isSubscribe,
        "user": user == null ? null : user!.toMap(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.profileImage,
  });

  int? id;
  String? name;
  String? profileImage;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        profileImage:
            json["profile_image"] == null ? null : json["profile_image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "profile_image": profileImage == null ? null : profileImage,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
