import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Contact {
  final String fullName;
  final String gender;
  final String email;
  final String imageUrl;
  final String birthDay;
  final Location location;
  final List<Phone> phones;

  static final DateFormat _formatter = DateFormat('MMMM d, yyyy');
  
  const  Contact({this.fullName, this.gender, this.email, this.imageUrl, this.birthDay, this.location, this.phones});

  Contact.fromMap(Map<String, dynamic>  map) :
                    fullName = "${map['name']['first']} ${map['name']['last']}",
                    gender = map['gender'],
                    email = map['email'],
                    imageUrl = map['picture']['large'],
                    birthDay = _formatter.format(DateTime.parse(map['dob']['date'])),
                    location = Location.fromMap(map['location']),
                    phones = <Phone>[
                      new Phone(type: 'Home',   number: map['phone']),
                      new Phone(type: 'Mobile', number: map['cell'])
                    ];
}

class Phone {
  final String type;
  final String number;

  const Phone({this.type, this.number});

}

class Location {
  final String street;
  final String city;

  const Location({this.street, this.city});

  Location.fromMap(Map<String, dynamic> map) : 
    street = map['street']['name'],
    city = map['city'];
}

class ContactListItem extends ListTile {
  ContactListItem({@required Contact contact, @required GestureTapCallback onTap}) :
    super(
      title : Text(contact.fullName),
      subtitle : Text(contact.email),
      leading : CircleAvatar(
        child: Text(contact.fullName[0]),
      ),
      onTap : onTap
    );
}