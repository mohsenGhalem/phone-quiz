import 'dart:io';

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
    print("Adding Contact....\n");
    sleep(Duration(seconds: 2));
    print("Contact Added !\n");
  }

  void printAllContact() {
    if (_contacts.isEmpty) {
      print('There is not contacts');
    } else {
      for (int i = 0; i < _contacts.length; i++) {
        print("---- Contact ${i + 1} ----\n");
        print(
            "Name : ${_contacts[i].name}\nPhone : 0${_contacts[i].phoneNumber}\nBirthDay : ${_contacts[i].birthday}");
      }
    }
  }

  void deleteContact() {
    int position = searchContact();
    if (_contacts.isEmpty) {
      print("There's no contact to delete !");
    }
    else {
      if (position >= 0) {
        _contacts.removeAt(position);
        print("Removing Contact....\n");
        sleep(Duration(seconds: 2));
        print("Contact Removed !\n");
      } else {
        print("Error! : The Contact Doesn't Exist\n");
      }
    }
  }

  int searchContact() {
    int i;
    for (i = 0; i < _contacts.length; i++) {
      if (_contacts[i].phoneNumber == phoneNumber ||
          _contacts[i].name.toLowerCase() == name) {
        return i;
      }
    }

    return -1;
  }

  void printSpecificContact() {
    int position = searchContact();
    if(position<0){print("Contact Not Found !");}
    else{
      print(
          "Name : ${_contacts[position].name}\nPhone : 0${_contacts[position].phoneNumber}\nBirthDay : ${_contacts[position].birthday}");
    }
  }

  void modifyContact() {}
}

void menu() {
  print('----- Welcome to Contact Folder -----\n'
      '------------------- Menu ----------------\n'
      '1 - Add Contact\n2- Search Contact\n3- Delete Contact\n4- Print Specific Contact\n5- Print All Contacts\n0- Exit Program\n'
      '---------------Choose One -----------------\n'
      'Your answer : ');
}

void searchMenu(){
  print('----- Search Contact -----\n'
      '1 - Search by Name\n 2- Search by Phone\n'
      '---------------Choose One ---------------\n'
      'Your answer : ');
}

void main() {
  int phoneNumber;
  String name;
  String birthday;
  int menuIndex;
do {
  menu();
  menuIndex = int.parse(stdin.readLineSync()!);

  switch (menuIndex) {
    case 1:
      print('phone : ');
      phoneNumber = int.parse(stdin.readLineSync()!);
      print('name : ');
      name = stdin.readLineSync().toString();
      print('birthday (YYYY/MM/DD) : ');
      birthday = stdin.readLineSync().toString();

      Operation(phoneNumber: phoneNumber, name: name, birthday: birthday)
          .addContact();

      break;
    case 2 :
      int place;
      p:
      searchMenu();
      place = int.parse(stdin.readLineSync()!);
      switch (place) {
        case 1 :
          print("Enter name :");
          name = stdin.readLineSync().toString().toLowerCase();
          if (Operation(name: name).searchContact() == -1) {
            print("Contact Not Found !\n");
          }
          else {
            Operation(name: name).printSpecificContact();
          }
          break;
      }

      break;
  }
}while(menuIndex>0);
  Operation().printAllContact();

}
