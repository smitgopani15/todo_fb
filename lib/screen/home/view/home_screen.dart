import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_fb/screen/home/modal/screen_modal.dart';
import 'package:todo_fb/service/firebase_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ToDo",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseService.firebaseService.signOut();
                Navigator.pushReplacementNamed(context, 'signin_screen');
              },
              icon: const Icon(Icons.logout_outlined),
            )
          ],
        ),
        drawer: const Drawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'insert_screen');
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: FirebaseService.firebaseService.getTodo(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.hasError}"),
              );
            } else if (snapshot.hasData) {
              List<DataModal> dataList = [];
              QuerySnapshot? snapdata = snapshot.data;
              for (var x in snapdata!.docs) {
                Map? data = x.data() as Map;
                String title = data['title'];
                String description = data['description'];
                DataModal dataModal =
                    DataModal(title: title, description: description, id: x.id);
                dataList.add(dataModal);
              }
              return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 70,
                    child: InkWell(
                      onTap: () {
                        List updateData = [];
                        updateData.add(dataList[index]);
                        Navigator.pushNamed(
                          context,
                          'update_screen',
                          arguments: updateData,
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 8,
                          top: 8,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              "${dataList[index].title}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                FirebaseService.firebaseService.deleteTodo(
                                  id: dataList[index].id,
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
