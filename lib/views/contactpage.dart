import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/views/editpage.dart';
import '../controllers/contact_controller.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ContactController contactController = Get.put(ContactController());

  Future<void> refreshData() async {
    await contactController.fetchContact();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          contactController.addContact(
              contactController.nametextcontroller.text,
              contactController.agetextcontroller.text,
              contactController.emailtextcontroller.text,
              contactController.contacttextcontroller.text);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          refreshData();
        },
        child: Column(
          children: [
            Container(
              child: Expanded(child: Obx(() {
                if (contactController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (contactController.contacts.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: contactController.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contactController.contacts[index];
                      return Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  onTap: () {
                                    Get.to(EditContact(
                                      contact: contact,
                                    ));
                                  },
                                  title: Text("${contact.name} ${contact.age}"),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(contact.email),
                                      Text(contact.contact),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      contactController
                                          .deleteContact(contact.id!);
                                    },
                                  ),
                                ),
                              )
                            ],
                          ));
                    });
              })),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                TextField(
                  controller: contactController.nametextcontroller,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: contactController.agetextcontroller,
                  decoration: InputDecoration(labelText: 'Age'),
                ),
                TextField(
                  controller: contactController.emailtextcontroller,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: contactController.contacttextcontroller,
                  decoration: InputDecoration(labelText: 'Contact'),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
