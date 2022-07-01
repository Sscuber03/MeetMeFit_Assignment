import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

File? file;
UploadTask? task;
String fileNameStore = "No File Choosen";

Future<bool> logIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> signUp(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The email is already registered, please login.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> createProfile(String name, String about) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('info')
        .doc('Values');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      documentReference.set({"Name": name});
      documentReference.update({"About": about});
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future picUpload() async {
  try {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png']);
    final path = result!.files.single.path;
    file = File(path!);
    final fileName = basename(file!.path);
    fileNameStore = fileName;
    final destination = 'files/$fileName';
    final ref = FirebaseStorage.instance.ref(destination);
    task = ref.putFile(file!);
    final snap = await task!.whenComplete(() {});
    final urlDownload = await snap.ref.getDownloadURL();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('info')
        .doc('url');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      documentReference.set({"Url": urlDownload});
    });
  } on FirebaseException catch (e) {
    return null;
  }
}

Future<bool> checkExists() async {
  try {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    final snapShot =
        await FirebaseFirestore.instance.collection('users').doc(uid).collection('info').doc('Values').get();
    return snapShot.exists;
  } catch (e) {
    return false;
  }
}
