import 'package:clone_radish_app/constants/keys.dart';
import 'package:clone_radish_app/data/address_model.dart';
import 'package:clone_radish_app/data/address_point_model.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:dio/dio.dart';

class AddressService {
  Future<AddressModel> SearchAddressByStr(String text) async {
    final formData = {
      'request': 'search',
      'key': VWORLD_KEY,
      'query': text,
      'type': 'ADDRESS',
      'category': 'ROAD',
      'size': '30',
    };

    final response = await Dio()
        .get('https://api.vworld.kr/req/search', queryParameters: formData)
        .catchError((e) {
      logger.e(e.message);
    });

    logger.d(response);

    AddressModel addressModel = AddressModel.fromJson(response.data);
    return addressModel;
  }

  Future<List<AddressPointModel>> findAddressByCoordinate(
      {required double lon, required double lat}) async {
    final List<Map<String, dynamic>> formDatas = <Map<String, dynamic>>[];

    formDatas.add({
      'service': 'address',
      'request': 'GetAddress',
      'key': VWORLD_KEY,
      'type': 'BOTH',
      'point': '$lon, $lat',
    });

    formDatas.add({
      'service': 'address',
      'request': 'GetAddress',
      'key': VWORLD_KEY,
      'type': 'BOTH',
      'point': '${lon - 0.01}, $lat',
    });

    formDatas.add({
      'service': 'address',
      'request': 'GetAddress',
      'key': VWORLD_KEY,
      'type': 'BOTH',
      'point': '${lon + 0.01}, $lat',
    });

    formDatas.add({
      'service': 'address',
      'request': 'GetAddress',
      'key': VWORLD_KEY,
      'type': 'BOTH',
      'point': '$lon, ${lat - 0.01}',
    });

    formDatas.add({
      'service': 'address',
      'request': 'GetAddress',
      'key': VWORLD_KEY,
      'type': 'BOTH',
      'point': '$lon, ${lat + 0.01}',
    });

    // final formData = {
    //   'service': 'address',
    //   'request': 'GetAddress',
    //   'key': VWORLD_KEY,
    //   'type': 'BOTH',
    //   'point': '$lon, $lat',
    // };

    List<AddressPointModel> addresses = [];

    for (Map<String, dynamic> formData in formDatas) {
      final response = await Dio()
          .get('https://api.vworld.kr/req/address', queryParameters: formData)
          .catchError((e) {
        logger.e(e.message);
      });

      logger.d(response);

      AddressPointModel addressModel =
          AddressPointModel.fromJson(response.data);
      if (response.data["response"]["status"] == "OK")
        addresses.add(addressModel);
    }
    return addresses;

    // final response = await Dio()
    //     .get('https://api.vworld.kr/req/address', queryParameters: formData)
    //     .catchError((e) {
    //   logger.e(e.message);
    // });

    // logger.d(response);
    // return;
  }
}
