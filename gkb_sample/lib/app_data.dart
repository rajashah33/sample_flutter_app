class AppData {
  AppData._privateConstructor();
  static final AppData instance = AppData._privateConstructor();

  bool isLoggedIn = false;
  User currentUser = User(
    fname: 'Raja',
    lname: 'Shah',
    email: 'rajashah33@gmail.com',
    phone: '0032587410',
    pass: 'Raja123@',
  );

  List<User> allUsers = [
    User(
      fname: 'Raja',
      lname: 'Shah',
      email: 'rajashah33@gmail.com',
      phone: '9632587410',
      pass: 'Raja123@',
    )
  ];
}

class User {
  String fname;
  String lname;
  String email;
  String phone;
  String pass;

  User({
    this.fname,
    this.lname,
    this.email,
    this.phone,
    this.pass,
  });
}
