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
  String title;
  String district;
  String geometry;

  Item({
    required this.id,
    required this.title,
    required this.district,
    required this.geometry,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        district: json["district"],
        geometry: json["geometry"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "district": district,
        "geometry": geometry,
      };
}
