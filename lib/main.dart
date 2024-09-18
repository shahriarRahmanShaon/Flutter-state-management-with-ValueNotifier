import 'package:flutter/material.dart';
import 'package:flutter_advance/new_contact_view.dart';

void main() {
  runApp(const MyApp());
}

class Contact {
  final String name;
  Contact({required this.name});
}

class ContactBook {
  ContactBook._sharedInstance();
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  final List<Contact> _contacts = [];

  int get contacts => _contacts.length;

  void add ({required Contact contact}) {
    _contacts.add(contact);
  }

  void remove ({required Contact contact}) {
    _contacts.remove(contact);
  }

  Contact? contact({required int atIndex}) {
    _contacts.length > atIndex ? _contacts[atIndex] : null;
  }

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
          '/new-contact': (context) => const NewContactView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final contactBook = ContactBook();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: contactBook.contacts,
        itemBuilder: (context, index) {
          final contact = contactBook.contact(atIndex: index)!;
          return ListTile(
            title: Text(contact.name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        await Navigator.of(context).pushNamed('/new-contact');
      },child: const Icon(Icons.add),),
    );
  }
}



