import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

import '../screen2_func/employee_class.dart';

class EmployeeDataSource_Autofit extends DataGridSource {
  EmployeeDataSource_Autofit({required List<Employee> employees}) {
    _employeeData = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'ID_GridCell', value: e.id_inclass),
      DataGridCell<String>(columnName: 'Name_GridCell', value: e.name_inclass),
      DataGridCell<String>(
          columnName: 'Designation_GridCell', value: e.designation_inclass),
      DataGridCell<int>(columnName: 'Salary_GridCell', value: e.salary_inclass),
    ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          late String cellValue;

          if (e.columnName == 'Salary_GridCell') {
            cellValue = NumberFormat.simpleCurrency(decimalDigits: 0).format(e.value);
          }
          else{ cellValue = e.value.toString();}

          return Container(
            //height: 100,     안먹힘
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.0),
            child: Text(cellValue,
                style: (e.columnName == 'Name_GridCell' || e.columnName == 'Designation_incolumn')//gridcell의 columnname을 가져와야함
                    ? TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,fontSize: 15)
                    : null),
          );
        }).toList());
  }
  @override
  bool shouldRecalculateColumnWidths() { //Recalculating column widths when datasource is changed
    return true;
  }
}

class CustomColumnSizer extends ColumnSizer {
  // @override
  // double computeHeaderCellWidth(GridColumn column, TextStyle style) {
  //   if (column.columnName == 'Name_incolumn' || column.columnName == 'ID_GridCell') {//column의 columnname을 가져와야함
  //     style =
  //         TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,fontSize: 20);
  //   }
  //   return super.computeHeaderCellWidth(column, style); //이때의 넓이를 예상해서반환
  // }
  // @override
  // double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
  //     TextStyle textStyle) {
  //   if (column.columnName == 'Name_incolumn') {
  //     textStyle =
  //         TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  //   }else if (column.columnName == 'Salary_incolumn') {
  //     cellValue =
  //         NumberFormat.simpleCurrency(decimalDigits: 0).format(cellValue);
  //   }
  //   return super.computeCellWidth(column, row, cellValue, textStyle);
  // }


}