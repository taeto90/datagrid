import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../screen2_func/employee_class.dart';



class EmployeeDataSource_Ge extends DataGridSource {
  EmployeeDataSource_Ge({required List<Employee> employees}) {
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

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                dataGridCell.value.toString(),
                overflow: TextOverflow.ellipsis,
              ));
        }).toList());
  }
}