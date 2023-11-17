import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../components/square_tile.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
        Navigator.pushNamed(context, 'homePage');
      } else {
        Navigator.pop(context);
        showErrorMessage("Passwords do not match");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
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
            size: 100,
          )),
          const SizedBox(height: 10),
          const Center(
              child: Text(
            "Welcome...",
            style: TextStyle(fontSize: 20),
          )),
          const SizedBox(height: 10),
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
          MyTextField(
            controller: confirmPasswordController,
            hintText: "Confirm Password",
            obscureText: true,
          ),
          MyButton(
            onTap: signUserUp,
            text: "Sign Up...",
          ),
          const SizedBox(height: 15),
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'loginPage');
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          )
        ],
      )),
    );
  }
}
