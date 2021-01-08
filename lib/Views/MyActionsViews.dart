import 'package:bank_app_demo_fstt/Controllers/MyUserController.dart';
import 'package:bank_app_demo_fstt/Pages/HomePage.dart';
import 'package:bank_app_demo_fstt/Widgets/InputWidgets.dart';
import 'package:bank_app_demo_fstt/Widgets/MyButtons.dart';
import 'package:bank_app_demo_fstt/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MYActionsView extends StatefulWidget {
  @override
  _MYActionsViewState createState() => _MYActionsViewState();
}

class _MYActionsViewState extends State<MYActionsView> {
  double currentAmount = 0;
  final myAmount = TextEditingController();
  final myFromKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    MyUserControllers.amountListener.onData((data) {
      if (!isLoading)
        setState(() {
          currentAmount = data.total;
        });
      else
        currentAmount = data.total;
    });
    MyUserControllers.amountListener.onDone(() {setState(() {
      currentAmount = 0;
    });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black87.withOpacity(0.8)),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: myFromKey,
          child: Column(
            children: [
              // actions
              AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                child: Row(
                  key: ValueKey(currentAmount),
                  children: [
                    Expanded(
                        child: MyInputWidget.formInputBoxStand(
                            myAmount, S.of(context).amount,
                            typeOfKeyborad: TextInputType.number)),
                    // total amounts
                    Expanded(
                      child: Text(
                        currentAmount.toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyButtons.simpleActionButton(
                            () => Future(() async {
                                  if (myFromKey.currentState.validate() &&
                                      myAmount.text.isNotEmpty) {
                                    isLoading = true;
                                    await MyUserControllers.modify(
                                        double.parse(myAmount.text));
                                    isLoading = false;
                                  }
                                })
                                  ..then((value) {
                                    setState(() {});
                                  }),
                            S.of(context).deposit,
                            context,
                            elevation: 0,
                            myColor: Colors.green)),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyButtons.simpleActionButton(
                            () => Future(() async {
                                  if (myFromKey.currentState.validate() &&
                                      myAmount.text.isNotEmpty) if (this
                                          .currentAmount <
                                      double.parse(this.myAmount.text)) {
                                    // show error
                                    MyHomePageState.myScaffold.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(S.of(context).cantWithdraw),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else {
                                    isLoading = true;
                                    await MyUserControllers.modify(
                                        double.parse("-" + myAmount.text));
                                    isLoading = false;
                                  }
                                })
                                  ..then((value) {
                                    setState(() {});
                                  }),
                            S.of(context).withdraw,
                            context,
                            elevation: 0,
                            myColor: Colors.deepOrange)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
