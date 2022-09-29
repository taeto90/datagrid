import 'package:datagrid/view/screen5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';




class Mainscreen4 extends StatefulWidget {
  @override
  State<Mainscreen4> createState() => _Mainscreen4State();
}

class _Mainscreen4State extends State<Mainscreen4> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('4. Column Types'),),
        body: Column(
          children: [
            TextButton(
                child: Text('Get Checked Items Information'),
                onPressed: () {
                  //Index of the checked item
                  var _selectedIndex = _dataGridController.selectedIndex;

                  //CheckedRow
                  var _selectedRow = _dataGridController.selectedRow;

                  //Collection of checkedRows
                  var _selectedRows = _dataGridController.selectedRows;

                  print(_selectedIndex);
                  print(_selectedRow);
                  print(_selectedRows);
                }),
            Expanded(
              child: SfDataGrid(
                  source: _employeeDataSource,
                  controller: _dataGridController,
                  showCheckboxColumn: true, // SfDataGrid.selectionMode일때만 사용가능

                  checkboxColumnSettings: DataGridCheckboxColumnSettings(
                    backgroundColor: Colors.yellow,
                      showCheckboxOnHeader: false,                 //헤더셀에서는 체크박스 안보이게하기
                      label: Text('Selector'), width: 100         //헤더셀에 글자넣기
                  ),
                  selectionMode: SelectionMode.multiple,
                  columns: <GridColumn>[
      GridColumn(
                columnName: 'id',
                visible: false,  //열 숨기기
                label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'ID',
                      overflow: TextOverflow.ellipsis,
                    ))),
      GridColumn(
                columnName: 'name',
                width: 150.0,  //너비조절
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
                    )))
    ]),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen5());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}
