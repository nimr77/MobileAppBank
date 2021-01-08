import 'package:bank_app_demo_fstt/Controllers/MyUserController.dart';
import 'package:bank_app_demo_fstt/Util/GeneralUtil.dart';
import 'package:bank_app_demo_fstt/Widgets/InputWidgets.dart';
import 'package:bank_app_demo_fstt/Widgets/MyButtons.dart';
import 'package:bank_app_demo_fstt/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyUserView extends StatefulWidget {
  @override
  _MyUserViewState createState() => _MyUserViewState();

  static showMessage(BuildContext context) =>
      showDialog(context: context, builder: (context) => MyUserView());
}

class _MyUserViewState extends State<MyUserView> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController passwordSecController = TextEditingController();

  final myFormKey = GlobalKey<FormState>();
  final myFormKeyLogin = GlobalKey<FormState>();

  final myFormScaKey = GlobalKey<ScaffoldState>();

  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: myFormScaKey,
      body: Center(
        child: Container(
          height: MyUtil.getContextHeight(context) * 0.5,
          width: MyUtil.getContextWidth(context) * 0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      S.of(context).register,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    child: showLogin
                        ? Form(
                            key: myFormKeyLogin,
                            child: Column(
                              children: [
                                // User email
                                MyInputWidget.formInputBoxStand(
                                    emailController, S.of(context).email,
                                    typeOfKeyborad: TextInputType.emailAddress),
                                // password
                                MyInputWidget.formPasswordBox(
                                    passwordController, S.of(context).password),
                                // sign in
                                MyButtons.simpleActionButton(
                                  () => Future(() async {
                                    if (myFormKeyLogin.currentState
                                        .validate()) {
                                      // save data
                                      var r = await MyUserControllers.login(
                                          emailController.text,
                                          passwordController.text);
                                      if (r) {
                                        Navigator.pop(context);
                                      } else {
                                        myFormScaKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(S
                                              .of(context)
                                              .should_be_a_valid_email),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    }
                                  }),
                                  S.of(context).login,
                                  context,
                                  widthFactor: 0.9,
                                  elevation: 0,
                                ),
                                TextButton(
                                  child: Text(
                                      S.of(context).i_dont_have_an_account),
                                  onPressed: () {
                                    setState(() {
                                      showLogin = false;
                                    });
                                  },
                                )
                              ],
                            ),
                          )
                        : Form(
                            key: myFormKey,
                            child: Column(
                              children: [
                                // User name
                                MyInputWidget.formInputBoxStand(
                                    nameController, S.of(context).full_name),
                                // User email
                                MyInputWidget.formInputBoxStand(
                                    emailController, S.of(context).email,
                                    typeOfKeyborad: TextInputType.emailAddress),
                                // password
                                MyInputWidget.formPasswordBox(
                                    passwordController, S.of(context).password),
                                // confirm password
                                MyInputWidget.formPasswordBox(
                                    passwordSecController,
                                    S.of(context).password,
                                    secondPassword: passwordController),
                                // sign in
                                MyButtons.simpleActionButton(
                                  () => Future(() async {
                                    if (myFormKey.currentState.validate()) {
                                      // save data
                                      var r = await MyUserControllers.sign_up(
                                          emailController.text,
                                          passwordController.text,
                                          nameController.text);
                                      if (r) {
                                        myFormScaKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(S
                                              .of(context)
                                              .should_be_a_valid_email),
                                          backgroundColor: Colors.green,
                                        ));
                                      } else {
                                        myFormScaKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              S.of(context).not_a_valid_email),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    }
                                  }),
                                  S.of(context).register,
                                  context,
                                  widthFactor: 0.9,
                                  elevation: 0,
                                ),
                                TextButton(
                                  child: Text(S
                                      .of(context)
                                      .i_have_account_back_to_login),
                                  onPressed: () {
                                    setState(() {
                                      showLogin = true;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
