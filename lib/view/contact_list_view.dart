import 'package:flutter/material.dart';
import 'package:mvp_app/model/contact_model.dart';
import 'package:mvp_app/presenter/contact_list_presenter.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Contacts'),
      ),
      body: ContactList(),
    );
  }
}

class ContactList extends StatefulWidget {
  
  ContactList({Key key}) : super(key:key);

  @override
  ContactListState createState() => new ContactListState();
}

class ContactListState extends State<ContactList> implements ContactListViewContract {

  ContactListPresenter _presenter;
  List<Contact> _contacts;
  bool _isLoading;

  ContactListState() {
    _presenter = ContactListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    if(_isLoading) {
      widget = new Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    else {
      widget = ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: buildContactList(),
      );
    }
    return widget;
  }

  @override
  void onLoadContactError() {
    
  }

  @override
  void onLoadContactsComplete(List<Contact> items) {
    setState(() {
      _contacts = items;
      _isLoading = false;
    });
  }

  List<ContactListItem> buildContactList() {
    return _contacts.map((contact) => ContactListItem(contact)).toList();
  }
}