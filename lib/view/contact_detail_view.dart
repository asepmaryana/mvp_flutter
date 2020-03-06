import 'package:flutter/material.dart';
import 'package:mvp_app/model/contact_model.dart';
import 'package:mvp_app/widget/app_bar.dart';

class ContactPage extends StatelessWidget {
  
  static const String routeName = '/contact';
  final Contact contact;

  ContactPage(this.contact);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Theme(
      data: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: contact.gender == 'male' ? Colors.teal : Colors.pink
      ), 
      child: new Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            FlexibleAppBar(contact.fullName, contact.imageUrl),
            SliverList(delegate: SliverChildListDelegate(
              <ContactCategory>[
                buildPhoneCategory(),
                buildCategory(Icons.location_on, Icons.map, <String>[contact.location.street, contact.location.city]),
                buildCategory(Icons.today, Icons.add_alert, <String>["Birthday ${contact.birthDay}"])
              ]
            ))
          ],
        ),
      )
    );
  }

  ContactCategory buildPhoneCategory() {
    var phoneItems = contact.phones.map((phone) => 
      new ContactCategoryItem(
        icon: Icons.message, 
        lines: <String>[phone.number, phone.type]))
        .toList();
    return new ContactCategory(icon: Icons.call, children: phoneItems);
  }

  ContactCategory buildCategory(IconData categoryIcon, IconData categoryItemIcon, List<String> lines) {
    return new ContactCategory(
      icon: categoryIcon,
      children: <ContactCategoryItem>[
        new ContactCategoryItem(icon: categoryItemIcon, lines: lines)
      ]
    );
  }
}

class ContactCategory extends StatelessWidget {
  final IconData icon;
  final List<ContactCategoryItem> children;

  ContactCategory({Key key, this.icon, this.children}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 16.0),
      decoration: new BoxDecoration(
        border: new Border(bottom: new BorderSide(color: themeData.dividerColor))
      ),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            width: 72.0,
            child: new Icon(icon, color: themeData.primaryColor),
          ),
          new Flexible(child: new Column(children: children))
        ],
      ),
    );
  }

}

class ContactCategoryItem extends StatelessWidget {
  final IconData icon;
  final List<String> lines;

  ContactCategoryItem({Key key, @required this.icon, @required this.lines}) : super(key : key);

  List<Widget> buildRow(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> firstColumn = lines.map((line) => new Text(line)).toList();

    return <Widget>[
      new Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: firstColumn
        )
      ),
      new SizedBox(
        width: 72.0,
        child: new IconButton(icon: new Icon(icon), onPressed: (){}, color: themeData.primaryColor)
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buildRow(context)
      ),
    );
  }
}