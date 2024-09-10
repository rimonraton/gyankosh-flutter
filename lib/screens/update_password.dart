import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gyankosh/apis/api.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  UpdatePasswordState createState() => UpdatePasswordState();
}

class UpdatePasswordState extends State<UpdatePassword> {
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
  }

  final _formKey = GlobalKey<FormState>();
  late String verification, password;
  bool isLoading = false;
  final TextEditingController _verificationController = TextEditingController();
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
                      "Update Password",
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
                              controller: _verificationController,
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white)),
                                  labelText: "Verification Code",
                                  labelStyle: TextStyle(
                                      color: Colors.white70, fontSize: 20)),
                              onSaved: (val) {
                                verification = val!;
                              },
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
                                labelText: "New Password",
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
                                    if (_passwordController.text.isEmpty ||
                                        _passwordController.text.length <
                                            8) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Password should be min 8 characters')),
                                      );
                                      return;
                                    }
                                    updatePasswordFnc(_verificationController.text,
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
                                      "UPDATE PASSWORD",
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
  var verificationCode = 0;
  var userEmail = '';

  updatePasswordFnc(verification, password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    verificationCode = preferences.getInt("verification")!;
    userEmail = preferences.getString("email")!;
    print('verification != verificationCode => $verification => $verificationCode');
    if(int.parse(verification) != verificationCode){
      print("Verification code not match!");
      setState(() {
        isLoading = false;
        errorMessage = 'Verification code not match! Please check your email for verification code.';
      });
      return;
    }
    Map data = {'email':userEmail, 'password': password};
    print(data.toString());
    var url = Uri.parse(updatePassword);
    final response = await http.post(url,
        headers: headersJson,
        body: data,
        encoding: Encoding.getByName("utf-8"));
    setState(() {
      isLoading = false;
    });
    print('jsonDecode(response.body) ${response.statusCode}');
    if (response.statusCode == 200) {
      Map user = jsonDecode(response.body);
      print('jsonDecode(response.body) $user');
      preferences.setInt("login", 1);
      preferences.setString("password", password);

      context.go('/dashboard');
    } else {
      setState(() {
        errorMessage = "Email not found!";
      });

    }

  }

}
