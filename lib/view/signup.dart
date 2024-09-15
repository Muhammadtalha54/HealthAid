import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthaid/Models/Usersmosel.dart';
import 'package:healthaid/view/Loginscreen.dart';
import 'package:uuid/uuid.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController NameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var _isloading = false;
  bool isValidEmail(v) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(v);
  }

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  bool _showPassword = false;
  // to save data in firebase firestore
   void _Usercreated(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(90, 88, 88, 1),
          title: Text(
            'SignUp Successfull',
            style: GoogleFonts.ibmPlexSans(
                color: Color.fromARGB(255, 255, 253, 253)),
          ),
          content: Text(
            'The Signup Request was successfull click ok to continue to login',
            style: GoogleFonts.ibmPlexSans(
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
              Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 177, 173, 173),
              ),
              //color: Colors.green,
              //  minSize: width! * 0.03,
              // backgroun: Color.fromARGB(207, 211, 80, 80),
              child: Text(
                'Login',
                style: GoogleFonts.ibmPlexSans(
                  color: Color.fromARGB(255, 251, 249, 249),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void savedata() async {
    var id = Uuid();
    var userid = id.v4();
    //v4puchna ha
    Users model = Users(
        Name: NameController.text,
        Email: emailController.text,
        password: passwordController.text,
        userId: userid,
        Profilepic: '');

    QuerySnapshot emailcheck = await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: emailController.text)
        .get();
    if (emailcheck.docs.isNotEmpty) {
      print('Enter another email');
    } else {
      if (_formKey.currentState!.validate()) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userid)
            .set(model.toMap());
        // print(NameController.text);
        //print(emailcontroller.text);
        //print(passwordController.text);
        // Get.snackbar(
        //     "SignUP Successful", "Your Account has been created please login",
        //     snackPosition: SnackPosition.TOP);
        // ;
       _Usercreated(context);
      }
    }
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle signup logic here
      print('Signup attempt with: $_name, $_email, $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double padding = screenWidth * 0.04; // 4% of screen width
    final double imageSize = screenWidth * 0.25; // 25% of screen width
    final double fontSizeTitle = screenWidth * 0.06; // 6% of screen width
    final double fontSizeField = screenWidth * 0.04; // 4% of screen width
    final double buttonHeight = screenHeight * 0.07; // 7% of screen height
    final double fontSize = screenWidth * 0.06;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/on1.png',
                            width: imageSize,
                            height: imageSize,
                          ),
                          SizedBox(height: padding),
                          Text(
                            'Create an Account',
                            style: TextStyle(
                              fontSize: fontSizeTitle,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: padding),
                          TextFormField(
                            controller: NameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: padding, vertical: padding * 0.5),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              if (value.length < 3) {
                                return 'Must be more than 3 characters';
                              }
                              return null;
                            },
                            onSaved: (value) => _name = value!,
                            style: TextStyle(fontSize: fontSizeField),
                          ),
                          SizedBox(height: padding),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: padding, vertical: padding * 0.5),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            onSaved: (value) => _email = value!,
                            style: TextStyle(fontSize: fontSizeField),
                          ),
                          SizedBox(height: padding),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: padding, vertical: padding * 0.5),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_showPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'password required';
                              }
                              if (value.length < 6) {
                                return 'Must be more than 6 charater';
                              }
                              // if (!RegExp(
                              //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              //     .hasMatch(text)) {
                              //   return "Please enter a valid password";
                              // }
                              return null;
                            },
                            onSaved: (value) => _password = value!,
                            style: TextStyle(fontSize: fontSizeField),
                          ),
                          SizedBox(height: padding * 1.5),
                          ElevatedButton(
                            onPressed: savedata,
                            child: Text(
                              'Sign up',
                              style: TextStyle(fontSize: fontSize * 0.6),
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              minimumSize: Size(double.infinity, buttonHeight),
                            ),
                          ),
                          SizedBox(height: padding),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text("Already have an account? Sign in"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _emailchecking(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Account Already Exists',
            style: GoogleFonts.ibmPlexSans(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: width! * 0.04),
          ),
          content: Text(
            'Account is already created choose an other emailid',
            style: GoogleFonts.ibmPlexSans(
                color: const Color.fromARGB(255, 0, 0, 0),
                //ontWeight: FontWeight.bold,
                fontSize: width! * 0.037),
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 247, 245, 239),
              ),
              //color: Colors.green,
              //  minSize: width! * 0.03,
              // backgroun: Color.fromARGB(207, 211, 80, 80),
              child: Text(
                'Close',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
