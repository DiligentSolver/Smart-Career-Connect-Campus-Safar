import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

class ChatScreenPage extends StatelessWidget {
  const ChatScreenPage({super.key});

  value() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('Users')
        .doc('UserRoles')
        .collection('Student')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return document;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Tawk(
          directChatLink:
              'https://tawk.to/chat/65d6e87b8d261e1b5f638aba/1hn7no933',
          visitor: TawkVisitor(
            name: 'Elvin Desolate',
            email: 'dikshachouhan81217@gmail.com',
          ),
          onLoad: () {
            print('Hello Tawk!');
          },
          onLinkTap: (String url) {
            print(url);
          },
          placeholder: const Center(
            child: Text('Loading...'),
          ),
        ),
      ),
    );
  }
}
