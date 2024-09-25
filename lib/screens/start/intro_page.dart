import 'package:beamer/beamer.dart';
import 'package:clone_radish_app/states/user_provider.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d(
        'Intro page current location ${Beamer.of(context).currentBeamLocation}');
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;

      final imgOne = size.width - 32;
      final imgTwo = imgOne * 0.1;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '무 마켓',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                width: imgOne,
                height: imgOne,
                child: Stack(
                  children: [
                    ExtendedImage.asset('assets/images/intro_one.png'),
                    Positioned(
                        width: imgTwo,
                        height: imgTwo,
                        top: imgOne * 0.45,
                        left: imgOne * 0.45,
                        child:
                            ExtendedImage.asset('assets/images/intro_two.png')),
                  ],
                ),
              ),
              const Text(
                '우리 동네 중고 직거래',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                '당근마켓은 동네 직거래 마켓이에요. \n내 동네를 설정하고 시작해보세요!',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<PageController>().animateToPage(1,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      '내 동네 설정하고 시작하기',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
