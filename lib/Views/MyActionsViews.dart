import 'package:bank_app_demo_fstt/Controllers/MyUserController.dart';
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
  @override
  void initState() {
    MyUserControllers.amountListener.onData((data) {
      MyUserControllers.amountController.stream.last.then((value) {
        setState(() {
          currentAmount = value?.total ?? 0;
        });
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
              Row(
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyButtons.simpleActionButton(
                            () => Future(() async {
                              if (myFromKey.currentState.validate()&&myAmount.text.isNotEmpty)
                                    await MyUserControllers.modify(
                                        double.parse(myAmount.text));
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
                                  if (myFromKey.currentState.validate()&&myAmount.text.isNotEmpty)
                                    await MyUserControllers.modify(
                                        double.parse(myAmount.text));
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
