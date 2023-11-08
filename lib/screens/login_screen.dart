// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unnispick_test/components/phone_number_modal.dart';

import 'package:unnispick_test/screens/registration_screen.dart';

import 'package:unnispick_test/components/auth_card.dart';
import 'package:unnispick_test/components/auth_text_field.dart';
import 'package:unnispick_test/components/glassmorph.dart';
import 'package:unnispick_test/components/rounded_button.dart';
import 'package:unnispick_test/constans.dart';
import 'package:unnispick_test/screens/weathers_screen.dart';
import 'package:unnispick_test/services/single_sign_on.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SingleSignOn sso = SingleSignOn();

  bool showSpinner = false;
  String email = '';
  String password = '';

  void setSpinner(bool state) {
    setState(() {
      showSpinner = state;
    });
  }

  void onPressLogin() async {
    setSpinner(true);
    try {
      await sso.auth
          .signInWithEmailAndPassword(email: email, password: password);

      goToWeathers();
    } on FirebaseAuthException catch (e) {
      setSpinner(false);

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      print(e);
    } catch (e) {
      setSpinner(false);
      print(e);
    }
  }

  void onPressGoogleLogin() async {
    setSpinner(true);
    try {
      await sso.signInGoogle(onSuccess: () => goToWeathers());
    } catch (e) {
      print(e);
    } finally {
      setSpinner(false);
    }
  }

  void onPressPhoneLogin(BuildContext context, String phoneNumber) async {
    setSpinner(true);
    try {
      await sso.signInPhoneNumber(
          context: context,
          phoneNumber: phoneNumber,
          onSuccess: () {
            Navigator.of(context).pop();
            goToWeathers();
          });
    } catch (e) {
      print(e);
    } finally {
      setSpinner(false);
    }
  }

  void goToWeathers() {
    setSpinner(false);
    Navigator.pushNamed(context, WeathersScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey[900],
        body: ModalProgressHUD(
            blur: 8.0,
            inAsyncCall: showSpinner,
            child: Glassmorph(
                children: SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36.0,
                          vertical: 30.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Log in',
                                style: TextStyle(
                                    fontSize: 36.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 48.0),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      'Login with one of the following options',
                                      style: kLabelTextStyle),
                                  const SizedBox(height: 8.0),
                                  Row(children: [
                                    AuthCard(
                                        icon: FontAwesomeIcons.google,
                                        onPressed: onPressGoogleLogin),
                                    const SizedBox(width: 4.0),
                                    AuthCard(
                                        icon: FontAwesomeIcons.phoneFlip,
                                        onPressed: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) =>
                                                  PhoneNumberModal(
                                                      buttonTitle: 'Log in',
                                                      onPressed: (phoneNumber) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        onPressPhoneLogin(
                                                            context,
                                                            phoneNumber);
                                                      }));
                                        }),
                                  ]),
                                ]),
                            Padding(
                                padding: const EdgeInsets.only(top: 60.0),
                                child: Column(
                                  children: [
                                    AuthTextField(
                                      label: "Email",
                                      onChanged: (val) => {email = val},
                                      placeholder: 'your@email.com',
                                    ),
                                    AuthTextField(
                                      label: "Password",
                                      onChanged: (val) => {password = email},
                                      isPassword: true,
                                      placeholder: 'Pick a Strong Password',
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 54.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    RoundedButton(
                                        onPressed: () => onPressLogin(),
                                        title: 'Log in'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Don\'t have an Account? ',
                                            style: kPrimaryTextStyle),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, RegistrationScreen.id);
                                          },
                                          child: Text('Register',
                                              style: kPrimaryTextStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  decoration:
                                                      TextDecoration.combine([
                                                    TextDecoration.underline
                                                  ]))),
                                        )
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ))))));
  }
}
