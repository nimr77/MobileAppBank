import 'package:bank_app_demo_fstt/Controllers/MyUserController.dart';
import 'package:firebase_auth/firebase_auth.dart';

///This class is for Firebase AUTH
///[Contains] Login/Logout,Singin,AutoLogin
///[note] each Methods return's a True or False
class MyFirebaseAuth {
  static FirebaseAuth _myAuth = FirebaseAuth.instance;

  ///This will handle the User Login
  static Future<String> login(String email, String password) async {
    try {
      var myAuthRes = await _myAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (myAuthRes.user.emailVerified) {
        // notify for loading user data
        // and close the streamer
      } else {
        await _myAuth.signOut();
        return null;
      }
      return _myAuth.currentUser.uid;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> sendEmailV(String email, String password) async {
    try {
      var myAuthRes = await _myAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await myAuthRes.user.sendEmailVerification();
      await _myAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  ///this will handle the user sign up
  static Future<String> signUp(String email, String password) async {
    try {
      var myAuthRes = await _myAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await myAuthRes.user.updateProfile();
      await myAuthRes.user.sendEmailVerification();
      var id = myAuthRes.user.uid;
      //
      await _myAuth.signOut();
      return id;
    } catch (e) {
      print("Error in creating user" + e);
      return null;
    }
  }

  ///This will handle the logout
  static Future<bool> logout() async {
    try {
      await _myAuth.signOut();
      return true;
    } catch (e) {
      print("Error logout(): " + e.toString());
      return false;
    }
  }

  ///This is the auto Login and it will load the user from the database
  ///if done then its true else then its false
  static Future<String> autoLogin() async {
    try {
      final auth = _myAuth.currentUser;
      if (auth.isAnonymous) return null;
      // get data
      MyUserControllers.loadUser(auth.uid);
      return auth.uid;
    } catch (e) {
      return null;
    }
  }

  ///This will get if the user been validated
  static bool checkIfUserBeenValidated() => _myAuth.currentUser.emailVerified;

  ///This to reset the email
  static Future<bool> sendResetPassword(String email) async {
    await _myAuth.sendPasswordResetEmail(email: email);
    return true;
  }

  static Future<bool> changeEmail(String email) async {
    ///[TODO]
    return true;
  }
}
