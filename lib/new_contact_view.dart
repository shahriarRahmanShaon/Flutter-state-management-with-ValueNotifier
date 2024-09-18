import 'package:flutter/material.dart';
import 'package:flutter_advance/main.dart';

class NewContactView extends StatefulWidget {
  const NewContactView({super.key});

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _textfieldController;

  @override
  void initState() {
    _textfieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textfieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _textfieldController,
              decoration: const InputDecoration(
                hintText: 'Enter a new contact name here...',
              ),
            ),
            TextButton(onPressed: (){
              final contact = Contact(name: _textfieldController.text) ;
              ContactBook().add(contact: contact);
              Navigator.of(context).pop();
            }, child: const Text('Save'),),
          ],
        ),
      ),
    );
  }
}
