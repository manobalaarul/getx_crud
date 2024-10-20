// To parse this JSON data, do
//
//     final contact = contactFromJson(jsonString);

import 'dart:convert';

List<Contact> contactFromJson(String str) =>
    List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
  String? id; // Make id optional (nullable)
  String name;
  String age;
  String email;
  String contact;

  Contact({
    this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.contact,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["_id"], // Parse id when fetching
        name: json["name"],
        age: json["age"].toString(),
        email: json["email"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "email": email,
        "contact": contact,
      };
}
