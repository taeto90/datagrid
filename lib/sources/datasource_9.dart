import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../screen2_func/employee_class.dart';



class EmployeeDataSource9 extends DataGridSource {
  EmployeeDataSource9({required List<Employee> employees,required this.dataGridController}) {
    buildDataGridRows(employees);
  }

  void buildDataGridRows(List<Employee> employees) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: dataGridRow.id_inclass),
      DataGridCell<String>(columnName: 'name', value: dataGridRow.name_inclass),
      DataGridCell<String>(
          columnName: 'designation', value: dataGridRow.designation_inclass),
      DataGridCell<int>(
          columnName: 'salary', value: dataGridRow.salary_inclass),
    ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];
  final DataGridController dataGridController;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    TextStyle? getSelectionTextStyle() {
      return dataGridController.selectedRows.contains(row)        //선택되었을때의 TextStyle설정
          ? TextStyle(
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w300,
        color: Colors.white,
      )
          : null;
    }

    return DataGridRowAdapter(                                 //일반적인 container
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            color: Colors.transparent,
            alignment: (dataGridCell.columnName == 'id' ||
                dataGridCell.columnName == 'salary')
                ? Alignment.centerRight
                : Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
              style: getSelectionTextStyle(),
            ),
          );
        }).toList());
     }
}