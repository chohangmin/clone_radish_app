import 'package:clone_radish_app/constants/keys.dart';
import 'package:clone_radish_app/data/address_model.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:dio/dio.dart';

class AddressService {
  Future<AddressModel> SearchAddressByStr(String text) async {
    final formData = {
      'apiKey': VWORLD_KEY,
      'category': 'juso',
      'q': text,
      'pageUnit': '30',
    };

    final response = await Dio()
        .get('http://apis.vworld.kr/search.do', queryParameters: formData)
        .catchError((e) {
      logger.e(e.message);
    });

    logger.d(response);

    AddressModel addressModel = AddressModel.fromJson(response.data);
    return addressModel;
  }
}
