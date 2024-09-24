class AddressPointModel {
  String status;
  Input input;
  List<Result> result;

  AddressPointModel({
    required this.status,
    required this.input,
    required this.result,
  });

  factory AddressPointModel.fromJson(Map<String, dynamic> json) {
    final response = json["response"];
    return AddressPointModel(
      status: response["status"],
      input: Input.fromJson(response["input"]),
      result:
          List<Result>.from(response["result"].map((x) => Result.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "input": input,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Input {
  Point point;
  String crs;
  String type;

  Input({
    required this.point,
    required this.crs,
    required this.type,
  });
  factory Input.fromJson(Map<String, dynamic> json) => Input(
        point: Point.fromJson(json["point"]),
        crs: json["crs"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "point": point.toJson(),
        "crs": crs,
        "type": type,
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

class Result {
  String zipcode;
  String type;
  String text;
  Structure structure;

  Result({
    required this.zipcode,
    required this.type,
    required this.text,
    required this.structure,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        zipcode: json["zipcode"],
        type: json["type"],
        text: json["text"],
        structure: Structure.fromJson(json["structure"]),
      );

  Map<String, dynamic> toJson() => {
        "zipcode": zipcode,
        "type": type,
        "text": text,
        "structure": structure.toJson(),
      };
}

class Structure {
  String level0;
  String level1;
  String level2;
  String level3;
  String level4L;
  String level4LC;
  String level4A;
  String level4AC;
  String level5;
  String detail;

  Structure({
    required this.level0,
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4A,
    required this.level4AC,
    required this.level4L,
    required this.level4LC,
    required this.level5,
    required this.detail,
  });

  factory Structure.fromJson(Map<String, dynamic> json) => Structure(
        level0: json["level0"],
        level1: json["level1"],
        level2: json["level2"],
        level3: json["level3"],
        level4A: json["level4A"],
        level4AC: json["level4AC"],
        level4L: json["level4L"],
        level4LC: json["level4LC"],
        level5: json["level5"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "level0": level0,
        "level1": level1,
        "level2": level2,
        "level3": level3,
        "level4A": level4A,
        "level4AC": level4AC,
        "level4L": level4L,
        "level4LC": level4LC,
        "level5": level5,
        "detail": detail,
      };
}
