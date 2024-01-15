import 'package:blogify/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/round_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = "";
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.indigoAccent,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/forget.jpg"),
                  height: 420,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 18.0),
                          ),
                          RoundButton(
                              title: "RECOVER PASSWORD",
                              onPress: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try {
                                    _auth
                                        .sendPasswordResetEmail(
                                            email:
                                                emailController.text.toString())
                                        .then((value) {
                                      toastMessages(
                                          "Reset Link has been send to your Email");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    }).onError((error, stackTrace) {
                                      toastMessages(error.toString());
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    });
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
