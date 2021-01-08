import 'package:bank_app_demo_fstt/Modules/MyUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDatabaseRef {
  /// My user Ref
  static final userRef = FirebaseFirestore.instance.collection('Users');

  static CollectionReference getMyUserCard() => FirebaseFirestore.instance
      .collection('Users')
      .doc(MyUser.myCurrentId)
      .collection('Cards');

  static CollectionReference getMyUserAmount() => FirebaseFirestore.instance
      .collection('Users')
      .doc(MyUser.myCurrentId)
      .collection('Amount');

  static CollectionReference getMyWithdrawHistory() =>
      FirebaseFirestore.instance
          .collection('Users')
          .doc(MyUser.myCurrentId)
          .collection('WithdrawHistory');

  static CollectionReference getDepositHistory() => FirebaseFirestore.instance
      .collection('Users')
      .doc(MyUser.myCurrentId)
      .collection('DepositHistory');
}
