import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) return;
    FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser!;
    _messageController.clear();

    final userDate =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    await FirebaseFirestore.instance.collection("chat").add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userid': user.uid,
      'username': userDate.data()!['username'],
      'userimage': userDate.data()!['image_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(labelText: "send a message..."),
          )),
          IconButton(
              onPressed: _submitMessage,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              )),
        ],
      ),
    );
  }
}
