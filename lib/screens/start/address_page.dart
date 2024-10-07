import 'package:clone_radish_app/constants/shared_pref_keys.dart';
import 'package:clone_radish_app/data/address_model.dart';
import 'package:clone_radish_app/data/address_point_model.dart';
import 'package:clone_radish_app/screens/start/address_service.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _addressController = TextEditingController();
  AddressModel? _addressModel;
  final List<AddressPointModel> _addressPointModel = [];

  bool _isGettingLocation = false;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final buttonColor = Theme.of(context).textTheme.labelLarge?.color;
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _addressController,
              onFieldSubmitted: (text) async {
                _addressPointModel.clear();
                _addressModel = await AddressService().SearchAddressByStr(text);
                logger.d('Searching success!');
                setState(() {});
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minHeight: 24,
                  minWidth: 24,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                hintText: "도로명으로 검색하세요.",
                hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                ),
              ),
              cursorColor: primaryColor,
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton.icon(
              onPressed: () async {
                _addressModel = null;
                _addressPointModel.clear;
                setState(() {
                  _isGettingLocation = true;
                });
                Location location = Location();
                bool serviceEnabled;
                PermissionStatus permissionGranted;
                LocationData locationData;

                serviceEnabled = await location.serviceEnabled();
                if (!serviceEnabled) {
                  serviceEnabled = await location.requestService();
                  if (!serviceEnabled) {
                    return;
                  }
                }

                permissionGranted = await location.hasPermission();
                if (permissionGranted == PermissionStatus.denied) {
                  permissionGranted = await location.requestPermission();
                  if (permissionGranted != PermissionStatus.granted) {
                    return;
                  }
                }
                locationData = await location.getLocation();
                logger.d(locationData);

                List<AddressPointModel> addresses =
                    await AddressService().findAddressByCoordinate(
                  lon: locationData.longitude!,
                  lat: locationData.latitude!,
                );

                _addressPointModel.addAll(addresses);

                setState(() {
                  _isGettingLocation = false;
                });
              },
              icon: SizedBox(
                width: 24,
                height: 24,
                child: _isGettingLocation
                    ? const CircularProgressIndicator()
                    : Icon(
                        Icons.location_pin,
                        color: buttonColor,
                      ),
              ),
              label: Text(
                '현재 위치로 찾기',
                style: TextStyle(
                  color: buttonColor,
                ),
              ),
            ),
            if (_addressModel != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _addressModel == null
                      ? 0
                      : _addressModel!.result.items.length,
                  itemBuilder: (context, index) {
                    if (_addressModel == null) return Container();

                    return ListTile(
                      onTap: () {
                        _setAddressOnSharedPreference(
                          _addressModel!.result.items[index].address.road ?? "",
                          num.parse(
                              _addressModel!.result.items[index].point.x ??
                                  "0"),
                          num.parse(
                              _addressModel!.result.items[index].point.y ??
                                  "0"),
                        );
                        _goToNextPage();
                      },
                      title:
                          Text(_addressModel!.result.items[index].address.road),
                      subtitle: Text(
                          _addressModel!.result.items[index].address.parcel),
                    );
                  },
                ),
              ),
            if (_addressPointModel.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _addressPointModel.length,
                  itemBuilder: (context, index) {
                    if (_addressPointModel[index].result.isEmpty) {
                      return Container();
                    }

                    return ListTile(
                      onTap: () {
                        _setAddressOnSharedPreference(
                          _addressPointModel[index].result[0].text ?? "",
                          num.parse(
                              _addressModel!.result.items[index].point.x ??
                                  "0"),
                          num.parse(
                              _addressModel!.result.items[index].point.y ??
                                  "0"),
                        );
                        _goToNextPage();
                      },
                      title:
                          Text(_addressPointModel[index].result[0].text ?? ""),
                      subtitle: Text(
                          _addressPointModel[index].result[0].zipcode ?? ""),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  _setAddressOnSharedPreference(String address, num lat, num lon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SHARED_ADDRESS, address);
    await prefs.setDouble(SHARED_LAT, lat.toDouble());
    await prefs.setDouble(SHARED_LON, lon.toDouble());
  }

  _goToNextPage() {
    context.read<PageController>().animateToPage(2,
        duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
  }
}
