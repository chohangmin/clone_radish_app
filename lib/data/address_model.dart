class AddressModel {
  String juso;
  PaginationInfo paginationInfo;
  String category;
  List<ListElement> list;

  AddressModel({
    required this.juso,
    required this.paginationInfo,
    required this.category,
    required this.list,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        juso: json['Juso'],
        paginationInfo: PaginationInfo.fromJson(json['paginationInfo']),
        category: json['category'],
        list: List<ListElement>.from(
            json['LIST'].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "Juso" : juso,
    "paginationInfo" : paginationInfo.toJson(),
    "category" : category,
    "LIST" : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class PaginationInfo {
  String lastPageNo;
  String totalPageCount;
  String firstPageNo;
  String currentPageNo;
  String totalRecordCount;

  PaginationInfo({
    required this.lastPageNo,
    required this.totalPageCount,
    required this.firstPageNo,
    required this.currentPageNo,
    required this.totalRecordCount,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) => PaginationInfo(
        lastPageNo: json['lastPageNo'],
        totalPageCount: json['totalPageCount'],
        firstPageNo: json['firstPageNo'],
        currentPageNo: json['currentPageNo'],
        totalRecordCount: json['totalRecordCount'],
      );
  Map<String, dynamic> toJson() => {
        "lastPageNo": lastPageNo,
        "totalPageCount": totalPageCount,
        "firstPageNo": firstPageNo,
        "currentPageNo": currentPageNo,
        "totalRecordCount": totalRecordCount,
      };
}

class ListElement {
  String xpos;
  String ypos;
  String juso;
  String zipCl;
  String bldNm;

  ListElement({
    required this.xpos,
    required this.ypos,
    required this.juso,
    required this.zipCl,
    required this.bldNm,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        xpos: json['xpos'],
        ypos: json['ypos'],
        juso: json['JUSO'],
        zipCl: json['ZIP_CL'],
        bldNm: json['BLD_NM'],
      );

  Map<String, dynamic> toJson() => {
        "xpos": xpos,
        "ypos": ypos,
        "JUSO": juso,
        "ZIP_CL": zipCl,
        "BLD_NM": bldNm,
      };
}
