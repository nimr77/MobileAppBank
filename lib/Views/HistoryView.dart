import 'package:bank_app_demo_fstt/Controllers/MyUserController.dart';
import 'package:bank_app_demo_fstt/Modules/History.dart';
import 'package:bank_app_demo_fstt/Util/GeneralUtil.dart';
import 'package:bank_app_demo_fstt/functions/ValidateStrings.dart';
import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';

class MyHistoryView extends StatelessWidget {
  final MyHistory myHistory;
  MyHistoryView({this.myHistory});
  bool myDepositHistory() => myHistory is MyDepositHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // the action type
            myDepositHistory()
                ? Expanded(
                    child: Text(
                      "+${myHistory.amount}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.green),
                    ),
                  )
                : Expanded(
                    child: Text(
                      "-${myHistory.amount}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.red),
                    ),
                  ),
            // when
            Expanded(
              child: Text(
                MyValidators.showTheBestTimeViewWithDate(
                    DateTime.fromMillisecondsSinceEpoch(myHistory.when)),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.black87),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyHistoryFullView extends StatefulWidget {
  @override
  _MyHistoryFullViewState createState() => _MyHistoryFullViewState();
}

class _MyHistoryFullViewState extends State<MyHistoryFullView> {
  @override
  void initState() {
    MyUserControllers.historyListener.onData((data) {
      setState(() {});
    });
    MyUserControllers.historyListener.onDone(() {
      setState(() {
        MyHistory.listOfMe.clear();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyUtil.getContextHeight(context) * 0.8,
      child: ListView.builder(
        itemCount: MyHistory.listOfMe.length,
        itemBuilder: (context, index) => ShowUpAnimation(
            key: ValueKey(MyHistory.listOfMe[index].id),
            child: MyHistoryView(
              myHistory: MyHistory.listOfMe[index],
            )),
      ),
    );
  }
}
