import 'package:clone_radish_app/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;
      final imgSize = size.width / 4;
      return _listView(imgSize);
    });
  }

  ListView _listView(double imgSize) {
    return ListView.separated(
      padding: const EdgeInsets.all(common_bg_padding),
      itemBuilder: (context, index) {
        return Row(
          children: [
            SizedBox(
              width: imgSize,
              height: imgSize,
              child: ExtendedImage.network(
                'https://picsum.photos/100',
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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

  ListView _shimmerListView(double imgSize) {
    return ListView.separated(
      padding: const EdgeInsets.all(common_bg_padding),
      itemBuilder: (context, index) {
        return Row(
          children: [
            Container(
              width: imgSize,
              height: imgSize,
              color: Colors.white,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)),
              // child: ExtendedImage.network(
              //   'https://picsum.photos/100',
              //   shape: BoxShape.rectangle,
              //   borderRadius: BorderRadius.circular(10),
              // ),
            ),
            const SizedBox(
              width: common_bg_padding,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 10,
                    height: 7,
                    color: Colors.white,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 7,
                    color: Colors.white,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    width: 10,
                    height: 7,
                    color: Colors.white,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    width: 10,
                    height: 7,
                    color: Colors.white,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 15,
                            width: 20,
                            color: Colors.white,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
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
