import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_2/components/my_button.dart';
import 'package:news_app_2/components/my_text_field.dart';
import 'package:news_app_2/components/square_tile.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (_) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
      Navigator.pushNamed(context, 'homePage');
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
                child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 30),
            const Center(
                child: Icon(
              Icons.lock,
              size: 130,
            )),
            const SizedBox(height: 15),
            const Center(
                child: Text(
              "Welcome Back",
              style: TextStyle(fontSize: 20),
            )),
            const SizedBox(height: 20),
            MyTextField(
              controller: emailController,
              hintText: "E - mail",
              obscureText: false,
            ),
            MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(
              height: 15,
            ),
            MyButton(
              onTap: signUserIn,
              text: "Sign In...",
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Or Continue with",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                  )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(
                  imagePath: 'lib/images/google.jpg',
                  onTap: () => AuthService().signInWithGoogle(),
                ),
                const SizedBox(
                  width: 25,
                ),
                SquareTile(
                  imagePath: 'lib/images/apple.jpg',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Not a member?",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'registerPage');
                    },
                    child: const Text(
                      "Register now",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
