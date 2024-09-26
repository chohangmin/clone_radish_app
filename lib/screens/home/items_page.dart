import 'package:clone_radish_app/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(common_bg_padding),
      itemBuilder: (context, index) {
        return Row(
          children: [
            ExtendedImage.network('https://picsum.photos/100'),
            const SizedBox(
              width: common_bg_padding,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '펜타곤 모자',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    '1시간 전',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text('1억원'),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble_2,
                            color: Colors.grey,
                          ),
                          Text(
                            '31',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.heart,
                            color: Colors.grey,
                          ),
                          Text(
                            '19',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: common_sm_padding * 3,
          thickness: 1,
          color: Colors.grey,
          indent: common_sm_padding,
          endIndent: common_sm_padding,
        );
      },
      itemCount: 10,
    );
  }
}
