import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gkb_sample/app_data.dart';
import 'package:gkb_sample/ui/login_page.dart';
import 'package:gkb_sample/util/app_config.dart';
import 'package:gkb_sample/util/popups.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppData appData = AppData.instance;

  final postTextCtrl = TextEditingController();
  List statusList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                  appData.currentUser.fname + ' ' + appData.currentUser.lname),
              accountEmail: Text(appData.currentUser.email),
              currentAccountPicture: Container(
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/default_avatar.png')),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_filled, color: AppConfig.primaryColor),
              title: Text("Home "),
              onTap: () async {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.build, color: AppConfig.primaryColor),
              title: Text("Settings"),
              onTap: () async {},
            ),
            ListTile(
              leading: Icon(Icons.call, color: AppConfig.primaryColor),
              title: Text("Contact Us"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout, color: AppConfig.primaryColor),
              title: Text("Sign out"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context1) => new AlertDialog(
                          title: new Text('Do you really want to Sign out'),
                          actions: [
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () async {
                                appData.isLoggedIn = false;
                                // appData.currentUser = null;
                                print('Logged In: ${appData.isLoggedIn}');
                                // logout poped out
                                if (!appData.isLoggedIn) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                      (Route<dynamic> route) => false);
                                } else {
                                  CustomPopups().showMessageFlushbar(
                                      context, 'Error in Logout', null);
                                }
                              },
                            )
                          ],
                        ));
              },
            )
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 15),
                      child: TextField(
                        minLines: 3,
                        maxLines: 11,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: 'Write your status here',
                          filled: true,
                          fillColor: Color(0xFFDBEDFF),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        controller: postTextCtrl,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () async {
                      var pickedFile = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        File cropped = await ImageCropper.cropImage(
                          sourcePath: pickedFile.path,
                          aspectRatioPresets: Platform.isAndroid
                              ? [
                                  CropAspectRatioPreset.square,
                                  CropAspectRatioPreset.ratio3x2,
                                  CropAspectRatioPreset.original,
                                  CropAspectRatioPreset.ratio4x3,
                                  CropAspectRatioPreset.ratio16x9
                                ]
                              : [
                                  CropAspectRatioPreset.original,
                                  CropAspectRatioPreset.square,
                                  CropAspectRatioPreset.ratio3x2,
                                  CropAspectRatioPreset.ratio4x3,
                                  CropAspectRatioPreset.ratio5x3,
                                  CropAspectRatioPreset.ratio5x4,
                                  CropAspectRatioPreset.ratio7x5,
                                  CropAspectRatioPreset.ratio16x9
                                ],
                          androidUiSettings: AndroidUiSettings(
                              toolbarTitle: 'Crop Image',
                              toolbarColor: AppConfig.primaryColor,
                              toolbarWidgetColor: Colors.white,
                              initAspectRatio: CropAspectRatioPreset.original,
                              lockAspectRatio: false),
                          iosUiSettings: IOSUiSettings(
                            title: 'Crop Image',
                          ),
                        );

                        if (cropped != null) {
                          await showDialog(
                            context: context,
                            builder: (context1) {
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.of(context1).pop(true);
                                CustomPopups().showMessageFlushbar(
                                    context, 'Upload Success', null);
                                setState(() {
                                  print(postTextCtrl.text);
                                  var x = {
                                    'img': cropped,
                                    'caption': postTextCtrl.text
                                  };
                                  this.statusList.add(x);
                                });
                              });
                              return AlertDialog(
                                content: new Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Text('Uploading.. Please wait')),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        //TODO: apply user message prompt
                        print('No image selected.');
                      }
                    })
              ],
            ),
            for (var pic in statusList)
              Container(
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(pic['img']),
                    ),
                    Text(pic['caption'])
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
