import 'package:covid/HomeScreen.dart';
import 'package:covid/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroScreen();
  }
}

class _IntroScreen extends State<IntroScreen> {
  int currentpage = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: peachBack,
      body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(
                    "How to Protect yourself &\n others from Coronavirus",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  height: 393,
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (val) {
                      setState(() {
                        currentpage = val;
                      });
                    },
                    itemBuilder: (context, position) {
                      return position == 0
                          ? WashYourHand()
                          : position == 1 ? UseFaceMask() : SocialDistance();
                    },
                    itemCount: 3,
                  ),
                ),

                Container(
                    margin: EdgeInsets.all(16),
                    child: currentpage != 2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 6,
                                width: 20,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      currentpage == 0 ? orangeBack : blackBack,
                                ),
                              ),
                              Container(
                                height: 6,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      currentpage == 1 ? orangeBack : blackBack,
                                ),
                              ),
                              Container(
                                height: 6,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      currentpage == 2 ? orangeBack : blackBack,
                                ),
                                margin: EdgeInsets.all(10),
                              ),
                            ],
                          )
                        : Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: orangeBack,
                            ),
                            child: FlatButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomeScreen()),
                                );
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(
                                    color: blackBack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
              ],
            ),
          ),
        ),
    );
  }
}

WashYourHand() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          child: Lottie.asset(
            'assets/animations/washhands.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          child: Text(
            "01",
            style: TextStyle(fontSize: 40, color: redBack),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            "Wash Your Hands",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Text(
            " Wash your hands regularly with\nsoap and water or alcohol-based\n                        handrub",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
  );
}

UseFaceMask() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 200,
        height: 200,
        child: Lottie.asset(
          'assets/animations/wearmask.json',
          width: 200,
          height: 200,
          fit: BoxFit.fill,
        ),
      ),
      Container(
        child: Text(
          "02",
          style: TextStyle(fontSize: 40, color: redBack),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        child: Text(
          "Use Face Mask",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        child: Text(
          "Cough and sneeze into a tissue or\n     flexed elbow, then throw the\n              tissue into the trash",
          style: TextStyle(fontSize: 20),
        ),
      ),
    ],
  );
}

SocialDistance() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 200,
        height: 200,
        child: Lottie.asset(
          'assets/animations/socialdistance.json',
          width: 200,
          height: 200,
          fit: BoxFit.fill,
        ),
      ),
      Container(
        child: Text(
          "03",
          style: TextStyle(fontSize: 40, color: redBack),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        child: Text(
          "Maintain Social Distance",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        child: Text(
          "Avoid physical contact and \n     maintain a distance of\n  atleast 6 feet with others",
          style: TextStyle(fontSize: 20),
        ),
      ),
    ],
  );
}
