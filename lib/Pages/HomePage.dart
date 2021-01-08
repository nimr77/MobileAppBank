import 'package:bank_app_demo_fstt/Auth/MyFirebaseAuth.dart';
import 'package:bank_app_demo_fstt/Controllers/MyUserController.dart';
import 'package:bank_app_demo_fstt/Views/MakingUserView.dart';
import 'package:bank_app_demo_fstt/Views/MyCardView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool userLogin = false;
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
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            // login // logout // sing in
            MyUserView.showMessage(context);
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
              // history
            ],
          ),
        ),
      ),
    );
  }
}
