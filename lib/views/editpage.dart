import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/contact_controller.dart';
import 'package:todo/models/contact.dart';

class EditContact extends StatefulWidget {
  final Contact contact;
  const EditContact({super.key, required this.contact});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final ContactController contactController = Get.find<ContactController>();

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController emailController;
  late TextEditingController contactControllerField;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.contact.name);
    ageController = TextEditingController(text: widget.contact.age.toString());
    emailController = TextEditingController(text: widget.contact.email);
    contactControllerField =
        TextEditingController(text: widget.contact.contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Contact')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: contactControllerField,
              decoration: InputDecoration(labelText: 'Contact'),
            ),
            ElevatedButton(
                onPressed: () {
                  contactController.updateContact(
                      widget.contact.id!,
                      nameController.text,
                      ageController.text,
                      emailController.text,
                      contactControllerField.text);
                  Get.back();
                },
                child: Text('Save Contact'))
          ],
        ),
      ),
    );
  }
}
