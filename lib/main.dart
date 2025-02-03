import 'package:flutter/material.dart';

void main() {
  runApp(ContactApp());
}

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  List<Map<String, String>> contacts = [];

  void addContact() {
    String name = nameController.text.trim();
    String number = numberController.text.trim();
    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        contacts.add({'name': name, 'number': number});
      });
      nameController.clear();
      numberController.clear();
    }
  }

  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Confirmation",
          style: TextStyle(fontSize: 30),
        ),
        content: Text(
          "Are you sure for delete?",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.cancel,
              size: 30,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                contacts.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Icon(
              Icons.delete,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact List",
          style: TextStyle(
              fontSize: 25, color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Name"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: numberController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.account_circle, color: Colors.red),
                      title: Text(contacts[index]['name']!),
                      subtitle: Text(contacts[index]['number']!),
                      trailing: Icon(Icons.call, color: Colors.blue),
                      onLongPress: () => confirmDelete(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
