import 'package:clone_radish_app/data/address_model.dart';
import 'package:clone_radish_app/screens/start/address_service.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _addressController = TextEditingController();
  AddressModel? _addressModel;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final buttonColor = Theme.of(context).textTheme.labelLarge?.color;
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _addressController,
            onFieldSubmitted: (text) async {
              _addressModel = await AddressService().SearchAddressByStr(text);
              logger.e('Searching success!');
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
            onPressed: () {},
            icon: Icon(
              Icons.location_pin,
              color: buttonColor,
            ),
            label: Text(
              '현재 위치로 찾기',
              style: TextStyle(
                color: buttonColor,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _addressModel == null ? 0 : _addressModel!.list.length,
              itemBuilder: (context, index) {
                if (_addressModel == null) return Container();

                return ListTile(
                  title: Text(_addressModel!.list[index].juso),
                  subtitle: Text('우편번호 ${_addressModel!.list[index].zipCl}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
