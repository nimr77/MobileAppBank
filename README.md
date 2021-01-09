# bank_app_demo_fstt
This project is aiming to show some of the mobile development power, and how we can control the UI for the user.
Here we used Firebase and Flutter, and our server side and as as our client side,

#### Why Flutter
Flutter is a cross-platform toolkit for developing GUI applications developed by Google. A Flutter app natively compiles to:
1.iOS and Android
2.Windows, Linux, and macOS
3.The web
Dart, the programming language used by Flutter, is designed for GUI development. It’s fast and feels natural to those familiar with JavaScript, C#, Java, Kotlin, and similar languages. It’s an open-source,
versatile language that compiles to native code or JavaScript but can also be run in a VM.
#### Beside the app works on the MVC module, and Stream controllers
There is many way to control the data flow in the app, but I prefer the stream controllers, so that when ever I change a thing in the app
beside I use it in a realtime connection with the database.
##### Example
in the lib/Controllers
```dart
  // load myUser
  static loadUser(String id) async {
    var snap = MyDatabaseRef.userRef.doc(id).snapshots();
    MyUser.myCurrentId = id;
    // userListener.onData((data) async {
    //
    // });
    snap.forEach((element) async {
      MyUser.myCurrentName = MyUser.fromMap(element.data()).name;
      userController.add(MyUser.fromMap(element.data()));
      try {
        // await cardListener.cancel();
        // await historyListener.cancel();
        // await amountListener.cancel();
      } catch (e) {}
      initStreamCard();
      initStreamAmount();
      initStreamHistory();
    });
  }
```
This will load the user, when we make a change in database for the user we will notify the streamers on each part of the app
##### Parts (Collections)
 As we used Firebase, we used firestore cloud, as our database we gor a realtime connection and a ready SDK from google to flutter, that helps us to develop realtime apps:
 1. Card
 2. Amount
 3. History
 4. User
 and they are like this, the user contains his/her collection> User:{Card,Amount,History}
![alt text](https://firebasestorage.googleapis.com/v0/b/app-testing-94136.appspot.com/o/Posts_Image%2Fstorage%2FScreenshot%20from%202021-01-09%2013-44-02.png?alt=media&token=affae714-a72f-4ccd-aa69-e0a4872a2f0a)
### So how it works
we start from the home page which is our only page, contains all the actions:
