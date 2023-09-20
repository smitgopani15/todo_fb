import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_fb/service/firebase_service.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    // old data
    List dataList = ModalRoute.of(context)!.settings.arguments as List;

    var t = dataList[0].title;
    var d = dataList[0].description;
    var id = dataList[0].id;

    // text controller
    TextEditingController title = TextEditingController(text: t);
    TextEditingController description = TextEditingController(text: d);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Update ToDo",
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
                  FirebaseService.firebaseService.updateTodo(
                    id: id,
                    title: title.text,
                    description: description.text,
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  "Update",
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
