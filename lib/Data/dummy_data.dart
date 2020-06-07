import 'dart:math';
import 'package:custom_contacts_prototype/Data/contact.dart';
import 'package:custom_contacts_prototype/Data/report.dart';
import 'package:flutter/material.dart';

class DummyData {
  static List<Contact> getDummyContents() {
    List<String> firstNames = [
      'Chris',
      'Joe',
      'Wedge',
      'Padme',
      'Julia',
      'Peter',
      'Angela',
      'Bruce',
      'Emily',
      'Ford',
      'Valeria',
      'Micheal',
      'Betsy',
      'Cathy',
      'Kalvin',
      'Gonzalo',
      'Berlin',
      'Robert',
      'David',
      'Hadi',
      'Daniel',
      'Brian'
    ];
    List<String> lastNames = [
      'Lam',
      'Allen',
      'Antilles',
      'Beckman',
      'Bara',
      'Smith',
      'Williams',
      'Garcia',
      'Miller',
      'Davis',
      'Betsy',
      'Brown',
      'Jones',
      'Johnson',
      'David',
      'Alyssa'
    ];

    List<Contact> contacts = [];
    List<String> jobType = [
      'Duty Officer',
      'Sales Man',
      'Marines',
      'Mathmatician',
      'Developer',
      'Electrician'
    ];

    for (int i = 0; i < 50; i++) {
      Contact contact = Contact(
        firstName: firstNames[Random().nextInt(firstNames.length)],
        lastName: lastNames[Random().nextInt(lastNames.length)],
        department: 'Security',
        email: 'example@live.com',
        jobTitle: jobType[Random().nextInt(jobType.length)],
        phoneNumber: 8520123456,
      );

      contacts.add(contact);
    }

    //Sort alphabatically
    contacts.sort((a, b) {
      return a.firstName.compareTo(b.firstName);
    });
    return contacts;
  }

  static List<Report> getDummyReports() {
    return [
      Report(
        description: 'Some random description',
        title: 'Sistuation Report',
        icon: Icons.receipt,
      ),
      Report(
        description: 'Some random description',
        title: 'Chief Report',
        icon: Icons.chrome_reader_mode,
      )
    ];
  }
}
