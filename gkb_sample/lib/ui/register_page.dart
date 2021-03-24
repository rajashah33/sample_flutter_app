import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gkb_sample/app_data.dart';
import 'package:gkb_sample/ui/login_page.dart';
import 'package:gkb_sample/util/popups.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  AppData appData = AppData.instance;
  TextEditingController rePasswordCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  bool autoValidateRegister = false;

  Widget _getBodyUi(context) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).size.height > 550 ? 0 : 50, 0, 0),
            width: 140,
            height: 100,
            // child: Image.asset('assets/onor_logo.png'),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            autovalidate: autoValidateRegister,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text('REGISTER', style: TextStyle(fontSize: 35)),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: 'First Name',
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    // focusNode: model.firstnameNode,
                    validator: validateName,
                    controller: firstNameCtrl,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    // onFieldSubmitted: (v) {
                    //   FocusScope.of(context).requestFocus(model.lastnameNode);
                    // },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: 'Last Name',
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    // focusNode: model.lastnameNode,
                    validator: validateName,
                    controller: lastNameCtrl,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    // onFieldSubmitted: (v) {
                    //   FocusScope.of(context).requestFocus(model.emailNode);
                    // },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: 'Email',
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    // focusNode: model.emailNode,
                    controller: emailCtrl,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    // onFieldSubmitted: (v) {
                    //   FocusScope.of(context).requestFocus(model.phoneNode);
                    // },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: 'Phone',
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    // focusNode: model.phoneNode,
                    controller: phoneCtrl,
                    validator: validatePhone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    // onFieldSubmitted: (v) {
                    //   FocusScope.of(context).requestFocus(model.passNode);
                    // },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    // focusNode: model.passNode,
                    controller: passwordCtrl,
                    validator: validatePassword,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    // onFieldSubmitted: (v) {
                    //   FocusScope.of(context).requestFocus(model.repassNode);
                    // },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: 'Confirm Password',
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    // focusNode: model.repassNode,
                    controller: rePasswordCtrl,
                    validator: rePassword,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    // onFieldSubmitted: (v) {
                    //   FocusScope.of(context).unfocus();
                    // },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      color: Colors.purple[100],
                      child: Text('Cancel'),
                      onPressed: () {
                        // model.clearScreen();
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
                    RaisedButton(
                      child: Text('Register'),
                      onPressed: () async {
                        // if validated go back to login screen
                        if (_formKey.currentState.validate()) {
                          appData.allUsers.add(User(
                            fname: firstNameCtrl.text,
                            lname: lastNameCtrl.text,
                            phone: phoneCtrl.text,
                            email: emailCtrl.text,
                            pass: passwordCtrl.text,
                          ));
                          print('registered');
                          CustomPopups().showMessageFlushbar(
                              context, 'Success.. Login Now', null,
                              onFinish: () {
                            Navigator.pop(context);
                          });
                        } else {
                          // fields are not valid
                          setState(() {
                            autoValidateRegister = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _getBodyUi(context)),
    );
  }

  void clearScreen() {
    autoValidateRegister = false;
    firstNameCtrl.clear();
    lastNameCtrl.clear();
    emailCtrl.clear();
    phoneCtrl.clear();
    passwordCtrl.clear();
    rePasswordCtrl.clear();
    // message = '';
    // loginEmailCtrl.clear();
    // loginPasswordCtrl.clear();
  }

  String validateEmail(String value) {
    value = value.trim();

    if (value.length == 0) {
      return "Email is Required";
    }

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(value)) {
      RegExpMatch firstMatch = regExp.firstMatch(value);
      String matchVal = firstMatch.group(0);
      if (matchVal == value) {
        return null;
      }
    }
    return "Email is invalid";
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length > 20) {
      return "Must be less than 20 characters";
    } else {
      if (value.length == 0) {
        return "Required";
      } else if (!regExp.hasMatch(value)) {
        return "Invalid entry";
      }
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 8) {
      return "Enter a password more than 8 characters";
    } else {
      RegExp regexS = new RegExp(r'[a-z]+');
      RegExp regexC = new RegExp(r'[A-Z]+');
      RegExp regexN = new RegExp(r'[0-9]+');

      if (regexS.hasMatch(value) &&
          regexC.hasMatch(value) &&
          regexN.hasMatch(value)) {
        return null;
      }
      return "Password should contain lowercase, uppercase and number";
    }
  }

  String validatePhone(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length != 10) {
      return "Enter a valid Mobile no.";
    } else if (value.length == 0) {
      return "Mobile is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    } else {
      return null;
    }
  }

  String rePassword(String value) {
    print(passwordCtrl.text);
    if (value != passwordCtrl.text) {
      return "Password not matched";
    } else {
      return null;
    }
  }
}
