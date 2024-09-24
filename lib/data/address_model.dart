import 'dart:math';

class AddressModel {
  Page page;
  Result result;

  AddressModel({
    required this.page,
    required this.result,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    final response = json["response"];
    return AddressModel(
      page: Page.fromJson(response["page"]),
      result: Result.fromJson(response["result"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "page": page.toJson(),
        "result": result.toJson(),
      };
}

class Page {
  String total;
  String current;
  String size;

  Page({
    required this.total,
    required this.current,
    required this.size,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        total: json["total"],
        current: json["current"],
        size: json["size"],
      );
  Map<String, dynamic> toJson() => {
        "total": total,
        "current": current,
        "size": size,
      };
}

class Result {
  String crs;
  String type;
  List<Item> items;

  Result({
    required this.crs,
    required this.type,
    required this.items,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        crs: json["crs"],
        type: json["type"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "crs": crs,
        "type": type,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  String id;
  Address address;
  Point point;

  Item({
    required this.id,
    required this.address,
    required this.point,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        address: Address.fromJson(json["address"]),
        point: Point.fromJson(json["point"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address.toJson(),
        "point": point.toJson(),
      };
}

class Address {
  String zipcode;
  String category;
  String road;
  String parcel;
  String bldnm;
  String bldnmdc;

  Address({
    required this.zipcode,
    required this.category,
    required this.road,
    required this.parcel,
    required this.bldnm,
    required this.bldnmdc,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        zipcode: json["zipcode"],
        category: json["category"],
        road: json["road"],
        parcel: json["parcel"],
        bldnm: json["bldnm"],
        bldnmdc: json["bldnmdc"],
      );

  Map<String, dynamic> toJson() => {
        "zipcode": zipcode,
        "category": category,
        "road": road,
        "parcel": parcel,
        "bldnm": bldnm,
        "bldnmdc": bldnmdc,
      };
}

class Point {
  String x;
  String y;

  Point({
    required this.x,
    required this.y,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        x: json["x"],
        y: json["y"],
      );
  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}
