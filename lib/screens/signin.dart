import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gyankosh/apis/api.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obscureText = true;
  // late String _password;
  String errorMessage = "";
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  var _loginStatus;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = preferences.getString("email");
    });
  }

  final _formKey = GlobalKey<FormState>();
  late String email, password;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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
                Column(
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
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      "Gyankosh",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontSize: 27,
                              color: Colors.white,
                              letterSpacing: 1)),
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Sign In",
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
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Colors.white70, fontSize: 20)),
                              onSaved: (val) {
                                email = val!;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
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
                              style: const TextStyle(color: Colors.red),
                            )
                                : const SizedBox.shrink(),

                            const SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (isLoading) {
                                      return;
                                    }
                                    if (_emailController.text.isEmpty ||
                                        _passwordController.text.isEmpty) {
                                      // _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Fill all fileds")));
                                      return;
                                    }
                                    login(_emailController.text,
                                        _passwordController.text);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    //Navigator.pushReplacementNamed(context, "/home");
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      "SIGN IN",
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
                                              child: CircularProgressIndicator(
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
                    // const Text(
                    //   "OR",
                    //   style: TextStyle(fontSize: 14, color: Colors.white60),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Image.asset(
                    //   "assets/fingerprint.png",
                    //   height: 36,
                    //   width: 36,
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go('/signUp');
                      },
                      child: Text(
                        "Don't have an account?",
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
              ],
            ),
          ),
        ));
  }

  login(email, password) async {
    Map data = {'email': email, 'password': password};
    print(data.toString());
    var url = Uri.parse(LOGIN);
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
          // "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    // if (response.statusCode == 200) {
    //   var user = jsonDecode(response.body);
    //   print('Response from server -> $user');
    //   print("Print User Id -> ${user['id']}");
    // }else{
    //   print('response.statusCode -> ${response.statusCode}');
    // }
    setState(() {
      isLoading = false;
    });

    // print('jsonDecode(response.body) ${response.statusCode} => ${jsonDecode(response.body)}');

    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body);
      print('response body user => ${response.statusCode}');
      savePref(1, user['name'], user['email'], user['id'], password);
      // Navigator.pushReplacementNamed(context, "/dashboard");
      context.go('/dashboard');
      // _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("${resposne['message']}")));
    } else {
      setState(() {
        errorMessage = "These credentials do not match our records!";
      });
      print('jsonDecode(response.body) ${jsonDecode(response.body)}');
      // Map<String, dynamic> user = jsonDecode(response.body);
      // print(" ${user['message']}");
      // _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please try again!")));
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
}
