import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../screen2_func/employee_class.dart';



class EmployeeDataSource15 extends DataGridSource {
  EmployeeDataSource15({required List<Employee> employees}) {
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

  // @override            //셀단위  id와 designaition
  // DataGridRowAdapter? buildRow(DataGridRow row) {
  //   return DataGridRowAdapter(
  //       cells: row.getCells().map<Widget>((dataGridCell) {
  //         Color getColor() {
  //           if (dataGridCell.columnName == 'designation') {
  //             if (dataGridCell.value == 'Developer') {
  //               return Colors.tealAccent;
  //             } else if (dataGridCell.value == 'Manager') {
  //               return Colors.blue[200]!;
  //             }
  //           }
  //           return Colors.transparent;
  //         }
  //
  //         if (dataGridCell.columnName == 'id') {
  //           final int index = effectiveRows.indexOf(row);
  //           return Container(
  //               color: (index % 2 != 0) ? Colors.blueAccent : Colors.transparent,
  //               alignment: Alignment.centerRight,
  //               padding: EdgeInsets.symmetric(horizontal: 16.0),
  //               child: Text(
  //                 dataGridCell.value.toString(),
  //                 overflow: TextOverflow.ellipsis,
  //                 style: (index % 2 != 0)
  //                     ? TextStyle(fontStyle: FontStyle.italic)
  //                     : null,
  //               ));
  //         }
  //
  //
  //         TextStyle? getTextStyle() {
  //           if (dataGridCell.columnName == 'designation') {
  //             if (dataGridCell.value == 'Developer') {
  //               return TextStyle(fontStyle: FontStyle.italic);
  //             } else if (dataGridCell.value == 'Manager') {
  //               return TextStyle(fontStyle: FontStyle.italic);
  //             }
  //           }
  //           return null;
  //         }
  //
  //         return Container(
  //             color: getColor(),
  //             alignment: (dataGridCell.columnName == 'id' ||
  //                 dataGridCell.columnName == 'salary')
  //                 ? Alignment.centerRight
  //                 : Alignment.centerLeft,
  //             padding: EdgeInsets.symmetric(horizontal: 16.0),
  //             child: Text(
  //               dataGridCell.value.toString(),
  //               overflow: TextOverflow.ellipsis,
  //               style: getTextStyle(),
  //             ));
  //       }).toList());
  // }

  // @override          //Row 단위  salary 기준
  // DataGridRowAdapter buildRow(DataGridRow row) {
  //   Color getRowBackgroundColor() {
  //     final int salary = row.getCells()[3].value;
  //     if (salary >= 10000 && salary < 15000) {
  //       return Colors.blue[300]!;
  //     } else if (salary <= 15000) {
  //       return Colors.orange[300]!;
  //     }
  //     return Colors.transparent;
  //   }
  //
  //   TextStyle? getTextStyle() {
  //     final int salary = row.getCells()[3].value;
  //     if (salary >= 10000 && salary < 15000) {
  //       return TextStyle(color: Colors.white);
  //     } else if (salary <= 15000) {
  //       return TextStyle(color: Colors.white);
  //     }
  //
  //     return null;
  //   }
  //
  //   return DataGridRowAdapter(
  //       color: getRowBackgroundColor(),
  //       cells: row.getCells().map<Widget>((dataGridCell) {
  //         return Container(
  //             alignment: (dataGridCell.columnName == 'id' ||
  //                 dataGridCell.columnName == 'salary')
  //                 ? Alignment.centerRight
  //                 : Alignment.centerLeft,
  //             padding: EdgeInsets.symmetric(horizontal: 16.0),
  //             child: Text(
  //               dataGridCell.value.toString(),
  //               overflow: TextOverflow.ellipsis,
  //               style: getTextStyle(),
  //             ));
  //       }).toList());
  // }



  @override                    //row단위  교대로나오게하기 id가아닌 row이 index 기준으로하여
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getRowBackgroundColor() {
      final int index = effectiveRows.indexOf(row);
      if (index % 2 != 0) {
        return Colors.lightGreen[300]!;
      }

      return Colors.transparent;
    }

    return DataGridRowAdapter(
        color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
              alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                dataGridCell.value.toString(),
                overflow: TextOverflow.ellipsis,
              ));
        }).toList());
  }
}