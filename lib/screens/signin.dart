import 'package:blogify/components/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: const BackButton(
            color: Colors.indigoAccent,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/signup.jpg"),
                  height: 300,
                ),
                const Text(
                  ("Register"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 36.0),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: "Email",
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder()),
                            onChanged: (String value) {
                              email = value;
                            },
                            validator: (value) {
                              return value!.isEmpty ? "Enter Email" : null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "Password",
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                password = value;
                              },
                              validator: (value) {
                                return value!.isEmpty ? "Enter Email" : null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          RoundButton(
                              title: "REGISTER",
                              onPress: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try {
                                    final user = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: email.toString().trim(),
                                            password:
                                                password.toString().trim());
                                    if (user != null) {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      print("Success");
                                      toastMessages(
                                          "User Successfully Created");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    }
                                  } catch (e) {
                                    print(e.toString());
                                    toastMessages(e.toString());
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  }
                                }
                              }),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void toastMessages(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.indigoAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
