import 'package:datagrid/view/screen10.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource_9.dart';

class Mainscreen9 extends StatefulWidget {
  @override
  State<Mainscreen9> createState() => _Mainscreen9State();
}

class _Mainscreen9State extends State<Mainscreen9> {
  late EmployeeDataSource9 _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource9(employees: _employees, dataGridController: _dataGridController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('9. selection'),
        ),
        body: Column(
          children: [
            Expanded(
              child: SfDataGridTheme(
                data: SfDataGridThemeData(selectionColor: Colors.redAccent),
                child: SfDataGrid(
                    source: _employeeDataSource,
                    selectionMode: SelectionMode.single,
                    controller: _dataGridController,
                    allowSorting: true,

                    //navigationMode: GridNavigationMode.cell,

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
                    ],
                    onSelectionChanging: //single????????? ???????????? singleDeselect?????? ?????????????????????
                        (List<DataGridRow> addedRows,
                            List<DataGridRow> removedRows) {
                      final index = _employeeDataSource.dataGridRows
                          .indexOf(addedRows.last);
                      Employee employee = _employees[index];       //designation_inclass ??? manager?????? ????????? ????????? ?????????
                      if (employee.designation_inclass == 'Manager') {
                        //???????????????????????????
                        print(
                            '-----------------------------------------changing');
                        return false; //false??? ????????? onSelectionChanged??? ??????
                      }
                      print('-----------------------------------------changing');
                      return true;
                    },
                    onSelectionChanged: (List<DataGridRow> addedRows,
                        List<DataGridRow> removedRows) {
                      print('-----------------------------------------changed');
                      // apply your logics
                    },
                    onCurrentCellActivating:
                        (RowColumnIndex currentRowColumnIndex,
                            RowColumnIndex previousRowColumnIndex) {
                      if (currentRowColumnIndex.rowIndex == 2 &&
                          currentRowColumnIndex.columnIndex == 3) {
                        return false;
                      }

                      return true;
                    },
                    onCurrentCellActivated: (RowColumnIndex currentRowColumnIndex,
                        RowColumnIndex previousRowColumnIndex) {
                      // apply your logics
                    },
                    onCellTap: (DataGridCellTapDetails details) {
                      print('--------------------------- onCellTap');
                      print(details);
                    },
                    onCellDoubleTap: (DataGridCellDoubleTapDetails details) {
                      print('--------------------------- onCellDoubleTap');
                      print(details);
                    },
                    onCellLongPress: (DataGridCellLongPressDetails details) {
                      print('--------------------------- onCellLongPress');
                      print(details);
                    },
                    onCellSecondaryTap: (DataGridCellTapDetails details) {
                      print('--------------------------- onCellSecondaryTap');
                      print(details);
                    }),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    child: Text('Get Info'),
                    onPressed: () {
                      int selectedIndex = _dataGridController.selectedIndex;
                      DataGridRow selectedRow =
                          _dataGridController.selectedRow!;
                      print(selectedIndex);
                      print(selectedRow);
                      print(selectedRow.getCells()[0].value);
                      print(selectedRow.getCells()[1].value);
                      print(selectedRow.getCells()[2].value);
                      print(selectedRow.getCells()[3].value);
                      print('----------------------------------------------');
                      print(_employees[selectedIndex].id_inclass); //??????????????????????????? ???????????????
                      print(_employees[selectedIndex].name_inclass); //index??? ?????????????????????
                      print(_employees[selectedIndex].designation_inclass); //?????? ??????????????????
                      print(_employees[selectedIndex].salary_inclass); //???????????? ????????? ????????????
                      print('----------------------------------------------');
                      print(_employeeDataSource.dataGridRows[selectedIndex]
                          .getCells()[0]
                          .value);
                      //?????? ???????????? ????????????
                    }),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    child: Text('Clear Selection'),
                    onPressed: () {
                      _dataGridController.selectedIndex = -1;
                      //or
                      //this._dataGridController.selectedRow = null;
                      //multiple??? ?????? single????????? ??????
                      //cell??????????????? ??????????????? ?????? ????????? row???
                    }),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    child: Text('Clear Selection'),
                    onPressed: () {
                      _dataGridController.selectedRows = [];
                      //single????????? ??????????????? multiple????????? ?????????
                    }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: Text('Selection1'),
                    onPressed: () {
                      //SelectedIndex
                      _dataGridController.selectedIndex = 4; //5?????? ???????????? ??????????????????
                    }),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    child: Text('Selection2'),
                    onPressed: () {
                      //SelectedRow
                      _dataGridController.selectedRow =
                          _employeeDataSource.dataGridRows[3];
                    }),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    //multiple?????? ????????????
                    child: Text('Selection3'),
                    onPressed: () {
                      //SelectedRows
                      _dataGridController.selectedRows = [
                        _employeeDataSource.dataGridRows[1],
                        _employeeDataSource.dataGridRows[3],
                        _employeeDataSource.dataGridRows[6],
                      ];
                    }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ElevatedButton(
                    child: Text('Get current cell'),
                    // navigationMode: GridNavigationMode.cell,???????????? ??????
                    onPressed: () {
                      //???????????? RowIndex??? ColumnIndex?????? -1 ??????
                      var _currentCell = _dataGridController.currentCell;
                      print('-----------------------------------');
                      print(_currentCell);
                      if (_currentCell.columnIndex != -1) {
                        print(_employeeDataSource
                            .dataGridRows[_currentCell.rowIndex]
                            .getCells()[_currentCell.columnIndex]
                            .value);
                        print(_dataGridController.selectedRow!
                            .getCells()[_currentCell.columnIndex]
                            .value); //cell????????? row ????????? ??????????????????
                      }
                    }),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    //cell??? ?????????????????? row??? ?????????????????? ?????????????????? ???????????????
                    child: Text('Move current cell'), //???????????? ?????? ???????????? ????????? ????????? ?????????
                    onPressed: () {
                      _dataGridController
                          .moveCurrentCellTo(RowColumnIndex(6, 3));
                      _dataGridController.selectedRow =
                          _employeeDataSource.dataGridRows[1];
                      //??? ?????? 1??? row??? (1,3) cell??? ?????????
                      //?????? row??? ????????? ????????? ????????? ?????????????????? ??? cell??? column??? ????????????
                      //????????? ?????????????????? ???????????? column??? cell??? ?????????
                    }),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen10());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ));
  }
}
