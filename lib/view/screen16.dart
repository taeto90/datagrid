import 'package:datagrid/main.dart';
import 'package:datagrid/view/screen17.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource11.dart';
import '../sources/datasource_16.dart';

class Mainscreen16 extends StatefulWidget {
  @override
  State<Mainscreen16> createState() => _Mainscreen16State();
}

class _Mainscreen16State extends State<Mainscreen16> {
  late EmployeeDataSource11 _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController gridcontroller = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData2();
    _employeeDataSource = EmployeeDataSource11(employees: _employees);
  }

  late Map<String, double> columnWidths = {
    'id_incolumn': double.nan,
    'name': double.nan,
    'name2': double.nan,
    'designation': double.nan,
    'designation2': double.nan,
    'salary': double.nan,
    'salary2': double.nan
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('16. Columns Resizing'),
        ),
        body: Column(
          children: [
            Expanded(
              child: SfDataGridTheme(
                data: SfDataGridThemeData(
                  columnResizeIndicatorColor: Colors.orange,
                  columnResizeIndicatorStrokeWidth: 10.0,
                ),
                child: SfDataGrid(
                    source: _employeeDataSource,
                    selectionMode: SelectionMode.singleDeselect,
                    //columnWidthMode: ColumnWidthMode.fill,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,

                    allowColumnsResizing: true,

                    // columnResizeMode: ColumnResizeMode.onResizeEnd,
                    // //설정시 마우스드래그가 끝나는순간 적용
                    // //설정을 안하면 드래그중 실시간으로 적용


                    //열 크기 조정이 시작되면 호출, 크기 조정 표시기가 나타나면 호출
                    onColumnResizeStart: (ColumnResizeStartDetails details) {
                      // Disable resizing for the `id` column.
                      if (details.column.columnName == 'id_incolumn') {
                        return false;
                      }
                      return true;
                    },

                    //열의 크기를 조정할 때 호출, 일반적으로 여기서 열 너비를 설정
                    onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                      setState(() {
                        columnWidths[details.column.columnName] = details.width;
                      });
                      return true;
                    },
                    //열 크기 조정이 종료되면 호출, 일반적으로 포인터를 놓으면 호출
                    onColumnResizeEnd: (ColumnResizeEndDetails details) {
                      print('Column resizing is ended for the ${details.column.columnName}');
                    },
                    columns: [
                      GridColumn(
                          width: columnWidths['id_incolumn']!,
                          columnName: 'id_incolumn',
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerRight,
                              child: Text(
                                'ID',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          width: columnWidths['name']!,
                          minimumWidth: 50.0,
                          columnName: 'name',
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Name',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          width: columnWidths['name2']!,
                          columnName: 'name2',
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Name2',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          width: columnWidths['designation']!,
                          columnName: 'designation',
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Designation',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          width: columnWidths['designation2']!,
                          columnName: 'designation2',
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Designation2',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          width: columnWidths['salary']!,
                          columnName: 'salary',
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Salary',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          width: columnWidths['salary2']!,
                          columnName: 'salary2',
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Salary2',
                                overflow: TextOverflow.ellipsis,
                              ))),
                    ]),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen17());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ));
  }
}
