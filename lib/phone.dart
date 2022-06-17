import 'dart:io';
import 'package:dart_console/dart_console.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

class Contacts {
  int phoneNumber;
  String name;
  String birthday;

  Contacts(this.phoneNumber, this.birthday, this.name);
}

List<Contacts> _contacts = [
  Contacts(0533223223, "2003/06/05", 'Mohsen'),
  Contacts(0533223223, "2003/06/05", 'Amir'),
];

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
    sleep(Duration(milliseconds: 1500));
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
      print("There's no contacts to delete !");
    } else {
      if (position >= 0) {
        _contacts.removeAt(position);
        print("Removing Contact....\n");
        sleep(Duration(milliseconds: 1500));
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
    if (position < 0) {
      print("Contact Not Found !");
    } else {
      print(
          "Name : ${_contacts[position].name}\nPhone : 0${_contacts[position].phoneNumber}\nBirthDay : ${_contacts[position].birthday}");
    }
  }

  void modifyContact(int n, int position) {
    if (position >= 0) {
      if (n == 1) {
        _contacts[position].name = name;
      }
      if (n == 2) {
        _contacts[position].phoneNumber = phoneNumber;
      }
      if (n == 3) {
        _contacts[position].birthday = birthday;
      }
    } else {
      return;
    }
  }

  void saveContacts() {
    //This Method Only Work on Console
    if (_contacts.isEmpty) {
      print("Error ! : The list of contacts is empty\n");
    } else {
      //Excel File
      var excelO = Excel.createExcel();
      //Saving the file
      String outputFile = "/Users/mac/Downloads/contacts.xlsx";


      var fileBytes = excelO.save(fileName: "Contacts");

      File(join(outputFile))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      print('Saving File.....\n');
      //Read Excel File
      var bytes = File(outputFile).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      //Excel Sheet
      Sheet sheet = excel[excel.getDefaultSheet()!];

      CellStyle cellStyle = CellStyle(
        bold: true,
        fontSize: 12,
        fontColorHex: "1935EB",
      );
      //Name Column
      var name = sheet.cell(CellIndex.indexByString("A1"));
      name.value = "Name";
      name.cellStyle = cellStyle;
      //Phone Column
      var phone = sheet.cell(CellIndex.indexByString("B1"));
      phone.value = "Phone";
      phone.cellStyle = cellStyle;
      //BirthDay Column
      var birthday = sheet.cell(CellIndex.indexByString("C1"));
      birthday.value = "BirthDay";
      birthday.cellStyle = cellStyle;

      //Filling The Excel Sheet
      for (int i = 2, j = 0; j < _contacts.length; j++, i++) {
        sheet.cell(CellIndex.indexByString("A$i")).value = _contacts[j].name;
        //Phone Column
        sheet.cell(CellIndex.indexByString("B$i")).value =
            _contacts[j].phoneNumber;
        //BirthDay Column
        sheet.cell(CellIndex.indexByString("C$i")).value =
            _contacts[j].birthday;
      }

      //Override The File
      String outputFile1 ="/Users/mac/Downloads/contacts.xlsx";


      var fileBytes1 = excel.save(fileName: "Contacts");

      File(join(outputFile1))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes1!);

      sleep(Duration(milliseconds: 1500));
      print("The File Saved.......Successfully\n"
          "File saved in $outputFile1\n");
    }
  }
}

void menu() {
  print('----- Welcome to Contact Folder -----\n'
      '------------------- Menu ----------------\n'
      '1 - Add Contact\n2- Search Contact\n3- Delete Contact\n4- Print Specific Contact\n5- Print All Contacts\n6- Modify Contact\n7- Save All the Contacts\n0- Exit Program\n'
      '---------------Choose One -----------------\n'
      'Your answer : ');
}

void searchMenu() {
  print('----- Search Contact -----\n'
      '1 - Search by Name\n2- Search by Phone\n'
      '---------------Choose One ---------------\n'
      'Your answer : ');
}

void deleteMenu() {
  print('----- Search Contact -----\n'
      '1 - Search by Name\n2- Search by Phone\n'
      '---------------Choose One ---------------\n'
      'Your answer : ');
}

