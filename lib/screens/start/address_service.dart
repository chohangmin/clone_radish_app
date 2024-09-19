import 'package:clone_radish_app/utils/logger.dart';
import 'package:dio/dio.dart';

class AddressService {
  void SearchAddressByStr(String text) async {
    final formData = {
      'key값': 'value값',
      'key값': 'value값',
      'key값': 'value값',
      'key값': 'value값',
      'key값': 'value값',
      'key값': 'value값'
    };

    final response =
        await Dio().get('http://apis.vworld.kr/search', queryParameters: formData).catchError((e) {
      logger.e(e.message);
    });

    logger.d(response);
  }
}
