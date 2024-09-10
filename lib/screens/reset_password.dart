import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gyankosh/apis/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  late String email;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
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
                      "Recover Password",
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
                                    checkEmail(_emailController.text);
                                    setState(() {
                                      isLoading = true;
                                    });
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
                                      "RESET",
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
                        context.go('/signIn');
                      },
                      child: Text(
                        "Back to Login",
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

  savePref(int verification, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("verification", verification);
    preferences.setString("email", email);
  }

  checkEmail(email) async {
    Map data = {'email': email};
    var url = Uri.parse(resetPassword);
    final response = await http.post(url,
        headers: headersJson,
        body: data,
        encoding: Encoding.getByName("utf-8"));
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      Map user = jsonDecode(response.body);
      print('jsonDecode(response.body) $user');
      savePref(user['verification'], user['email']);
      context.go('/updatePassword');
    } else {
      setState(() {
        errorMessage = "Email not found!";
      });

    }
  }
}
