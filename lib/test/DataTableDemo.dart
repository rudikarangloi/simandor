import 'package:flutter/material.dart';
import 'package:simandoronline/models/barang.dart';
import 'Employee.dart';
import 'Services.dart';
import 'dart:async';

class DataTableDemo extends StatefulWidget {
  //
  DataTableDemo() : super();

  final String title = 'Flutter Data Table';

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

// Now we will write a class that will help in searching.
// This is called a Debouncer class.
// I have made other videos explaining about the debouncer classes
// The link is provided in the description or tap the 'i' button on the right corner of the video.
// The Debouncer class helps to add a delay to the search
// that means when the class will wait for the user to stop for a defined time
// and then start searching
// So if the user is continuosly typing without any delay, it wont search
// This helps to keep the app more performant and if the search is directly hitting the server
// it keeps less hit on the server as well.
// Lets write the Debouncer class

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer
          .cancel(); // when the user is continuosly typing, this cancels the timer
    }
    // then we will start a new timer looking for the user to stop
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class DataTableDemoState extends State<DataTableDemo> {
  List<Barang> _barangs;
  List<Employee> _employees;
  // this list will hold the filtered employees
  List<Barang> _filterBarangs;
  List<Employee> _filterEmployees;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  TextEditingController _firstNameController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _lastNameController;
  Employee _selectedEmployee;
  Barang _selectedBarang;
  bool _isUpdating;
  String _titleProgress;
  // This will wait for 500 milliseconds after the user has stopped typing.
  // This puts less pressure on the device while searching.
  // If the search is done on the server while typing, it keeps the
  // server hit down, thereby improving the performance and conserving
  // battery life...
  final _debouncer = Debouncer(milliseconds: 2000);
  // Lets increase the time to wait and search to 2 seconds.
  // So now its searching after 2 seconds when the user stops typing...
  // That's how we can do filtering in Flutter DataTables.

  @override
  void initState() {
    super.initState();
    _barangs = [];
    _filterBarangs = [];
    _employees = [];
    _filterEmployees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getEmployees();
    _getKibBarangs();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    final snackBar = SnackBar(
      content: const Text('Hi, I am a SnackBar!'),
      backgroundColor: (Colors.black12),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //   ),
    // );
  }

  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        // Table is created successfully.
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  // Now lets add an Employee
  _addEmployee() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Employee...');
    Services.addEmployee(_firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _getEmployees() {
    _showProgress('Loading Employees...');
    Services.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
        // Initialize to the list from Server when reloading...
        _filterEmployees = employees;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${employees.length}");
    });
  }

  _getKibBarangs() {
    _showProgress('Loading Barangs...');
    Services.getKibBarang("kdSubUnit", "kdKib", "noRegister").then((Barangs) {
      setState(() {
        _barangs = Barangs;
        // Initialize to the list from Server when reloading...
        _filterBarangs = Barangs;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${Barangs.length}");
    });
  }

  _updateEmployee(Employee employee) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    Services.updateEmployee(
            employee.id, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteEmployee(Employee employee) {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee(employee.id).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  _showValues(Employee employee) {
    _firstNameController.text = employee.firstName;
    _lastNameController.text = employee.lastName;
  }

// Since the server is running locally you may not
// see the progress in the titlebar, its so fast...
// :)

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('FIRST NAME'),
            ),
            DataColumn(
              label: Text('LAST NAME'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          // the list should show the filtered list now
          rows: _filterEmployees
              .map(
                (employee) => DataRow(cells: [
                  DataCell(
                    Text(employee.id),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.firstName.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.lastName.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteEmployee(employee);
                    },
                  ))
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  SingleChildScrollView _dataBarangBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('REGISTER'),
            ),
            DataColumn(
              label: Text('NAMA BARANG'),
            ),
            DataColumn(
              label: Text('MERK'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _filterBarangs
              .map(
                (barang) => DataRow(cells: [
                  DataCell(
                    Text(barang.noRegister),
                    onTap: () {
                      _selectedBarang = barang;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      barang.nmAset.toUpperCase(),
                    ),
                    onTap: () {
                      _selectedBarang = barang;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      barang.merk.toUpperCase(),
                    ),
                    onTap: () {
                      _selectedBarang = barang;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  // DataCell(IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () {
                  //     _deleteEmployee(employee);
                  //   },
                  // ))
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  // Let's add a searchfield to search in the DataTable.
  searchField() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: 'Filter by First name or Last name',
        ),
        onChanged: (string) {
          // We will start filtering when the user types in the textfield.
          // Run the debouncer and start searching
          _debouncer.run(() {
            // Filter the original List and update the Filter list
            setState(() {
              _filterEmployees = _employees
                  .where((u) => (u.firstName
                          .toLowerCase()
                          .contains(string.toLowerCase()) ||
                      u.lastName.toLowerCase().contains(string.toLowerCase())))
                  .toList();
            });
          });
        },
      ),
    );
  }

  searchBarangField() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: 'Cari berdasar Nomor Number',
        ),
        onChanged: (stringa) {
          // We will start filtering when the user types in the textfield.
          // Run the debouncer and start searching
          _debouncer.run(() {
            // Filter the original List and update the Filter list
            setState(() {
              _filterBarangs = _barangs
                  .where((u) =>
                      (u.nmAset.toLowerCase().contains(stringa.toLowerCase())))
                  .toList();
            });
          });
        },
      ),
    );
  }

  // id is coming as String
  // So let's update the model...

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Padding(
            //   padding: EdgeInsets.all(20.0),
            //   child: TextField(
            //     controller: _firstNameController,
            //     decoration: InputDecoration.collapsed(
            //       hintText: 'First Name',
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(20.0),
            //   child: TextField(
            //     controller: _lastNameController,
            //     decoration: InputDecoration.collapsed(
            //       hintText: 'Last Name',
            //     ),
            //   ),
            // ),

            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            // _isUpdating
            //     ? Row(
            //         children: <Widget>[
            //           ElevatedButton(
            //             child: Text('UPDATE'),
            //             onPressed: () {
            //               _updateEmployee(_selectedEmployee);
            //             },
            //           ),
            //           ElevatedButton(
            //             child: Text('CANCEL'),
            //             onPressed: () {
            //               setState(() {
            //                 _isUpdating = false;
            //               });
            //               _clearValues();
            //             },
            //           ),
            //         ],
            //       )
            //     : Container(),
            searchBarangField(),
            Expanded(
              child: _dataBarangBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
