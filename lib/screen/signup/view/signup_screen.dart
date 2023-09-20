// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_fb/service/firebase_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // text controller
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Sign Up",
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
                controller: username,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
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
                  String? msg = await FirebaseService.firebaseService.signUp(
                    email: email.text,
                    password: password.text,
                  );
                  FirebaseService.firebaseService.insertUserDetail(
                    username: username.text,
                    email: email.text,
                  );

                  if (msg == "account created successfully !") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$msg"),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$msg"),
                      ),
                    );
                  }
                },
                child: Text(
                  "Sign Up",
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
                    "Already have an account?",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'signin_screen');
                    },
                    child: Text(
                      "Sign In",
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
