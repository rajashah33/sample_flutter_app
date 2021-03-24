import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class CustomPopups {
  // Future<bool> authPopup(BuildContext context) async {
  //   print('authPopup');
  //   bool returnValue = false;
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context1) {
  //         return AlertDialog(
  //           title: new Text('Please Sign in as a user first'),
  //           actions: [
  //             FlatButton(
  //               child: Text('Cancel'),
  //               onPressed: () {
  //                 returnValue = false;
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             FlatButton(
  //               child: Text('Yes'),
  //               onPressed: () async {
  //                 Navigator.pop(context);
  //                 await Navigator.push(
  //                     context,
  //                     CupertinoPageRoute(
  //                       builder: (context) =>
  //                           LoginPage(role: Role.Customer, shouldPop: true),
  //                     )).then((isLoginSuccess) {
  //                   print('returned value from login POP: $isLoginSuccess');
  //                   returnValue = isLoginSuccess;
  //                 });
  //               },
  //             )
  //           ],
  //         );
  //       });
  //   return returnValue;
  // }

  showLoadingIndicator(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 15), child: Text(message)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        return alert;
      },
    );
  }

  showMessageFlushbar(context, String message, autoNextPage,
      {Function onFinish, bool shouldPop = false}) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
      ),
      backgroundColor: Colors.purple,
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue,
    ).show(context).then((r) {
      if (onFinish != null) {
        onFinish();
      }
      if (shouldPop) {
        Navigator.pop(context);
        return;
      }
      autoNextPage == null
          ? Container()
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => autoNextPage));
    });
  }
}
