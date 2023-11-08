// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unnispick_test/constans.dart';

class SingleSignOn {
  final auth = FirebaseAuth.instance;

  Future<void> signInPhoneNumber(
      {required BuildContext context,
      String phoneNumber = '',
      required Function() onSuccess}) async {
    TextEditingController? smsCodeController;

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
            onSuccess();
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            }
          },
          timeout: const Duration(seconds: 12),
          codeSent: (String verificationId, int? resendToken) async {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      backgroundColor: Colors.blueGrey[800],
                      title: const Text("Enter SMS Code"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: smsCodeController,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            var smsCode = smsCodeController!.text.trim();

                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: smsCode);
                            await auth.signInWithCredential(credential);
                            onSuccess();
                          },
                          child: const Text("Done", style: kPrimaryTextStyle),
                        )
                      ],
                    ));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            throw 'Timeout';
          });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInGoogle({required Function() onSuccess}) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      onSuccess();
    } catch (e) {
      throw Exception(e);
    }
  }
}
