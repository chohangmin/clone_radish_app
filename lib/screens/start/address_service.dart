import 'package:clone_radish_app/constants/keys.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:dio/dio.dart';

class AddressService {
  void SearchAddressByStr(String text) async {
    final formData = {
      'apiKey': VWORLD_KEY,
      'service': 'Road',
      'query': text,
      'pageUnit': '30',
    };


    final response = await Dio()
        .get('http://apis.vworld.kr/search', queryParameters: formData)
        .catchError((e) {
      logger.e(e.message);
    });

    logger.d(response);
  }
}
