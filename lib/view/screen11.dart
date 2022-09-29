import 'package:datagrid/main.dart';
import 'package:datagrid/view/screen12.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource11.dart';

class Mainscreen11 extends StatefulWidget {
  @override
  State<Mainscreen11> createState() => _Mainscreen11State();
}

class _Mainscreen11State extends State<Mainscreen11> {
  late EmployeeDataSource11 _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController gridcontroller = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData2();
    _employeeDataSource = EmployeeDataSource11(employees: _employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('11. Freeze Panes'),
        ),
        body: SfDataGridTheme(
          data: SfDataGridThemeData(
              frozenPaneElevation: 0.0, //0이 아니게 설정하면 색이 안보임
              frozenPaneLineColor: Colors.red, //선으로할건지 elevation으로할건지 하나만 선택해야함
              frozenPaneLineWidth: 3),
          child: SfDataGrid(
              source: _employeeDataSource,
              columnWidthMode: ColumnWidthMode.auto,
              controller: gridcontroller,
              selectionMode: SelectionMode.singleDeselect,
              frozenColumnsCount: 1,
              //제일왼쪽에있는 id가 고정됨
              footerFrozenColumnsCount: 1,
              //제일오른쪽에있는 salary2가 고정됨
              frozenRowsCount: 1,
              //제일위에있는 row가 고정
              footerFrozenRowsCount: 1,
              //제일아래에있는 row가 고정

              // tableSummaryRows: [
              //   GridTableSummaryRow(
              //       showSummaryInRow: true,
              //       title: 'Total count: {Count} ',
              //       columns: [
              //         GridSummaryColumn(
              //             name: 'Count',
              //             columnName: 'id',
              //             summaryType: GridSummaryType.count)
              //       ],
              //       position: GridTableSummaryRowPosition.bottom)
              // ],

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
                    columnName: 'name2',
                    label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name2',
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
                    columnName: 'designation2',
                    label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Designation2',
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
                GridColumn(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen12());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ));
  }
}
