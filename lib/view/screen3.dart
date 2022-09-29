import 'package:datagrid/view/screen4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource3.dart';




class Mainscreen3 extends StatefulWidget {
  @override
  State<Mainscreen3> createState() => _Mainscreen3State();
}

class _Mainscreen3State extends State<Mainscreen3> {
  late EmployeeDataSource3 _employeeDataSource3;
  List<Employee> _employees3 = <Employee>[];

  final DataGridController gridcontroller = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees3 = getEmployeeData();
    _employeeDataSource3 = EmployeeDataSource3(employees: _employees3);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('3. Data Binding'),),
        body: Column(
          children: [
            Row(
              children: [
                TextButton(
                    child: const Text('Add row'),
                    onPressed: () {
                      _employees3.add(Employee(10011, 'Steve', 'Designer', 15000));
                      _employeeDataSource3.buildDataGridRows(_employees3);
                      _employeeDataSource3.updateDataGridSource();
                    }),
                TextButton(
                    child: const Text('Update cell value'),
                    onPressed: () {
                      _employees3[0].salary_inclass = 25000;
                      _employeeDataSource3.dataGridRows[0] = DataGridRow(cells: [
                        DataGridCell(value: _employees3[0].id_inclass, columnName: 'id'),
                        DataGridCell(value: _employees3[0].name_inclass, columnName: 'name'),
                        DataGridCell(value: _employees3[0].designation_inclass, columnName: 'designation'),
                        DataGridCell(value: _employees3[0].salary_inclass, columnName: 'salary'),
                      ]);

                      _employeeDataSource3.updateDataGridSource2(
                          rowColumnIndex: RowColumnIndex(0, 3));
                      //_employeeDataSource3.updateDataGridSource(); 로하여도 결과는같음
                      // 해당하는 cell만 바꿀것이냐 아니면 전체를 바꿀것이냐의 차이
                    }),
              ],
            ),
            Expanded(
              child: SfDataGrid(
                source: _employeeDataSource3,
                columns: [
                  GridColumn(
                      columnName: 'id_gridcolumn',
                      label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'ID',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'name',
                      //visible: false,       //안보이게
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

              ),
            ),
          ],
        ),


        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen4());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}


