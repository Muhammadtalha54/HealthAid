import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthaid/Models/Staticmodel.dart';
import 'package:healthaid/Models/Usersmosel.dart';

import 'package:healthaid/view/Homescreen.dart';
import 'package:healthaid/view/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _showPassword = false;
  bool isValidEmail(v) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(v);
  }

  void _handleLogin() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        //This is the starting point to access the Firestore database in your Flutter app.
        .collection('Users')
        // It specifies that you want to work with a collection named "People" in your Firestore database.

        .where("Email", isEqualTo: emailController.text)
        //This line adds a filter to the query. It says you want to retrieve documents where the "email" field matches the value stored in the emailcontroller.text variable.
        .where("password", isEqualTo: passwordController.text)
        //This executes the query and retrieves the documents that meet the specified conditions.
        .get();
    //message to be shown when the data does not match
    if (query.docs.isEmpty) {
      // print("email or passord is incorrect");
      _Incorrectpopup(context);
    } else {
      //This line prints the data of the first document
      print(query.docs[0].data());
      //Here, it creates a People object named model by converting the data from the first document in the query result into an instance of the People class.
      Users model = Users.fromMap(query.docs[0].data() as Map<String, dynamic>);
      Staticdata.userModel = model;
      // Staticdata.userModel.

      print(model);
      saveLoginDataToSF(model.userId!);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
      if (_formKey.currentState!.validate()) {
        // print(emailcontroller.text);
        //print(passwordController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double padding = screenWidth * 0.04; // 4% of screen width
    final double imageSize = screenWidth * 0.25; // 25% of screen width
    final double fontSize = screenWidth * 0.06; // 6% of screen width
    final double buttonHeight = screenHeight * 0.07; // 7% of screen height

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
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: padding),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onSaved: (value) => _email = value!,
                          ),
                          SizedBox(height: padding),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
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
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onSaved: (value) => _password = value!,
                          ),
                          SizedBox(
                              height: padding *
                                  1.5), // 1.5 times the padding for more space
                          ElevatedButton(
                            onPressed: _handleLogin,
                            child: Text(
                              'Sign in',
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
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Don't have an account? Sign up",
                              style: TextStyle(
                                  fontSize: fontSize *
                                      0.6), // 80% of the main font size
                            ),
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

  saveLoginDataToSF(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', id);
  }

  void _Incorrectpopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(90, 88, 88, 1),
          title: Text(
            'Incorrect details',
            style: GoogleFonts.ibmPlexSans(
                color: Color.fromARGB(255, 255, 253, 253)),
          ),
          content: Text(
            'Password or email incorrect',
            style: GoogleFonts.ibmPlexSans(
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 177, 173, 173),
              ),
              //color: Colors.green,
              //  minSize: width! * 0.03,
              // backgroun: Color.fromARGB(207, 211, 80, 80),
              child: Text(
                'Close',
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
}
