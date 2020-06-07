import 'package:custom_contacts_prototype/Data/dummy_data.dart';
import 'package:custom_contacts_prototype/Data/report.dart';
import 'package:custom_contacts_prototype/Screens/digital_phone_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TransportScreen extends StatelessWidget {
  final List<Report> _fakeReports = DummyData.getDummyReports();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {},
            child: Icon(AntDesign.message1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) {
                      return DigitalPhoneBookScreen();
                    },
                  ),
                );
              },
              child: Icon(AntDesign.phone),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _fakeReports.length,
        itemBuilder: (_, index) {
          return ExpansionTile(
            title: Text(_fakeReports[index].title),
            leading: Icon(_fakeReports[index].icon),
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(_fakeReports[index].description),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
