import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/createOnboardingItem.dart';

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.only(right: 5),
      height: 20,
      width: isActive ? 60 : 20,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcecece),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              onPageChanged: ((int page) {
                setState(() {
                  currentIndex = page;
                });
              }),
              controller: _pageController,
              children: [
                createPage(
                  image: 'https://img.icons8.com/ios/500/flutter.png',
                  title: 'Lorem Lorem Lorem Lorem Lorem 1',
                ),
                createPage(
                  image:
                      'https://iconape.com/wp-content/png_logo_vector/flutter.png',
                  title: 'Lorem Lorem Lorem Lorem Lorem 2',
                ),
                createPage(
                  image:
                      'http://store-images.s-microsoft.com/image/apps.36791.14156289948578898.23a008e0-fa7d-4b3c-bbc7-797275400366.c3f51166-5084-4844-a1ae-823a54996c40',
                  title: 'Lorem Lorem Lorem Lorem Lorem 3',
                ),
              ],
            ),
            Positioned(
              bottom: 190,
              child: Center(
                child: Row(
                  children: _buildIndicator(),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              child: InkWell(
                // onTap: (() =>  Get.to(HomePage())),
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
