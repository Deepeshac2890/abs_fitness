import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationBloc {
  Firestore fs = Firestore.instance;
  final fa = FirebaseAuth.instance;

  Future<bool> register(
      String emailId, String password, String fName, String phoneNumber) async {
    if (emailId.contains('@') && password.length > 6) {
      try {
        // Always remember to enable authentication from firebase console
        final user = await fa.createUserWithEmailAndPassword(
            email: emailId, password: password);
        if (user != null) {
          await fs
              .collection('Users')
              .document(user.uid)
              .collection('Details')
              .document('Details')
              .setData({
            'Name': fName,
            'Email': emailId,
            'Profile Image': '',
            'Phone Number': phoneNumber,
          });
          await fs
              .collection('UIDS')
              .document(emailId)
              .setData({'uid': user.uid});
          await user.sendEmailVerification();
          return true;
        }
      } catch (e) {
        print(e);
        return false;
      }
    }
    return false;
  }
}
