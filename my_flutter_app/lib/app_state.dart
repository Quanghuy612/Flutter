// lib/app_state.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  // Whether user is logged in
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  /// Initialize Firebase and listen for auth state changes
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Configure FirebaseUI Auth providers
    FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

    // Listen to authentication changes
    FirebaseAuth.instance.userChanges().listen((user) {
      _loggedIn = user != null;
      notifyListeners();
    });
  }

  /// Add a message to the 'guestbook' collection in Firestore
  Future<DocumentReference<Map<String, dynamic>>> addMessageToGuestBook(
    String message,
  ) async {
    if (!_loggedIn) {
      throw Exception('Must be logged in to add a message');
    }

    return FirebaseFirestore.instance.collection('guestbook').add({
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }
}
