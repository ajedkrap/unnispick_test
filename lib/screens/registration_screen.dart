// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unnispick_test/components/phone_number_modal.dart';

import 'package:unnispick_test/screens/login_screen.dart';

import 'package:unnispick_test/components/auth_card.dart';
import 'package:unnispick_test/components/auth_text_field.dart';
import 'package:unnispick_test/components/glassmorph.dart';
import 'package:unnispick_test/components/rounded_button.dart';
import 'package:unnispick_test/constans.dart';
import 'package:unnispick_test/screens/weathers_screen.dart';
import 'package:unnispick_test/services/single_sign_on.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  SingleSignOn sso = SingleSignOn();

  bool showSpinner = false;
  String email = '';
  String password = '';

  void setSpinner(bool state) {
    setState(() {
      showSpinner = state;
    });
  }

  void onPressRegister() async {
    setSpinner(true);
    try {
      await sso.auth
          .createUserWithEmailAndPassword(email: email, password: password);

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

  void onPressGoogleSignIn() async {
    setSpinner(true);
    try {
      await sso.signInGoogle(onSuccess: () => goToWeathers());
    } catch (e) {
      print(e);
    } finally {
      setSpinner(false);
    }
  }

  void onPressPhoneSignIn(BuildContext context, String phoneNumber) async {
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
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                            height: 40.0,
                                            width: 40.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                    color: kBorderColor,
                                                    width: 2.0)),
                                            child: const Icon(
                                              Icons.chevron_left,
                                              color: Colors.white,
                                              size: 36.0,
                                            )))),
                                const Text('Register',
                                    style: TextStyle(
                                        fontSize: 36.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                            const SizedBox(height: 48.0),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      'Register with one of the following options',
                                      style: kLabelTextStyle),
                                  const SizedBox(height: 8.0),
                                  Row(children: [
                                    AuthCard(
                                        icon: FontAwesomeIcons.google,
                                        onPressed: onPressGoogleSignIn),
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
                                                       
                                                        onPressPhoneSignIn(
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
                                        onPressed: () => onPressRegister(),
                                        title: 'Create Account'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Already have an Account? ',
                                            style: kPrimaryTextStyle),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, LoginScreen.id);
                                          },
                                          child: Text('Log in',
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
