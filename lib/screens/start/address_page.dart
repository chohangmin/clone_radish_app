import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final buttonColor = Theme.of(context).textTheme.labelLarge?.color;
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
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
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
