import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/check_profile.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/loading_widget.dart';
import 'package:mhs/registration/forgot_password.dart';
import 'package:mhs/registration/user_type.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
        /// we need to decide what should be the flow for terms page?
        return const CheckProfile();
      }), (route) => false);
    }).catchError((onError) {
      setState(() {
        loading = false;
      });
      Constants.showMessage(context, onError.message);
    });
  }

  void checkCredentials() {
    if (loading) {
      return;
    }
    if (emailController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please enter your your Email Address");
    } else if (passwordController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please enter your Password");
    } else {
      login();
    }
  }

  void next() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const UserType();
        },
      ),
    );
  }

  void goforgotPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const ForgotPassword();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constants.bigScreen = size.width > 700;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: loading
            ? const LoadingWidget()
            : Center(
                child: SizedBox(
                  width: Constants.bigScreen
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            height: 250,
                            width: 400,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      //'assets/images/logo_new.jpg',
                                      'assets/images/logo_new.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Card(
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                labelText: "Email",
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5),
                              ),
                              cursorColor: AppTheme.primaryColor,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          Card(
                            child: TextField(
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                labelText: "Password",
                                contentPadding: const EdgeInsets.all(5),
                                prefixIcon: const Icon(
                                  Icons.password_rounded,
                                  color: Colors.black,
                                ),
                                suffixIcon: IconButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Icon(
                                      hidePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                              ),
                              cursorColor: AppTheme.primaryColor,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                checkCredentials();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: goforgotPassword,
                                  child: const Text("Forgot Password?"),
                                ),
                                ElevatedButton(
                                  onPressed: checkCredentials,
                                  child: const Text(
                                    'Sign in',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: next,
                            child: const Text(
                              "Don't have an account ? Sign up",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
