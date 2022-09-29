import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../screen2_func/employee_class.dart';



class EmployeeDataSource10 extends DataGridSource {
  EmployeeDataSource10({required List<Employee> employees}) {
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

  @override
  Widget? buildTableSummaryCellWidget(GridTableSummaryRow summaryRow, GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex, String summaryValue) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Text(summaryValue,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
    );
  }


  // @override        //표준편차구하는건데 패스! 표준편차는 잘 구하지만 그냥 이대로쓰면 기본적인 sum,average등이 꼬여버림
  // String calculateSummaryValue(GridTableSummaryRow summaryRow,
  //     GridSummaryColumn? summaryColumn, RowColumnIndex rowColumnIndex) {
  //   List<int> getCellValues(GridSummaryColumn summaryColumn) {
  //     final List<int> values = <int>[];
  //     for (final DataGridRow row in rows) {
  //       final DataGridCell? cell = row.getCells().firstWhereOrNull(
  //               (DataGridCell element) =>
  //           element.columnName == summaryColumn.columnName);
  //       if (cell != null && cell.value != null) {
  //         values.add(cell.value);
  //       }
  //     }
  //     return values;
  //   }
  //
  //   String? title = summaryRow.title;
  //   if (title != null) {
  //     if (summaryRow.showSummaryInRow && summaryRow.columns.isNotEmpty) {
  //       for (final GridSummaryColumn summaryColumn in summaryRow.columns) {
  //         if (title!.contains(summaryColumn.name)) {
  //           double deviation = 0;
  //           final List<int> values = getCellValues(summaryColumn);
  //           if (values.isNotEmpty) {
  //             int sum = values.reduce((value, element) =>
  //             value + pow(element - values.average, 2).toInt());
  //             deviation = sqrt((sum) / (values.length - 1));
  //           }
  //           title = title.replaceAll(
  //               '{${summaryColumn.name}}', deviation.toString());
  //         }
  //       }
  //     }
  //   }
  //   return title ?? '';
  // }
}