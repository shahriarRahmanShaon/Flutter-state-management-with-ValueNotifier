import 'package:flutter/material.dart';
import 'package:flutter_advance/new_contact_view.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class Contact {
  final String name;
  final String id;
  Contact({required this.name}) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  int get contacts => value.length;

  void add ({required Contact contact}) {
    value.add(contact);
    notifyListeners();
  }

  void remove ({required Contact contact}) {
    value.remove(contact);
    notifyListeners();
  }

  Contact? contact({required int atIndex}) {
    value.length > atIndex ? value[atIndex] : null;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.blue,
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              final contact = value[index];
              return Dismissible(
                onDismissed: (direction) {
                  ContactBook().remove(contact: contact);
                },
                key: ValueKey(contact.id),
                child: Material(
                  color: Colors.white,
                  elevation: 6.0,
                  child: ListTile(
                    title: Text(contact.name),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        await Navigator.of(context).pushNamed('/new-contact');
      },child: const Icon(Icons.add),),
    );
  }
}



