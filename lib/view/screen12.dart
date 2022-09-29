import 'package:datagrid/main.dart';
import 'package:datagrid/view/screen13.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource12.dart';




class Mainscreen12 extends StatefulWidget {
  @override
  State<Mainscreen12> createState() => _Mainscreen12State();
}

class _Mainscreen12State extends State<Mainscreen12> {
  late EmployeeDataSource12 _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController gridcontroller = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource12(employees: _employees);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('13. Swiping'),),
      body: SfDataGrid(
        allowSwiping: true,
        //swipeMaxOffset: 100.0,   //얼마나 옆으로 밀어야 실행할지 결정함
        source: _employeeDataSource,

        onSwipeStart: (details) {
          if (details.swipeDirection == DataGridRowSwipeDirection.startToEnd) {
            details.setSwipeMaxOffset(200);    //왼쪽에서 오른쪽은 200
          } else if (details.swipeDirection == DataGridRowSwipeDirection.endToStart) {
            details.setSwipeMaxOffset(100);   //오른쪽에서 왼쪽으로는 100만큰 밀면 실행됨
          }
          return true;
        },

        startSwipeActionsBuilder:             //왼쪽에서 오른쪽으로
            (BuildContext context, DataGridRow row, int rowIndex) {
          return GestureDetector(
              onTap: () {
                _employeeDataSource.dataGridRows.insert(
                    rowIndex,
                    DataGridRow(cells: [
                      DataGridCell(value: 1011, columnName: 'id'),
                      DataGridCell(value: 'Tom Bass', columnName: 'name'),
                      DataGridCell(value: 'Developer', columnName: 'designation'),
                      DataGridCell(value: 20000, columnName: 'salary')
                    ]));
                _employeeDataSource.updateDataGridSource();
              },
              child: Container(
                  color: Colors.greenAccent,
                  child: Center(
                    child: Icon(Icons.add),
                  )));
        },

        endSwipeActionsBuilder:            //오른쪽에서 왼쪽으로
            (BuildContext context, DataGridRow row, int rowIndex) {
          return GestureDetector(
              onTap: () {
                _employeeDataSource.dataGridRows.removeAt(rowIndex);
                _employeeDataSource.updateDataGridSource();
              },
              child: Container(
                  color: Colors.redAccent,
                  child: Center(
                    child: Icon(Icons.delete),
                  )));
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
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen13());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}