void main() {
  final console = Console();
  int phoneNumber;
  String name;
  String birthday;
  int menuIndex;
  do {
    print(Process.runSync("clear", [], runInShell: true).stdout);
    menu();
    menuIndex = int.parse(stdin.readLineSync()!);

    switch (menuIndex) {
      //Add contact
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
      //Search Contact
      case 2:
        int place;

        searchMenu();
        place = int.parse(stdin.readLineSync()!);
        switch (place) {
          // by Name
          case 1:
            print("Enter name :");
            name = stdin.readLineSync().toString().toLowerCase();
            if (Operation(name: name).searchContact() == -1) {
              print("Contact Not Found !\n");
            } else {
              Operation(name: name).printSpecificContact();
            }
            break;
          //by Phone
          case 2:
            print("Enter phone :");
            phoneNumber = int.parse(stdin.readLineSync()!);
            if (Operation(phoneNumber: phoneNumber).searchContact() == -1) {
              print("Contact Not Found !\n");
            } else {
              Operation(phoneNumber: phoneNumber).printSpecificContact();
            }
            break;
        }

        break;
      //Delete Contact
      case 3:
        deleteMenu();
        int place = int.parse(stdin.readLineSync()!);
        switch (place) {
          case 1:
            print("Enter name :");
            name = stdin.readLineSync().toString().toLowerCase();
            if (Operation(name: name).searchContact() == -1) {
              print("Contact Not Found !\n");
            } else {
              Operation(name: name).deleteContact();
            }
            break;

          case 2:
            phoneNumber = int.parse(stdin.readLineSync()!);
            if (Operation(phoneNumber: phoneNumber).searchContact() == -1) {
              print("Contact Not Found !\n");
            } else {
              Operation(phoneNumber: phoneNumber).deleteContact();
            }
            break;
          default:
            print("Error !");
        }
        break;
      //Print Specific Contact
      case 4:
        searchMenu();
        int place = int.parse(stdin.readLineSync()!);
        switch (place) {
          case 1:
            print("Enter name :");
            name = stdin.readLineSync().toString().toLowerCase();
            if (Operation(name: name).searchContact() == -1) {
              print("Contact Not Found !\n");
            } else {
              Operation(name: name).printSpecificContact();
            }
            break;

          case 2:
            phoneNumber = int.parse(stdin.readLineSync()!);
            if (Operation(phoneNumber: phoneNumber).searchContact() == -1) {
              print("Contact Not Found !\n");
            } else {
              Operation(phoneNumber: phoneNumber).printSpecificContact();
            }
            break;
          default:
            print("Error !");
        }
        break;
      //Print All contacts
      case 5:
        _contacts.isNotEmpty
            ? Operation().printAllContact()
            : print("There's not Contacts to print");
        break;

      case 6:
        searchMenu();
        int place = int.parse(stdin.readLineSync()!);
        switch (place) {
          case 1:
            print("Enter name :");
            name = stdin.readLineSync().toString().toLowerCase();
            if (Operation(name: name).searchContact() == -1) {
              print("Contact Not Found !\n");
            } else {
              int p = Operation(name: name).searchContact();
              print("1-Modify Name\n2-Modify PhoneNumber\n3-Modify BirthDay\n"
                  "----------------------\nYour Answer :");
              int f = int.parse(stdin.readLineSync()!);
              switch (f) {
                case 1:
                  modifyName(p);
                  break;
                case 2:
                  modifyPhone(p);
                  break;
                case 3:
                  modifyBirth(p);
                  break;
                default:
                  print("Error!\n");
              }
            }
            break;

          case 2:
            phoneNumber = int.parse(stdin.readLineSync()!);
            if (Operation(phoneNumber: phoneNumber).searchContact() == -1) {
              print("Contact Not Found !\n");
            } else {
              int p = Operation(phoneNumber: phoneNumber).searchContact();
              print("1-Modify Name\n2-Modify PhoneNumber\n3-Modify BirthDay\n"
                  "----------------------\nYour Answer :");
              int f = int.parse(stdin.readLineSync()!);
              switch (f) {
                case 1:
                  modifyName(p);
                  break;
                case 2:
                  modifyPhone(p);
                  break;
                case 3:
                  modifyBirth(p);
                  break;
                default:
                  print("Error!\n");
              }
            }
            break;
          default:
            print("Error !");
        }
        break;
      case 7:
        Operation().saveContacts();
        break;
      default:
        print("Error! : this menu doesn't exits");
    }
    console.clearScreen();
  } while (menuIndex > 0);

  print("\nGood Bye\n");
}

void modifyName(int p) {
  print('Enter the New Name :');
  String nName = stdin.readLineSync().toString();
  Operation(name: nName).modifyContact(1, p);
  print("Modifying Contact...");
  sleep(Duration(milliseconds: 1500));
  print("Contact Modified !\n");
}

void modifyPhone(int p) {
  print('Enter the New PhoneNumber :');
  int nPhone = int.parse(stdin.readLineSync()!);
  Operation(phoneNumber: nPhone).modifyContact(2, p);
  print("Modifying Contact...");
  sleep(Duration(milliseconds: 1500));
  print("Contact Modified !\n");
}

void modifyBirth(int p) {
  print('Enter the New BirthDay :');
  String nBirth = stdin.readLineSync().toString();
  Operation(birthday: nBirth).modifyContact(3, p);
  print("Modifying Contact...");
  sleep(Duration(milliseconds: 1500));
  print("Contact Modified !\n");
}
