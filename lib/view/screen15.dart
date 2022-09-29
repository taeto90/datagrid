import 'package:datagrid/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource_15.dart';




class Mainscreen15 extends StatefulWidget {
  @override
  State<Mainscreen15> createState() => _Mainscreen15State();
}

class _Mainscreen15State extends State<Mainscreen15> {
  late EmployeeDataSource15 _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController gridcontroller = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource15(employees: _employees);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('15. Conditional Styling'),),
        body: SfDataGrid(
            source: _employeeDataSource,
            columnWidthMode: ColumnWidthMode.lastColumnFill,
            selectionMode: SelectionMode.singleDeselect,
            columns: [
              GridColumn(
                  columnName: 'id',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'ID',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'designation',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Designation',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'salary',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.center,
                      child: Text(
                        'Salary',
                        overflow: TextOverflow.ellipsis,
                      ))),
            ]),



        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(MyHomePage());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}

