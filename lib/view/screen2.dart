
import 'package:datagrid/view/screen3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';

class Mainscreen2 extends StatefulWidget {
  @override
  State<Mainscreen2> createState() => _Mainscreen2State();
}

class _Mainscreen2State extends State<Mainscreen2> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController gridcontroller = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('2. Start'),),
      body: Column(
        children: [
          Expanded(
            child: SfDataGrid(
              source: _employeeDataSource,


              headerRowHeight: 30,
              rowHeight: 40,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,


              columnWidthMode: ColumnWidthMode.fill,// fill 균등하게 끝까지채움 lastColumnFill 처음과 끝만 길게해서채움
              columns: [
                GridColumn(
                    columnName: 'id_gridcolumn',
                    label: Container(
                      color: Colors.grey,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          'ID',
                          overflow: TextOverflow.ellipsis,
                          //overflow
                          // ellipsis : 지정된 사이즈에 넘어갈때 글자 뒤에 ...을 붙여 생략해준다
                          //fade나 clip도있다
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
              controller: gridcontroller,
              selectionMode: SelectionMode.multiple,
             // allowSorting: true,          //컬럼의 헤더를 선택시 정렬가능하게해줌
            ),
          ),
          SizedBox(height: 10,),
          Text('number of rows : ${_employeeDataSource.rows.length}'),
          SizedBox(height: 10,),
          Text(': ${_employeeDataSource.rows[0].getCells()[2].value}'),
          SizedBox(height: 10,),
          TextButton(
              child: Text('Get Selection Information'),
              onPressed: () {
                int selectedIndex = gridcontroller.selectedIndex;
                int colunmIndex = gridcontroller.currentCell.columnIndex;// 둘다
                int rowIndex = gridcontroller.currentCell.rowIndex;      // -1만 뜸.=>navigationMode: GridNavigationMode.cell,모드일때 사용
                DataGridRow selectedRow = gridcontroller.selectedRow!;
                List<DataGridRow> selectedRows = gridcontroller.selectedRows;
                print(selectedIndex);
                print(selectedRow);
                print(selectedRows);
                print(colunmIndex);
                print(rowIndex);

              }),
        ],
      ),
        floatingActionButton:  FloatingActionButton(
          onPressed: (){
            Get.to(Mainscreen3());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}


