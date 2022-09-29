import 'package:datagrid/view/screen9.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../main.dart';
import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/edit_source.dart';




class Mainscreen8 extends StatefulWidget {
  @override
  State<Mainscreen8> createState() => _Mainscreen8State();
}

class _Mainscreen8State extends State<Mainscreen8> {
  late EditEmployeeDataSource _employeeDataSource10;
  List<Employee> _employees10 = <Employee>[];

  final DataGridController gridcontroller = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees10 = getEmployeeData();
    _employeeDataSource10 = EditEmployeeDataSource(employees: _employees10);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('8.s Editing'),),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(                         //원래있던값을 다른값으로 변경하지않으면 끝나지가않음
                      child: Text("Begin Edit"),
                      onPressed: () {
                        gridcontroller.beginEdit(RowColumnIndex(2, 3));
                      }),
                  SizedBox(width: 30,),
                  TextButton(                       //작동안함...     아마 위에꺼가문저인거같음
                      child: Text("End Edit"),
                      onPressed: () {
                        gridcontroller.endEdit();
                      }),
                  SizedBox(width: 30,),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(
                                  'Cell is in Edit Mode: ${gridcontroller.isCurrentCellInEditing}'),
                            ));
                      },
                      child: const Text('In Edit Mode')),
                ],
              ),
              Expanded(
                child: SfDataGrid(
                    source: _employeeDataSource10,

                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,

                    allowEditing: true,
                    controller: gridcontroller,
                    //editingGestureType: EditingGestureType.tap,  //원래는2번 이거쓰면 1번만 탭


                    selectionMode: SelectionMode.single,
                    navigationMode: GridNavigationMode.cell,
                    columns: [
                      GridColumn(
                          columnName: 'id_ingrid',
                          allowEditing: false,
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerRight,
                              child: Text(
                                'ID',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          columnName: 'name_ingrid',
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Name',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          columnName: 'designation_ingrid',
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Designation',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          columnName: 'salary_ingrid',
                          label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Salary',
                                overflow: TextOverflow.ellipsis,
                              ))),
                    ]),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen9());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}