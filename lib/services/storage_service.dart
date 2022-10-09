import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/cupertino.dart';

class Storage {
  static final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadImage(
    String imgpath,
    String imgname,
  ) async {
    File file = File(imgpath);

    try {
      await storage.ref('profile/$imgname').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> uploadImagePenyedia(
    String imgpath,
    String imgname,
  ) async {
    File file = File(imgpath);

    try {
      await storage.ref('profilepenyedia/$imgname').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> downloadURL(String imageName) async {
    var downloadURL;
    try {
      downloadURL = await storage.ref('profile/$imageName').getDownloadURL();
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
    }
    
    return downloadURL;
  }
}
