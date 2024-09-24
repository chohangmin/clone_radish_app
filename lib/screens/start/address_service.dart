import 'package:clone_radish_app/constants/keys.dart';
import 'package:clone_radish_app/data/address_model.dart';
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

  Future<void> findAddressByCoordinate(
      {required double lon, required double lat}) async {
    final formData = {
      'service': 'address',
      'request': 'GetAddress',
      'key': VWORLD_KEY,
      'type': 'BOTH',
      'point': '$lon, $lat',
    };

    final response = await Dio()
        .get('https://api.vworld.kr/req/address', queryParameters: formData)
        .catchError((e) {
      logger.e(e.message);
    });

    logger.d(response);
    return;
  }
}
