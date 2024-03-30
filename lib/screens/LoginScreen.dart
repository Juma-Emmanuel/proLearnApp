import 'package:flutter/material.dart';
import 'package:online_course/Controllers/LoginRequest.dart';
import 'package:online_course/utils/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Textstyle textStyle = Textstyle();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  final LoginRequest request = LoginRequest();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome back!',
          style: textStyle.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              'Login to your Account',
              style: textStyle.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 30.0,
            ),
            child: SizedBox(
              width: 350,
              height: 48,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  focusedBorder: textfieldBorder,
                  enabledBorder: textfieldBorder,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: SizedBox(
              width: 350,
              height: 48,
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  focusedBorder: textfieldBorder,
                  enabledBorder: textfieldBorder,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 10.0,
            ),
            child: SizedBox(
              width: 350,
              height: 42,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, '/rootapp', ((route) => false));
                  request.loginRequest(
                    emailController.text,
                    passwordController.text,
                  );
                  request.onAuthentication = (isAuthenticated) {
                    if (isAuthenticated) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/rootapp', ((route) => false));
                      emailController.clear();
                      passwordController.clear();
                    } else {
                      emailController.clear();
                      passwordController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          margin: EdgeInsets.only(bottom: 340),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color.fromARGB(255, 189, 56, 38),
                          content: Text('Invalid Credentials.'),
                        ),
                      );
                    }
                  };
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF3B61C0),
                ),
                child: Text(
                  'Login',
                  style: textStyle.buttonText,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 200.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: Color(0XFF726666),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: Color(0XFFC41E3A)),
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
