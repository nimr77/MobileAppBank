import 'dart:async';

import 'package:bank_app_demo_fstt/Auth/MyFirebaseAuth.dart';
import 'package:bank_app_demo_fstt/Database/Ref.dart';
import 'package:bank_app_demo_fstt/Modules/History.dart';
import 'package:bank_app_demo_fstt/Modules/MyAccount.dart';
import 'package:bank_app_demo_fstt/Modules/MyCard.dart';
import 'package:bank_app_demo_fstt/Modules/MyUser.dart';
import 'package:uuid/uuid.dart';

class MyUserControllers {
  // ignore: close_sinks
  static StreamController<MyCard> cardController = StreamController<MyCard>();
  // ignore: close_sinks
  static StreamController<MyUser> userController = StreamController<MyUser>();
  // ignore: close_sinks
  static StreamController<MyHistory> historyController =
      StreamController<MyHistory>();
  // ignore: close_sinks
  static StreamController<MyAmount> amountController =
      StreamController<MyAmount>();
  // ignore: close_sinks
  static StreamSubscription<MyCard> cardListener;
  // ignore: close_sinks
  static StreamSubscription<MyUser> userListener;
  // ignore: close_sinks
  static StreamSubscription<MyHistory> historyListener;
  // ignore: close_sinks
  static StreamSubscription<MyAmount> amountListener;
  // save myUser
  static Future saveUser(MyUser myUser, String id) async {
    await MyDatabaseRef.userRef.doc(id).set(myUser.toMap());
    MyUser me = myUser;
    me.id = id;
  }

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

  // get Card
  static initStreamCard() {
    var q = MyDatabaseRef.getMyUserCard().snapshots();
    q.forEach((element) {
      try {
        MyCard.me = MyCard.fromMap(element.docChanges.first.doc.data());

        cardController.sink
            .add(MyCard.fromMap(element.docChanges.first.doc.data()));
      } catch (e) {
        print(e);
      }
    });
  }

  static init() {
    cardListener = cardController.stream.asBroadcastStream().listen((event) {});
    userListener = userController.stream.asBroadcastStream().listen((event) {});
    amountListener =
        amountController.stream.asBroadcastStream().listen((event) {});
    historyListener =
        historyController.stream.asBroadcastStream().listen((event) {});
  }

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

  // get amount
  static initStreamAmount() async {
    var q = MyDatabaseRef.getMyUserAmount().snapshots();
    q.forEach((element) {
      try {
        MyAmount.me = MyAmount.fromMap(element.docChanges.first.doc.data());
        amountController.sink
            .add(MyAmount.fromMap(element.docChanges.first.doc.data()));
      } catch (e) {}
    });
  }

  // logout
  static logout() async {
    await cardController.close();
    await amountController.close();
    await historyController.close();
    await MyFirebaseAuth.logout();
  }

  static Future login(String email, String password) async {
    var id = await MyFirebaseAuth.login(email, password);
    if (id != null) {
      await MyUserControllers.loadUser(id);
      return true;
    } else {
      // error
      return false;
    }
  }

  static Future<bool> sign_up(
      String email, String password, String name) async {
    var id = await MyFirebaseAuth.signUp(email, password);
    //Save user
    if (id != null) {
      var t = MyUser(email: email, name: name, id: id);
      await MyDatabaseRef.userRef.doc(id).set(t.toMap());
      return true;
    } else {
      // error
      return false;
    }
  }

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

  // create Card
  static Future createCard() async {
    var t = MyCard(
        name: MyUser.myCurrentName,
        id: Uuid().v1(),
        number: "1845-1451-5626-9821",
        pin: "4836",
        whenCreated: DateTime.now().millisecondsSinceEpoch,
        whenExpired:
            DateTime.now().add(Duration(days: 7000)).millisecondsSinceEpoch);
    // save it
    await MyDatabaseRef.getMyUserCard().doc(t.id).set(t.toMap());
  }
}
