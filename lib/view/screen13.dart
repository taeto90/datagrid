import 'package:datagrid/main.dart';
import 'package:datagrid/view/screen14.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource12.dart';




class Mainscreen13 extends StatefulWidget {
  @override
  State<Mainscreen13> createState() => _Mainscreen13State();
}

class _Mainscreen13State extends State<Mainscreen13> {
  late EmployeeDataSource12 _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController gridcontroller = DataGridController();
  bool isReachedCenter=false;

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource12(employees: _employees);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('13. Swiping2'),),
        body: LayoutBuilder(builder: (context, constraints) {
          return SfDataGrid(
            allowSwiping: true,
            swipeMaxOffset: constraints.maxWidth,
            source: _employeeDataSource,

            startSwipeActionsBuilder:
                (BuildContext context, DataGridRow row, int rowIndex) {
              return GestureDetector(
                  onTap: () {
                    _employeeDataSource.dataGridRows.removeAt(rowIndex);
                    _employeeDataSource.updateDataGridSource();
                  },
                  child: Container(
                      color: Colors.green,
                      padding: EdgeInsets.only(left: 30.0),
                      alignment: Alignment.centerLeft,
                      child: Text('Delete', style: TextStyle(color: Colors.white))));
            },
            onSwipeUpdate: (details) {
              isReachedCenter =
              (details.swipeOffset >= constraints.maxWidth / 2) ? true : false;
              return true;       //미는게 화면의 반이상이면 isReachedCenter는가 true가되어서
                                 // onSwipeEnd이 실행됨
            },                  //onSwipeUpdate이 없을경우 isReachedCenter는 초기값이 false여서
                                //  onSwipeEnd가 실행되지않음
            onSwipeEnd: (details) async {
              if (isReachedCenter && _employeeDataSource.dataGridRows.isNotEmpty) {
                _employeeDataSource.dataGridRows.removeAt(details.rowIndex);
                _employeeDataSource.updateDataGridSource();
                isReachedCenter = false;
              }
            },
            columns: <GridColumn>[
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
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Salary',
                        overflow: TextOverflow.ellipsis,
                      ))),
            ],
          );
        }),



        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen14());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}

