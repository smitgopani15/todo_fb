import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_fb/service/firebase_service.dart';

class InsertScreen extends StatefulWidget {
  const InsertScreen({super.key});

  @override
  State<InsertScreen> createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  // text controller
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Insert ToDo",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: title,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: description,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseService.firebaseService.insertTodo(
                    title: title.text,
                    description: description.text,
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  "Insert",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
