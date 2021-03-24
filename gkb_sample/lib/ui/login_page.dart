import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gkb_sample/app_data.dart';
import 'package:gkb_sample/ui/home_page.dart';
import 'package:gkb_sample/ui/register_page.dart';
import 'package:gkb_sample/util/popups.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AppData appData = AppData.instance;

  var passwordCtrl = TextEditingController();
  var emailCtrl = TextEditingController();

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return isAvailable;
    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    print(listOfBiometrics);
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to Login",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    isAuthenticated
        ? print('User is authenticated!')
        : print('User is not authenticated.');

    if (isAuthenticated) {
      CustomPopups().showMessageFlushbar(context, 'Authenticated', null);
      // login success
      appData.isLoggedIn = true;
      // appData.currentUser = x;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => TransactionScreen(),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text('LOGIN',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Username',
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                // validator: model.validateEmail,
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Password',
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                // focusNode: model.passNode,
                controller: passwordCtrl,
                keyboardType: TextInputType.text,
                obscureText: true,
                // onFieldSubmitted: (v) {
                //   FocusScope.of(context).unfocus();
                // },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                      onPressed: () async {
                        // if (await model.forgotPassword()) {
                        //   showDialog(
                        //       context: context,
                        //       builder: (context1) => new AlertDialog(
                        //             title: new Text(model.message),
                        //             actions: [
                        //               FlatButton(
                        //                 child: Text('ok'),
                        //                 onPressed: () {
                        //                   Navigator.pop(context);
                        //                 },
                        //               )
                        //             ],
                        //           ));
                        // } else {
                        //   // some error
                        //   model.customPopups.showMessageFlushbar(
                        //       context, "Server Error", null);
                        // }
                      },
                      child: Text('Forgot Password')),

                  // SizedBox(width: 60),
                  // RaisedButton(
                  //   color: Colors.purple[100],
                  //   child: Text('Cancel'),
                  //   onPressed: () {
                  //     // model.clearScreen();
                  //     Navigator.of(context).pop(false);
                  //   },
                  // ),
                  SizedBox(width: 10),
                  RaisedButton(
                    child: Text('Login'),
                    onPressed: () async {
                      for (var x in appData.allUsers) {
                        if (x.email == emailCtrl.text.trim() &&
                            x.pass == passwordCtrl.text.trim()) {
                          // login success
                          appData.isLoggedIn = true;
                          appData.currentUser = x;

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      }
                      if (!appData.isLoggedIn) {
                        CustomPopups().showMessageFlushbar(
                            context, 'Failed.. Check the credentials', null);
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              child: Text(
                'Create Account',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => RegisterPage(),
                    ));
              },
            ),
            SizedBox(height: 50),
            Text('or'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment:CrossAxisAlignment.stretch,
              children: [
                RaisedButton(
                    child: Text('Login Using Biometrics'),
                    onPressed: () async {
                      if (await _isBiometricAvailable()) {
                        await _getListOfBiometricTypes();
                        await _authenticateUser();
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
