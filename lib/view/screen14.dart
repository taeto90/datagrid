import 'package:datagrid/main.dart';
import 'package:datagrid/view/screen15.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource_14.dart';




class Mainscreen14 extends StatefulWidget {
  @override
  State<Mainscreen14> createState() => _Mainscreen14State();
}

class _Mainscreen14State extends State<Mainscreen14> {
  late EmployeeDataSource14 _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController gridcontroller = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData2();
    _employeeDataSource = EmployeeDataSource14(employees: _employees);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('14. Styling'),),
        body: SfDataGridTheme(
          data: SfDataGridThemeData(
              headerColor: Color(0xff009889),
              gridLineColor: Colors.amber, gridLineStrokeWidth: 3.0,
              rowHoverColor: Colors.yellow,            //This is applicable for web and desktop platforms
              rowHoverTextStyle: TextStyle(color: Colors.red, fontSize: 14,), //This is applicable for web and desktop platforms
              headerHoverColor: Colors.yellow, //This is applicable for web and desktop platforms.
              //highlightRowOnHover: false, //This is applicable for web and desktop platforms.
          ),
          child: SfDataGrid(
              source: _employeeDataSource,
              selectionMode: SelectionMode.singleDeselect,

              // gridLinesVisibility: GridLinesVisibility.both,
              // headerGridLinesVisibility: GridLinesVisibility.both,// 아무것도없을시 가로줄만표시
                                                                   // horizontal이  default값
              // gridLinesVisibility: GridLinesVisibility.vertical,
              // headerGridLinesVisibility: GridLinesVisibility.vertical,

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
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Salary',
                          overflow: TextOverflow.ellipsis,
                        ))),
              ]),
        ),



        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen15());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}

