import 'dart:convert';

import 'package:flutter/material.dart';

class Sales {
  final List<StoreOrders> storeOrders;
  final List<DayOrders> dayOrders;
  final List<Strips> strips;
  final List<TicketDay> ticketDay;
  final List<TicketStore> ticketStore;
  final List<Products> products;
  final List<DeliveriesAfterHours> deliveriesAfterHours;

  Sales({
    @required this.storeOrders,
    @required this.dayOrders,
    @required this.strips,
    @required this.ticketDay,
    @required this.ticketStore,
    @required this.products,
    @required this.deliveriesAfterHours,
  });
  factory Sales.fromJson(Map<String, dynamic> json) => Sales(
        storeOrders: List<StoreOrders>.from(
            json["storeOrders"].map((x) => StoreOrders.fromJson(x))),
        dayOrders: List<DayOrders>.from(
            json["dayOrders"].map((x) => DayOrders.fromJson(x))),
        strips:
            List<Strips>.from(json["strips"].map((x) => Strips.fromJson(x))),
        ticketDay: List<TicketDay>.from(
            json["ticketDay"].map((x) => TicketDay.fromJson(x))),
        ticketStore: List<TicketStore>.from(
            json["ticketStore"].map((x) => TicketStore.fromJson(x))),
        products: List<Products>.from(
            json["products"].map((x) => Products.fromJson(x))),
        deliveriesAfterHours: List<DeliveriesAfterHours>.from(
            json["deliveriesAfterHours"]
                .map((x) => DeliveriesAfterHours.fromJson(x))),
      );
}

class Login {
  String token;
  Establishment establishment;
  User user;

  Login({
    this.token,
    this.establishment,
    this.user,
  });

  factory Login.fromRawJson(String str) => Login.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        token: json["token"] == null ? null : json["token"],
        establishment: json["establishment"] == null
            ? null
            : Establishment.fromJson(json["establishment"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "establishment": establishment == null ? null : establishment.toJson(),
        "user": user == null ? null : user.toJson(),
      };
}

class Establishment {
  int id;
  String name;
  Colorss colors;

  Establishment({
    this.id,
    this.name,
    this.colors,
  });

  factory Establishment.fromRawJson(String str) =>
      Establishment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Establishment.fromJson(Map<String, dynamic> json) => Establishment(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        colors:
            json["colorss"] == null ? null : Colorss.fromJson(json["colorss"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "colorss": colors == null ? null : colors.toJson(),
      };
}

class Colorss {
  String primary;
  String secondary;

  Colorss({
    this.primary,
    this.secondary,
  });

  factory Colorss.fromRawJson(String str) => Colorss.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Colorss.fromJson(Map<String, dynamic> json) => Colorss(
        primary: json["primary"] == null ? null : json["primary"],
        secondary: json["secondary"] == null ? null : json["secondary"],
      );

  Map<String, dynamic> toJson() => {
        "primary": primary == null ? null : primary,
        "secondary": secondary == null ? null : secondary,
      };
}

class User {
  String name;

  User({
    this.name,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };
}

class DayOrders {
  final DateTime day;
  final int amount;
  final int value;

  DayOrders({
    @required this.day,
    @required this.amount,
    @required this.value,
  });

  factory DayOrders.fromJson(Map<String, dynamic> json) => DayOrders(
        day: DateTime.parse(json["day"]),
        amount: int.parse(json["amount"]),
        value: int.parse(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "day":
            "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "value": value,
      };
}

class StoreOrders {
  final String store;
  final int amount;
  final int value;

  StoreOrders({
    @required this.store,
    @required this.amount,
    @required this.value,
  });

  factory StoreOrders.fromJson(Map<String, dynamic> json) => StoreOrders(
        store: json["store"],
        amount: int.parse(json["amount"]),
        value: int.parse(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "store": store,
        "amount": amount,
        "value": value,
      };
}

class Strips {
  final String type;
  final int amount;
  final int value;

  Strips({
    @required this.type,
    @required this.amount,
    @required this.value,
  });

  factory Strips.fromJson(Map<String, dynamic> json) => Strips(
        type: json["type"],
        amount: int.parse(json["amount"]),
        value: int.parse(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "amount": amount,
        "value": value,
      };
}

class TicketDay {
  final DateTime day;
  final int value;

  TicketDay({
    @required this.day,
    @required this.value,
  });

  factory TicketDay.fromJson(Map<String, dynamic> json) => TicketDay(
        day: DateTime.parse(json["day"]),
        value: int.parse(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "day":
            "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "value": value,
      };
}

class TicketStore {
  final String store;
  final int value;

  TicketStore({
    @required this.store,
    @required this.value,
  });

  factory TicketStore.fromJson(Map<String, dynamic> json) => TicketStore(
        store: json["store"],
        value: int.parse(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "store": store,
        "value": value,
      };
}

class Products {
  final String product;
  final int amount;
  final int value;

  Products({
    @required this.product,
    @required this.amount,
    @required this.value,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        product: json["product"],
        amount: int.parse(json["amount"]),
        value: int.parse(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "amount": amount,
        "value": value,
      };
}

class DeliveriesAfterHours {
  final DateTime day;
  final int value;

  DeliveriesAfterHours({
    @required this.day,
    @required this.value,
  });

  factory DeliveriesAfterHours.fromJson(Map<String, dynamic> json) =>
      DeliveriesAfterHours(
        day: DateTime.parse(json["day"]),
        value: int.parse(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "day":
            "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "value": value,
      };
}

class Credentials {
  String user;
  String password;

  Credentials({
    @required this.user,
    @required this.password,
  });

  factory Credentials.fromRawJson(String str) =>
      Credentials.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Credentials.fromJson(Map<String, dynamic> json) => Credentials(
        user: json["user"] == null ? null : json["user"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user,
        "password": password == null ? null : password,
      };
}
