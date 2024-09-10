import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

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
            style: TextButton.styleFrom(
              minimumSize: const Size(10, 48),
              backgroundColor: primaryColor,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('address $index'),
                  subtitle: Text('detail $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
