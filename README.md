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
![alt text](https://github.com/nimr77/MobileAppBank/blob/main/ScreenShots/1610196801853.jpg?raw=true)
The home page contains the login/logout in the button of person/exit icon, and an Animated card been develop by me XD,( I like it ),
the card in case when we are logout, or dont have a card it will show add button, when we click on it, we add new card, that
will generate new one for us.

Here when we change the state of the card, we use AnimatedSwitcher, Example:
```dart
AnimatedSwitcher(
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
        ```
One Thing is important here the key, will represent as an ID for the widget, so in order to change the widget we must change it,
,and because our this view is for the card, so when we have a card we will show unknown card otherwise our card.
#### Streamers
You will remark that in each View there is a Stream listener, that will detect the change on the value of this widget, and change it, by calling the setState function
here when we call it, it will change the state of the view with a beautiful animation.
```dart
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
    MyUserControllers.cardListener.onDone(() {
      setState(() {
        myCard = null;
      });
    });
    super.initState();
  }
```
Here the ```myCard``` is our value of the object of MyCard:
```dart
import 'package:flutter/cupertino.dart';

class MyCard {
  String id;
  String number;
  String pin;
  int whenCreated;
  int whenExpired;
  String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MyCard({
    @required this.id,
    @required this.number,
    @required this.pin,
    @required this.whenCreated,
    @required this.whenExpired,
    @required this.name,
  });

  MyCard copyWith({
    String id,
    String number,
    String pin,
    int whenCreated,
    int whenExpired,
    String name,
  }) {
    return new MyCard(
      id: id ?? this.id,
      number: number ?? this.number,
      pin: pin ?? this.pin,
      whenCreated: whenCreated ?? this.whenCreated,
      whenExpired: whenExpired ?? this.whenExpired,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'MyCard{id: $id, number: $number, pin: $pin, whenCreated: $whenCreated, whenExpired: $whenExpired, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyCard &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          number == other.number &&
          pin == other.pin &&
          whenCreated == other.whenCreated &&
          whenExpired == other.whenExpired &&
          name == other.name);

  @override
  int get hashCode =>
      id.hashCode ^
      number.hashCode ^
      pin.hashCode ^
      whenCreated.hashCode ^
      whenExpired.hashCode ^
      name.hashCode;

  factory MyCard.fromMap(Map<String, dynamic> map) {
    return new MyCard(
      id: map['id'] as String,
      number: map['number'] as String,
      pin: map['pin'] as String,
      whenCreated: map['whenCreated'] as int,
      whenExpired: map['whenExpired'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'number': this.number,
      'pin': this.pin,
      'whenCreated': this.whenCreated,
      'whenExpired': this.whenExpired,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
  static MyCard me;
}
```
