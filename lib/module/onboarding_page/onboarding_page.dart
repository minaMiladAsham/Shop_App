import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/module/login_page/login_page.dart';
import 'package:shopapp/shared/colors/colors.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  String? image;
  String? Title;
  String? body;

  OnBoardingModel(
      {required this.image, required this.Title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> onBoardList = [
    OnBoardingModel(
        image: 'assets/images/onboard-1.jpg',
        body: 'onBoard 1 Body',
        Title: 'onBoard 1 Title'),
    OnBoardingModel(
        image: 'assets/images/onboard-2.jpg',
        body: 'onBoard 2 Body',
        Title: 'onBoard 2 Title'),
    OnBoardingModel(
        image: 'assets/images/onboard-3.jpg',
        body: 'onBoard 3 Body',
        Title: 'onBoard 3 Title'),
  ];

  var onBoardingController = PageController();
  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: onSubmit, child: Text('Skip')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == onBoardList.length - 1) {
                    setState(() {
                      islast = true;
                    });
                  } else {
                    setState(() {
                      islast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildOnBoardItem(onBoardList[index]),
                itemCount: onBoardList.length,
                controller: onBoardingController,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: Colors.grey,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                  controller: onBoardingController,
                  count: onBoardList.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      onSubmit();
                    } else {
                      onBoardingController.nextPage(
                        duration: Duration(
                          microseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardItem(OnBoardingModel list) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${list.image}'))),
          SizedBox(height: 30),
          Text(
            '${list.Title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '${list.body}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  void onSubmit() {
    CacheHelper.saveData(key: 'killOnBoarding', value: true).then((value) {
      navigateAndFinish(context, LoginPage());
    });
  }
}
