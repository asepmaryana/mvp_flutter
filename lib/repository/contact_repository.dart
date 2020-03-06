import 'dart:convert';

import 'package:mvp_app/exception/fetch_data_exception.dart';
import 'package:mvp_app/model/contact_model.dart';
import 'package:http/http.dart' as http;

abstract class ContactRepository {
  Future<List<Contact>> fetch();
}

class RandomUserRepository implements ContactRepository {

  static const _kRandomUserUrl = 'http://api.randomuser.me/?results=15';
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<Contact>> fetch() async {
    final response = await http.get(_kRandomUserUrl);
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException("Error while getting contacts [StatusCode: $statusCode, Error: ${response.reasonPhrase}]");
    }

    final contactsContainer = _decoder.convert(jsonBody);
    final List contactItems = contactsContainer['results'];

    return contactItems.map((contactRaw) => Contact.fromMap(contactRaw))
      .toList();
  }

  static RandomUserRepository _instance;
  RandomUserRepository._internal();
  static RandomUserRepository getInstance() {
    if(_instance == null) _instance = RandomUserRepository._internal();
    return _instance;
  }
}

const kContacts = <Contact>[
    Contact(
      fullName: 'Romain Hoogmoed',
      email:'romain.hoogmoed@example.com'
    ),
    Contact(
      fullName: 'Emilie Olsen',
      email:'emilie.olsen@example.com'
    ),
    Contact(
      fullName: 'Téo Lefevre',
      email:'téo.lefevre@example.com'
    ),
    Contact(
      fullName: 'Nicole Cruz',
      email:'nicole.cruz@example.com'
    ),
    Contact(
      fullName: 'Ramna Peixoto',
      email:'ramna.peixoto@example.com'
    ),
    Contact(
      fullName: 'Jose Ortiz',
      email:'jose.ortiz@example.com'
    ),
    Contact(
      fullName: 'Alma Christensen',
      email:'alma.christensen@example.com'
    ),
    Contact(
      fullName: 'Sergio Hill',
      email:'sergio.hill@example.com'
    ),
    Contact(
      fullName: 'Malo Gonzalez',
      email:'malo.gonzalez@example.com'
    ),
    Contact(
      fullName: 'Miguel Owens',
      email:'miguel.owens@example.com'
    ),
    Contact(
      fullName: 'Lilou Dumont',
      email:'lilou.dumont@example.com'
    ),
    Contact(
      fullName: 'Ashley Stewart',
      email:'ashley.stewart@example.com'
    ),
    Contact(
      fullName: 'Roman Zhang',
      email:'roman.zhang@example.com'
    ),
    Contact(
      fullName: 'Ryan Roberts',
      email:'ryan.roberts@example.com'
    ),
    Contact(
      fullName: 'Sadie Thomas',
      email:'sadie.thomas@example.com'
    ),
    Contact(
      fullName: 'Belen Serrano',
      email:'belen.serrano@example.com '
    )
  ];

class MockContactRepository implements ContactRepository {
  @override
  Future<List<Contact>> fetch() {
    return Future.value(kContacts);
  }
}