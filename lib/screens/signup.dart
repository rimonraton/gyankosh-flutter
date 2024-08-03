import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gyankosh/apis/api.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  String errorMessage = "";

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    "assets/background.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Image.asset(
                        "assets/logoG.png",
                        height: 200,
                        width: 200,
                        alignment: Alignment.center,
                      )),
                      const SizedBox(height: 13),
                      Text(
                        "Gyankosh",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                                letterSpacing: 1)),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "SignUp",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Learn With Fun 😋",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.white70,
                                letterSpacing: 1,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 45),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  name = val!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  email = val!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              // TextFormField(
                              //   style: const TextStyle(
                              //     color: Colors.white,
                              //   ),
                              //   controller: _passwordController,
                              //   decoration: const InputDecoration(
                              //     enabledBorder: UnderlineInputBorder(
                              //         borderSide:
                              //             BorderSide(color: Colors.white)),
                              //     hintText: "Password",
                              //     hintStyle: TextStyle(
                              //         color: Colors.white70, fontSize: 15),
                              //   ),
                              //   onSaved: (val) {
                              //     password = val!;
                              //   },
                              // ),
                              TextFormField(
                                obscureText: _obscureText,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white)),
                                  labelText: "Password",
                                  labelStyle: const TextStyle(
                                      color: Colors.white70, fontSize: 20),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(
                                            () {
                                          _obscureText = !_obscureText;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              errorMessage.isNotEmpty
                                  ? Text(
                                errorMessage,
                                style: const TextStyle(color: Colors.red, fontSize: 20),
                              )
                                  : const SizedBox.shrink(),

                              const SizedBox(
                                height: 10,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (isLoading) {
                                          return;
                                        }
                                        if (_nameController.text.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Please Enter Name')),
                                          );
                                          return;
                                        }
                                        if (!reg
                                            .hasMatch(_emailController.text)) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Enter Valid Email')),
                                          );
                                          // _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Enter Valid Email")));
                                          return;
                                        }
                                        if (_passwordController.text.isEmpty ||
                                            _passwordController.text.length <
                                                8) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Password should be min 8 characters')),
                                          );
                                          // _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Password should be min 6 characters")));
                                          return;
                                        }
                                        signup(
                                            _nameController.text,
                                            _emailController.text,
                                            _passwordController.text);
                                      },
                                      child: Text(
                                        "CREATE ACCOUNT",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                letterSpacing: 1)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    bottom: 0,
                                    top: 0,
                                    child: (isLoading)
                                        ? const Center(
                                            child: SizedBox(
                                                height: 26,
                                                width: 26,
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: Colors.green,
                                                )))
                                        : Container(),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/signin');
                        },
                        child: Text(
                          "Already have an account?",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  decoration: TextDecoration.underline,
                                  letterSpacing: 0.5)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  signup(name, email, password) async {
    setState(() {
      isLoading = true;
    });
    print("Calling");

    Map data = {'email': email, 'password': password, 'name': name};
    print(data.toString());
    var url = Uri.parse(REGISTRATION);
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> user = jsonDecode(response.body);
      print('response body user => ${response.statusCode} $user');
      savePref(1, user['name'], user['email'], user['id'], password);
      context.go('/dashboard');
      setState(() {
        errorMessage = "";
      });

    } else {
      Map<String, dynamic> ed = jsonDecode(response.body);
      // setState(() {
      //   errorMessage = jsonDecode(response.body)['errors']['email'].toString();
      // });

      print('response Error user => ${response.statusCode} $ed');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ed.toString())),
      );
    }
  }

  savePref(
      int login, String name, String email, int id, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("login", login);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("password", password);
    preferences.setString("id", id.toString());
    // preferences.commit();
  }

  // savePref(int value, String name, String email, int id) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //
  //   preferences.setInt("value", value);
  //   preferences.setString("name", name);
  //   preferences.setString("email", email);
  //   preferences.setString("id", id.toString());
  //   preferences.commit();
  // }
}
