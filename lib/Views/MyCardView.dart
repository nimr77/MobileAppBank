import 'package:bank_app_demo_fstt/Controllers/MyUserController.dart';
import 'package:bank_app_demo_fstt/Modules/MyCard.dart';
import 'package:bank_app_demo_fstt/Widgets/MyAnimatedCard.dart';
import 'package:bank_app_demo_fstt/functions/ValidateStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyCardView extends StatefulWidget {
  @override
  _MyCardViewState createState() => _MyCardViewState();
}

class _MyCardViewState extends State<MyCardView> {
  bool showCodePin = false;
  bool loadingUser = false;
  bool showGenerateUser = true;

  MyCard myCard;
  @override
  void initState() {
    if (MyUserControllers.cardListener != null)
      MyUserControllers.cardListener.onData((data) {
        if (data != null) {
          setState(() {
            showGenerateUser = false;
            myCard = data;
          });
        }
      });
    super.initState();
  }

  @override
  void setState(fn) {
    // if (showGenerateUser && MyUserControllers.cardListener != null) {
    //   MyUserControllers.cardListener.onData((data) {
    //     if (data != null) {
    //       setState(() {
    //         showGenerateUser = false;
    //       });
    //     }
    //   });
    // }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return MyAnimatedCard(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            body: AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              child: Column(
                key: ValueKey(myCard == null),
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // the number
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SelectableText(
                        myCard == null ? "Please set your card" : myCard.number,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),

                  Container(
                    color: Colors.black87.withOpacity(0.3),
                    height: 1,
                  ),
                  // the name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      myCard == null ? "Card name" : myCard.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  // row with date
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // from
                          Text(
                            "Valid from: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            myCard == null
                                ? "-"
                                : MyValidators.viewOnlyCrDate(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        myCard.whenCreated)),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            " To: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            myCard == null
                                ? "-"
                                : MyValidators.viewOnlyCrDate(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        myCard.whenExpired)),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white),
                          ),
                          // to
                        ],
                      )),
                  AnimatedSwitcher(
                    duration: Duration(
                      milliseconds: 800,
                    ),
                    child: FlatButton.icon(
                      key: ValueKey(showCodePin),
                      label: Container(
                        width: 100,
                        child: !showCodePin
                            ? Text("Show pin code")
                            : Text(myCard == null ? "-" : myCard.pin),
                      ),
                      onPressed: () {
                        setState(() {
                          showCodePin = !showCodePin;
                        });
                      },
                      icon: !showCodePin
                          ? Icon(Icons.lock)
                          : Icon(Icons.remove_red_eye_rounded),
                    ),
                  )
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            floatingActionButton: showGenerateUser
                ? FloatingActionButton(
                    backgroundColor: Colors.black87.withOpacity(0.7),
                    onPressed: () async {
                      setState(() {
                        loadingUser = true;
                      });
                      await MyUserControllers.createCard();
                      setState(() {
                        loadingUser = false;
                      });
                    },
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 800),
                      child: !loadingUser
                          ? Icon(
                              Icons.add,
                              key: ValueKey("loading"),
                              color: Colors.white,
                            )
                          : SpinKitSpinningCircle(
                              key: ValueKey("Not loading"),
                              color: Colors.white,
                            ),
                    ),
                  )
                : null,
          ),
        ),
        duration: 4000,
        width: MediaQuery.of(context).size.width * 0.95 > 500
            ? 500
            : MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.25 > 250
            ? 250
            : MediaQuery.of(context).size.height * 0.25,
        colors: [Colors.purple, Colors.blue, Colors.pink],
        stops: [0, 0.3, 0.7]);
  }
}
