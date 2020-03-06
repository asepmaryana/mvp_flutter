import 'package:flutter/material.dart';

class Contact {
  final String fullName;
  final String email;

  const Contact({this.fullName, this.email});

  Contact.fromMap(Map<String, dynamic> map) :
    fullName = "${map['name']['first']} ${map['name']['last']}",
    email = map['email'];
    
}

class ContactListItem extends ListTile {
  ContactListItem(Contact contact) :
    super(
      title : Text(contact.fullName),
      subtitle : Text(contact.email),
      leading : CircleAvatar(
        child: Text(contact.fullName[0]),
      )
    );
}