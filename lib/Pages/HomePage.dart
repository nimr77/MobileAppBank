import 'package:bank_app_demo_fstt/Auth/MyFirebaseAuth.dart';
import 'package:bank_app_demo_fstt/Controllers/MyUserController.dart';
import 'package:bank_app_demo_fstt/Views/HistoryView.dart';
import 'package:bank_app_demo_fstt/Views/MakingUserView.dart';
import 'package:bank_app_demo_fstt/Views/MyActionsViews.dart';
import 'package:bank_app_demo_fstt/Views/MyCardView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool userLogin = false;
  static final GlobalKey<ScaffoldState> myScaffold = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Firebase.initializeApp().then((value) async {
      await MyFirebaseAuth.autoLogin();
      if (MyUserControllers.userListener != null)
        MyUserControllers.userListener.onData((data) {
          if (data.id != null)
            setState(() {
              userLogin = true;
            });
        });
      else
        userLogin = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myScaffold,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            // login // logout // sing in
            if (!userLogin)
              MyUserView.showMessage(context);
            else
              // logout
              MyUserControllers.logout();
          },
          icon: Icon(
            userLogin ? Icons.exit_to_app_rounded : Icons.person,
            color: Colors.grey,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // key: ValueKey(userLogin),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: MyCardView()),
              // total amount
              // actions
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MYActionsView(),
              ),
              // show actions when the user is in the system,
              // history
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyHistoryFullView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
