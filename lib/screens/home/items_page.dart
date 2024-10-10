import 'package:clone_radish_app/constants/common_size.dart';
import 'package:clone_radish_app/repo/user_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;
      final imgSize = size.width / 4;
      return FutureBuilder(
        future: Future.delayed(const Duration(
          seconds: 2,
        )),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: (snapshot.connectionState != ConnectionState.done)
                ? _shimmerListView(imgSize)
                : _listView(imgSize),
          );
        },
      );
    });
  }

  ListView _listView(double imgSize) {
    return ListView.separated(
      padding: const EdgeInsets.all(common_bg_padding),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // UserService().fireStoreReadTest();
          },
          child: Row(
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
          ),
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

  Shimmer _shimmerListView(double imgSize) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: ListView.separated(
        padding: const EdgeInsets.all(common_bg_padding),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                width: imgSize,
                height: imgSize,

                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
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
                      width: 160,
                      height: 23,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: 70,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: 50,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
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
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
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
      ),
    );
  }
}
