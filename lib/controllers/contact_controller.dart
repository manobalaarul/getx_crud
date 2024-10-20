import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo/models/contact.dart';

class ContactController extends GetxController {
  var contacts = <Contact>[].obs;
  var isLoading = false.obs;
  TextEditingController nametextcontroller = TextEditingController();
  TextEditingController agetextcontroller = TextEditingController();
  TextEditingController emailtextcontroller = TextEditingController();
  TextEditingController contacttextcontroller = TextEditingController();

  final String apiUrl =
      'https://node.thilagasrecipe.in/api/v1'; // Replace with your API URL

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchContact();
  }

  Future<void> fetchContact() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        contacts.assignAll((jsonResponse as List)
            .map((data) => Contact.fromJson(data))
            .toList());
      } else {
        Get.snackbar("Error", "Failed to fetch contacts from server");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addContact(
      String name, String age, String email, String contact) async {
    if (name != "" && age != "" && email != "" && contact != "") {
      final response = await http.post(
        Uri.parse("${apiUrl}/add"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'name': name,
          'age': age,
          'email': email,
          'contact': contact,
        }),
      );

      if (response.statusCode == 200) {
        var newContact = Contact.fromJson(json.decode(response.body));
        contacts.add(newContact);
      } else {
        Get.snackbar("Error", "Failed to add contact");
      }
    }
  }

  Future<void> updateContact(
      String id, String name, String age, String email, String contact) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'name': name,
        'age': age,
        'email': email,
        'contact': contact,
      }),
    );

    if (response.statusCode == 200) {
      var updatedContact = Contact.fromJson(json.decode(response.body));
      int index = contacts.indexWhere((c) => c.id == id);
      if (index != -1) {
        contacts[index] = updatedContact;
      }
    } else {
      Get.snackbar("Error", "Failed to update contact");
    }
  }

  Future<void> deleteContact(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      contacts.removeWhere((c) => c.id == id);
    } else {
      Get.snackbar("Error", "Failed to delete contact");
    }
  }
}
