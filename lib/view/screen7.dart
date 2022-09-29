import 'package:datagrid/view/screen8.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../main.dart';
import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource3.dart';

class Mainscreen7 extends StatefulWidget {
  const Mainscreen7({Key? key}) : super(key: key);

  @override
  State<Mainscreen7> createState() => _Mainscreen7State();
}

class _Mainscreen7State extends State<Mainscreen7> {
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
        appBar: AppBar(title: Text('7. Sorting'),),
        body: Column(
          children: [
            Row(
              children: [ TextButton(
                  onPressed: () {
                    _employeeDataSource.sortedColumns.add(SortColumnDetails(
                        name: 'name_ingrid', sortDirection: DataGridSortDirection.ascending));
                    _employeeDataSource.sort();
                    //name에  ingrid로 하면 데이터가 정렬됨 & incolumn으로하면 header에 화살표가생김
                    //_employeeDataSource.updateDataGridSource();
                  },
                  child: Text('Apply sort ascending')),
              SizedBox(width: 30,),
                TextButton(
                    onPressed: () {
                      _employeeDataSource.sortedColumns.add(SortColumnDetails(
                          name: 'id_ingrid', sortDirection: DataGridSortDirection.descending));
                      _employeeDataSource.sort();
                      //_employeeDataSource.updateDataGridSource();
                    },
                    child: Text('Apply sort descending')),],
            ),
            Expanded(
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                      sortIcon: Icon(Icons.arrow_circle_up),
                      sortIconColor: Colors.redAccent),
                  child: SfDataGrid(
                      source: _employeeDataSource,

                    allowSorting: true,
                    allowMultiColumnSorting: true,
                    allowTriStateSorting: true,
                    sortingGestureType: SortingGestureType.doubleTap,
                    showSortNumbers: true,
                    //navigationMode: GridNavigationMode.cell,

                    columnWidthMode: ColumnWidthMode.fill,
                    selectionMode: SelectionMode.multiple,
                      columns: [
                        GridColumn(
                            columnName: 'id_ingrid',
                            allowSorting: false,
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'ID7',
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
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Designation',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                            columnName: 'salary_ingrid',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Salary',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                      ],
            ),
                ),
            )],
        ),



        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen8());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}
