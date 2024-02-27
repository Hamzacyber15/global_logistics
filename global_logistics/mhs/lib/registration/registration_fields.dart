import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';

class RegistrationFields extends StatefulWidget {
  final Function getData;
  const RegistrationFields({required this.getData, super.key});

  @override
  State<RegistrationFields> createState() => _RegistrationFieldsState();
}

class _RegistrationFieldsState extends State<RegistrationFields> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool loading = false;
  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void sendData() {
    widget.getData(
        emailController, passwordController, confirmPasswordController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: TextField(
            onChanged: (value) {
              sendData();
            },
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              labelText: "Business Email",
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
            onChanged: (value) {
              sendData();
            },
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
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
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
            onChanged: (value) {
              sendData();
            },
            controller: confirmPasswordController,
            keyboardType: TextInputType.text,
            obscureText: hidePassword,
            decoration: InputDecoration(
              labelText: "Confirm Password",
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
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            cursorColor: AppTheme.primaryColor,
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Note: Please Keep this email address & password saved, It will be used for future login",
          style:
              TextStyle(color: AppTheme.redColor, fontWeight: FontWeight.w500),
        )
        // const SizedBox(
        //   height: 12,
        // ),
        // ElevatedButton(
        //   onPressed: register,
        //   child: const Text(
        //     'Submit',
        //   ),
        // ),
        // TextButton(
        //   onPressed: next,
        //   child: const Text(
        //     'Already have an account? Sign in',
        //   ),
        // ),
      ],
    );
  }
}
