import 'package:contactlistapp/contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: firstnameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'First Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lastnameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Last Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numberController,
              maxLength: 11,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Contact number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      String firstname = firstnameController.text.trim();
                      String lastname = lastnameController.text.trim();
                      String number = numberController.text.trim();

                      if (firstname.isNotEmpty &&
                          lastname.isNotEmpty &&
                          number.isNotEmpty) {
                        setState(() {
                          firstnameController.text = '';
                          lastnameController.text = '';
                          numberController.text = '';
                          contacts.add(Contact(
                              firstname: firstname,
                              lastname: lastname,
                              number: number));
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black26),
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      String firstname = firstnameController.text.trim();
                      String lastname = lastnameController.text.trim();
                      String number = numberController.text.trim();

                      if (firstname.isNotEmpty && lastname.isNotEmpty &&
                          number.isNotEmpty) {
                        setState(() {
                          firstnameController.text = '';
                          lastnameController.text = '';
                          numberController.text = '';
                          contacts[selectedIndex].firstname = firstname;
                          contacts[selectedIndex].lastname = lastname;
                          contacts[selectedIndex].number = number;
                          selectedIndex = -1;
                        });
                      }

                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black26),
                    child: const Text('Update')),
              ],
            ),
            const SizedBox(height: 10),
            contacts.isEmpty
                ? const Text('No contacts available..',
                    style: TextStyle(fontSize: 22))
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].firstname[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contacts[index].firstname),
            Text(contacts[index].lastname),
            Text(contacts[index].number),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children:  [
              const Center(),
              InkWell(
                onTap: ((){
                  firstnameController.text = contacts[index].firstname;
                  lastnameController.text = contacts[index].lastname;
                  numberController.text = contacts[index].number;
                  setState(() {
                    selectedIndex = index;
                  });
                }),
                  child: const Icon(Icons.edit)),
              const SizedBox(width: 10),
              InkWell(
                  onTap:((){
                    setState(() {
                      contacts.removeAt(index);
                    });
                  }),
                  child: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
