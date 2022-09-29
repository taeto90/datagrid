import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'employee_class.dart';
import 'package:collection/collection.dart';

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id_ingrid', value: dataGridRow.id_inclass),
      DataGridCell<String>(columnName: 'name_ingrid', value: dataGridRow.name_inclass),
      DataGridCell<String>(
          columnName: 'designation_ingrid', value: dataGridRow.designation_inclass),
      DataGridCell<int>(
          columnName: 'salary_ingrid', value: dataGridRow.salary_inclass),
    ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override           //안써도 작동은하지만 왠지 쓰는게 좋을거같음 위도 마찬가지
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            color: (dataGridCell.columnName == 'id_ingrid' ||
                dataGridCell.columnName == 'salary')?
                  Colors.red[100]:Colors.white,          //color를 선택해버리면 select할때 티가 안남


              alignment: (dataGridCell.columnName == 'id_ingrid' ||
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




  // @override                //일반적인 오름차순 내림차순이아닌 문자열 길이로 정렬 collection package를 써야함
  // int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
  //   final String? value1 = a?.getCells()
  //       .firstWhereOrNull((element) => element.columnName == sortColumn.name)?.value;
  //   final String? value2 = b?.getCells()
  //       .firstWhereOrNull((element) => element.columnName == sortColumn.name)?.value;
  //
  //   int? aLength = value1?.length;
  //   int? bLength = value2?.length;
  //
  //   if (aLength == null || bLength == null) {
  //     return 0;
  //   }
  //
  //   if (aLength.compareTo(bLength) > 0) {
  //     return sortColumn.sortDirection == DataGridSortDirection.ascending
  //         ? 1
  //         : -1;
  //   } else if (aLength.compareTo(bLength) == -1) {
  //     return sortColumn.sortDirection == DataGridSortDirection.ascending
  //         ? -1
  //         : 1;
  //   } else {
  //     return 0;
  //   }
  // }
  // @override        //대소문자를 구별하지않는정렬
  // int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
  //   if (sortColumn.name == 'name') {
  //     final String? value1 = a
  //         ?.getCells()
  //         .firstWhereOrNull((element) => element.columnName == sortColumn.name)
  //         ?.value
  //         .toString();
  //     final String? value2 = b
  //         ?.getCells()
  //         .firstWhereOrNull((element) => element.columnName == sortColumn.name)
  //         ?.value
  //         .toString();
  //
  //     if (value1 == null || value2 == null) {
  //       return 0;
  //     }
  //
  //     if (sortColumn.sortDirection == DataGridSortDirection.ascending) {
  //       return value1.toLowerCase().compareTo(value2.toLowerCase());
  //     } else {
  //       return value2.toLowerCase().compareTo(value1.toLowerCase());
  //     }
  //   }
  //
  //   return super.compare(a, b, sortColumn);
  // }
}