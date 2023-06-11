import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';


class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({

   required this.image,
   required this.title,
   required this.body
  }
  );

}


class OnBoardingScreen extends StatelessWidget {

  List<BoardingModel> boarding=[
    BoardingModel(
        image:'assets/images/blood-donation-symbol.jpg' ,
        title: 'Blood Donation',
        body: 'Donate or receive blood'
    ),
    BoardingModel(
        image:'assets/images/burns.jpg' ,
        title: 'Skin Burns',
        body: 'Detect your skin burn degree'
    ),
    BoardingModel(
        image:'assets/images/firstAid.jpg',
        title: 'First Aid',
        body: 'Full Guide for first aid'
    ),
  ];

  var boardController= PageController();

  bool isLast = false;

  void submit (context) {
    CacheHelper.saveData(key: 'onBoarding', value:true).then((value){
      if(value)
        {
         navigatAndFinish(context, LoginScreen());
        }
    });

  }

  @override
  Widget build(BuildContext context) {

    Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),

      ],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10.0),
            child: TextButton(
                onPressed: () {
                  submit(context);
                },
                child: Text(
                  'SKIP',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: defaultColor,
                  ),
                ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder:(context, index) => buildBoardingItem(boarding[index]),
                  onPageChanged: (index) {
                    if(index==boarding.length-1)
                      {
                        isLast=true;
                      }
                    else
                      {
                        isLast=false;
                      }
                  },
                  itemCount:boarding.length,
                  ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect:ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor:defaultColor??Colors.red,
                      dotColor: Colors.grey,
                      spacing: 5.0,
                      expansionFactor: 4,
                    ) ,
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed:() {
                      if(isLast)
                        {
                          submit(context);
                        }
                      else
                        {
                          boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
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
}
