import 'package:datagrid/view/screen7.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';




class Mainscreen6 extends StatefulWidget {
  @override
  State<Mainscreen6> createState() => _Mainscreen6State();
}

class _Mainscreen6State extends State<Mainscreen6> {
  late EmployeeDataSource _employeeDataSource6;
  List<Employee> _employees6 = <Employee>[];


  @override
  void initState() {
    super.initState();
    _employees6 = getEmployeeData();
    _employeeDataSource6 = EmployeeDataSource(employees: _employees6);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('6. Stacked Headers'),),
        body:Column(
          children: [
            Expanded(
              child: SfDataGrid(
                // headerRowHeight: 20,
                // rowHeight: 40,
                // gridLinesVisibility: GridLinesVisibility.both,
                // headerGridLinesVisibility: GridLinesVisibility.both,
                  onQueryRowHeight: (RowHeightDetails details) {
                    if (details.rowIndex == 0) {
                      return 70.0;
                    }
                    return details.rowHeight;
                  },
                source: _employeeDataSource6,
                columnWidthMode: ColumnWidthMode.fill,
                columns: [
                  GridColumn(
                      columnName: '1',
                      label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.center,
                          child: Text(
                            'ID',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: '2',
                      label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Name',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: '3',
                      label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Designation',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: '4',
                      label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Salary',
                            overflow: TextOverflow.ellipsis,
                          ))),
                ],
            stackedHeaderRows: <StackedHeaderRow>[
              StackedHeaderRow(cells: [
                StackedHeaderCell(
                    columnNames: ['1', '2', '3', '4'],
                    child: Container(
                        color: const Color(0xFFF1F1F1),
                        child: Center(child: Text('Stack All')))),
              ]),
              StackedHeaderRow(cells: [
                StackedHeaderCell(
                    columnNames: ['1', '2'],
                    child: Container(
                        color: const Color(0xFFF1F1F1),
                        child: Center(child: Text('Stack1')))),
                StackedHeaderCell(
                    columnNames: ['3', '4'],
                    child: Container(
                         height: 50,
                        color: const Color(0xFFF1F1F1),
                        child: Center(child: Text('Stack2'))))
              ])
            ])
              ),
          ],
        ),


        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen7());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}
