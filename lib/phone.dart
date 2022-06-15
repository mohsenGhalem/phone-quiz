import 'dart:io';

import 'package:quiz/quiz.dart';

class Contacts {
  int phoneNumber;
  String name;
  String birthday;

  Contacts(this.phoneNumber, this.birthday, this.name);
}

List<Contacts> _contacts = [];

class Operation {
  int phoneNumber;
  String name;
  String birthday;
  int index;

  Operation(
      {this.phoneNumber = 0,
      this.name = '',
      this.birthday = '',
      this.index = 0});

  void addContact() {
    _contacts.add(Contacts(phoneNumber, birthday, name));

    print("Contact Adedd !");
  }

  void printAllContact() {
    if (_contacts == null)
      print('There is not contacts');
    else {
      for (int i = 0; i < _contacts.length; i++) {
        print("---- Contact ${i + 1} ----\n");
        print(
            "Name : ${_contacts[i].name}\nPhone : 0${_contacts[i].phoneNumber}\nBirthDay : ${_contacts[i].birthday}");
      }
    }
  }

  void deleteContact() {

    _contacts.removeAt(index);


  }

  void searchContact() {
    _contacts.contains()
  }

  void printSpecificContact() {}

  void ModifyContact(){}
}

void menu() {
  print('----- Welcome to Contact Folder -----\n'
      '------------------- Menu ----------------\n'
      '1 - Add Contact\n2- Search Contact\n3- Delete Contact\n4- Print Specific Contact\n5- Print All Contacts\n'
      '---------------Choose One -----------------\n'
      'Your answer : ');
}

void main() {
  int phoneNumber;
  String name;
  String birthday;
  int menuIndex;

  menu();
  menuIndex = int.parse(stdin.readLineSync()!);

  switch (menuIndex) {
    case 1:
      print('phone : ');
      phoneNumber = int.parse(stdin.readLineSync()!);
      print('name : ');
      name = stdin.readLineSync().toString();
      print('birthday : ');
      birthday = stdin.readLineSync().toString();

      Operation(phoneNumber: phoneNumber, name: name, birthday: birthday)
          .addContact();
      break;
  }

  Operation().printAllContact();
}
