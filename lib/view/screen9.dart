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
                    onSelectionChanging: //single일때는 가능하나 singleDeselect일때 선택취소가안됨
                        (List<DataGridRow> addedRows,
                            List<DataGridRow> removedRows) {
                      final index = _employeeDataSource.dataGridRows
                          .indexOf(addedRows.last);
                      Employee employee = _employees[index];       //designation_inclass 가 manager일때 선택이 안되게 해버림
                      if (employee.designation_inclass == 'Manager') {
                        //선택이안되게해버림
                        print(
                            '-----------------------------------------changing');
                        return false; //false를 반환시 onSelectionChanged가 안됨
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
                      print(_employees[selectedIndex].id_inclass); //정렬을사용하게되면 정렬된후의
                      print(_employees[selectedIndex].name_inclass); //index를 반환하기때문에
                      print(_employees[selectedIndex].designation_inclass); //값이 정확하지않다
                      print(_employees[selectedIndex].salary_inclass); //왠만하면 위에거 사용하자
                      print('----------------------------------------------');
                      print(_employeeDataSource.dataGridRows[selectedIndex]
                          .getCells()[0]
                          .value);
                      //위와 마찬가지 문제발생
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
                      //multiple이 아닌 single일때만 가능
                      //cell에대해서는 클리어하지 않음 오로지 row만
                    }),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    child: Text('Clear Selection'),
                    onPressed: () {
                      _dataGridController.selectedRows = [];
                      //single에서는 작동안되고 multiple일때만 작동함
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
                      _dataGridController.selectedIndex = 4; //5번째 데이터를 선택하게만듬
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
                    //multiple일때 사용가능
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
                    // navigationMode: GridNavigationMode.cell,모드일때 사용
                    onPressed: () {
                      //아닐경우 RowIndex와 ColumnIndex모두 -1 반환
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
                            .value); //cell이아닌 row 전체가 선택되어야함
                      }
                    }),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    //cell을 선택하는것과 row를 선택하는것은 다른개념으로 이해해야함
                    child: Text('Move current cell'), //일반적인 화면 터치시는 두개가 동시에 작동함
                    onPressed: () {
                      _dataGridController
                          .moveCurrentCellTo(RowColumnIndex(6, 3));
                      _dataGridController.selectedRow =
                          _employeeDataSource.dataGridRows[1];
                      //이 경우 1번 row와 (1,3) cell이 선택됨
                      //그냥 row만 변경시 이전에 지정된 셀이있을경우 그 cell의 column을 따라가고
                      //그렇지 않을경우네는 제일처음 column의 cell이 선택됨
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
