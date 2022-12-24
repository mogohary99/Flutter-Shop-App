import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app2/network/local/cache_helper.dart';
import 'package:shop_app2/screens/login_screen/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String title;
  final String image;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      title: 'title1',
      image: 'assets/images/image1.svg',
      body: 'body1',
    ),
    BoardingModel(
      title: 'title2',
      image: 'assets/images/image2.svg',
      body: 'body2',
    ),
    BoardingModel(
      title: 'title3',
      image: 'assets/images/image3.svg',
      body: 'body3',
    ),
  ];

  PageController boardController = PageController();
  bool isLast = false;
  
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text(
                'SKIP',
                style: TextStyle(fontSize: 16),
              ),),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardController,
              physics: BouncingScrollPhysics(),
              itemCount: boarding.length,
              onPageChanged: (index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                  print('last');
                } else {
                  setState(() {
                    isLast = false;
                  });
                  print('not last');
                }
              },
              itemBuilder: (context, index) {
                return buildBoardingItem(boarding[index]);
              },
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 10,
                    dotColor: Colors.grey,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(microseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              model.image,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            model.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            model.body,
            style: const TextStyle(
              fontSize: 16,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
