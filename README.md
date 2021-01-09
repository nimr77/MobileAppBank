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
#### History
here we created two types of history one for the withdraw and one for the deposit actions,
so we created a mother class called MyHistory, and the other two are implementing it, and one controller for both, one view for both
```dart
import 'package:flutter/cupertino.dart';

class MyHistory {
  String id;
  int when;
  double amount;

  static List<MyHistory> listOfMe = List<MyHistory>();
}

class MyWithdrawHistory implements MyHistory {
  @override
  double amount;

  @override
  String id;

  @override
  int when;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MyWithdrawHistory({
    @required this.amount,
    @required this.id,
    @required this.when,
  });

  MyWithdrawHistory copyWith({
    double amount,
    String id,
    int when,
  }) {
    return new MyWithdrawHistory(
      amount: amount ?? this.amount,
      id: id ?? this.id,
      when: when ?? this.when,
    );
  }

  @override
  String toString() {
    return 'MyWithdrawHistory{amount: $amount, id: $id, when: $when}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyWithdrawHistory &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          id == other.id &&
          when == other.when);

  @override
  int get hashCode => amount.hashCode ^ id.hashCode ^ when.hashCode;

  factory MyWithdrawHistory.fromMap(Map<String, dynamic> map) {
    return new MyWithdrawHistory(
      amount: map['amount'] as double,
      id: map['id'] as String,
      when: map['when'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'amount': this.amount,
      'id': this.id,
      'when': this.when,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}

class MyDepositHistory implements MyHistory {
  @override
  double amount;

  @override
  String id;

  @override
  int when;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MyDepositHistory({
    @required this.amount,
    @required this.id,
    @required this.when,
  });

  MyDepositHistory copyWith({
    double amount,
    String id,
    int when,
  }) {
    return new MyDepositHistory(
      amount: amount ?? this.amount,
      id: id ?? this.id,
      when: when ?? this.when,
    );
  }

  @override
  String toString() {
    return 'MyDepositHistory{amount: $amount, id: $id, when: $when}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyDepositHistory &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          id == other.id &&
          when == other.when);

  @override
  int get hashCode => amount.hashCode ^ id.hashCode ^ when.hashCode;

  factory MyDepositHistory.fromMap(Map<String, dynamic> map) {
    return new MyDepositHistory(
      amount: map['amount'] as double,
      id: map['id'] as String,
      when: map['when'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'amount': this.amount,
      'id': this.id,
      'when': this.when,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
```
###### So how we can tell the different?
In dart there is an ```is``` operator that will help us tell the different.
Here is an example on how we used it in the view.
```dart
class MyHistoryView extends StatelessWidget {
  final MyHistory myHistory;
  MyHistoryView({this.myHistory});
  bool myDepositHistory() => myHistory is MyDepositHistory;
  .....
  ```
Here is an example on how we used it in the controller.
This function will handle adding new amount in the database
by reading the current amount and make a different on adding the new amount, like is it less or more than the current one.
```dart
  // modify amount
  static Future modify(
    double amount,
  ) async {
    var am = MyAmount.me;
    if (am == null || am.id == null) {
      // create one
      var x = MyCard.me;
      am = MyAmount(id: Uuid().v1(), cardID: x.id, total: 0);
    }
    var current = am.total ?? 0;
    var newTotal = amount + current;
    // if less
    if (newTotal != 0) {
      if (current > newTotal) {
        am.total = newTotal;
        await MyDatabaseRef.getMyUserAmount().doc(am.id).set(am.toMap());
        // history
        var wTemp = MyWithdrawHistory(
            amount: amount,
            id: Uuid().v1(),
            when: DateTime.now().millisecondsSinceEpoch);
        // save it
        await MyDatabaseRef.getMyWithdrawHistory()
            .doc(wTemp.id)
            .set(wTemp.toMap());
      } else {
        am.total = newTotal;
        await MyDatabaseRef.getMyUserAmount().doc(am.id).set(am.toMap());
        var dTemp = MyWithdrawHistory(
            amount: amount,
            id: Uuid().v1(),
            when: DateTime.now().millisecondsSinceEpoch);
        // save it
        await MyDatabaseRef.getDepositHistory()
            .doc(dTemp.id)
            .set(dTemp.toMap());
      }
      // if bigger
    } else {
      // error
    }
  }
  ```
  thin our streams will handle the change.
  ```dart
    // get history
    static initStreamHistory() {
      var q1 = MyDatabaseRef.getDepositHistory().snapshots();
      var q2 = MyDatabaseRef.getMyWithdrawHistory().snapshots();
      q1.forEach((element) {
        element.docChanges.forEach((doc) {
          MyHistory.listOfMe.add(MyDepositHistory.fromMap(doc.doc.data()));
          historyController.sink.add(MyHistory.listOfMe.last);
          MyHistory.listOfMe.sort((a, b) {
            if (a.when < b.when)
              return 1;
            else
              return -1;
          });
        });
      });
      q2.forEach((element) {
        element.docChanges.forEach((doc) {
          MyHistory.listOfMe.add(MyWithdrawHistory.fromMap(doc.doc.data()));
          historyController.sink.add(MyHistory.listOfMe.last);
          MyHistory.listOfMe.sort((a, b) {
            if (a.when < b.when)
              return 1;
            else
              return -1;
          });
        });
      });
    }
  ```
 ## Conclusion
    This is app is demo app on how to use Flutter and firestore, on a demo bank app, to get and to show the current amount
    beside to handle the changes in the database in realtime, and use the power of dart to change in the App's state.