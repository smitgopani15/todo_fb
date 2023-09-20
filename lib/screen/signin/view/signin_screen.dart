// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_fb/service/firebase_service.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // text controller
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Sign In",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: email,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  prefixIcon: const Icon(Icons.password),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () async {
                  String? msg = await FirebaseService.firebaseService.signIn(
                    email: email.text,
                    password: password.text,
                  );
                  if (msg == "login successfully !") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$msg"),
                      ),
                    );
                    Navigator.pushReplacementNamed(context, 'home_screen');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$msg"),
                      ),
                    );
                  }
                },
                child: Text(
                  "Sign In",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'signup_screen');
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
