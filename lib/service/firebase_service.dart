import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final firebaseService = FirebaseService._();

  FirebaseService._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // sign-in

  Future<String?> signIn({required email, required password}) async {
    String? msg;

    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => msg = "login successfully !")
        .catchError((e) => msg = "login failed !");
    return msg;
  }

  // insert user detail

  Future<void> insertUserDetail({required username, required email}) async {
    User? user = firebaseAuth.currentUser;
    String? uid = user!.uid;
    await firebaseFirestore
        .doc(uid)
        .set({"username": username, "email": email});
  }

  // get user detail

  Future<Map<String, dynamic>> getUserDetail() async {
    User? user = firebaseAuth.currentUser;
    String? uid = user!.uid;
    final DocumentSnapshot snapshot = await firebaseFirestore.doc(uid).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  // sign-up

  Future<String?> signUp({required email, required password}) async {
    String? msg;

    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => msg = "account created successfully !")
        .catchError((e) => msg = "account creation failed !");
    return msg;
  }

  // check user

  bool checkUser() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  // sign out

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // insert todo

  Future<void> insertTodo({title, description}) async {
    User? user = firebaseAuth.currentUser;
    String? uid = user!.uid;
    await firebaseFirestore
        .collection("todo")
        .doc(uid)
        .collection("user_todo")
        .add({"title": title, "description": description});
  }

  // get todo

  Stream<QuerySnapshot<Map<String, dynamic>>> getTodo() {
    User? user = firebaseAuth.currentUser;
    String? uid = user!.uid;
    return firebaseFirestore
        .collection("todo")
        .doc(uid)
        .collection("user_todo")
        .snapshots();
  }

  // update todo

  Future<void> updateTodo({id, title, description}) async {
    User? user = firebaseAuth.currentUser;
    String? uid = user!.uid;
    await firebaseFirestore
        .collection("todo")
        .doc(uid)
        .collection("user_todo")
        .doc(id)
        .set({"title": title, "description": description});
  }

  // delete todo

  Future<void> deleteTodo({id}) async {
    User? user = firebaseAuth.currentUser;
    String? uid = user!.uid;
    await firebaseFirestore
        .collection("todo")
        .doc(uid)
        .collection("user_todo")
        .doc(id)
        .delete();
  }
}
