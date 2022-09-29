import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../screen2_func/employee_class.dart';

class OrderInfoDataSource extends DataGridSource {
  OrderInfoDataSource({required this.employeesInClass, required this.rowsPerPage}) {
    _paginatedEmployees = employeesInClass;
    //employeesInClass가 list가 아니라  Iterable.일 경우 growable: false : Iterable의 크기고 고정되어있을때사용
    //_paginatedEmployees = employeesInClass.getRange(0, 5).toList(growable: false);
    buildPaginatedDataGridRows();
  }

  List<Employee> _paginatedEmployees = [];          //현재 화면에 보이는 페이즈를표시하기위해 2개의 list가필요
  List<Employee> employeesInClass = <Employee>[];   //전체 데이터 List
  int rowsPerPage;

  List<DataGridRow> dataGridRows = [];
  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildPaginatedDataGridRows() {           //GridCell을 만들때 _paginatedEmployees로 만들어야함
    dataGridRows = _paginatedEmployees.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id_ingrid', value: dataGridRow.id_inclass),
        DataGridCell<String>(columnName: 'name_ingrid', value: dataGridRow.name_inclass),
        DataGridCell<String>(columnName: 'designation_ingrid', value: dataGridRow.designation_inclass),
        DataGridCell<int>(columnName: 'salary_ingrid', value: dataGridRow.salary_inclass),
      ]);
    }).toList();
  }



  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          if (dataGridCell.columnName == 'id_ingrid') {                         //이렇게 복잡하게안해도됨
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerRight,
              child: Text(
                dataGridCell.value.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            );
          } else if (dataGridCell.columnName == 'name_ingrid') {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                ));
          } else if (dataGridCell.columnName == 'designation_ingrid') {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerRight,
                child: Text(
                 // DateFormat.yMd().format(dataGridCell.value).toString(),
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                ));
          } else {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: Text(
                  NumberFormat.currency(locale: "ko_KR")  //, symbol: '\@'
                      .format(dataGridCell.value)
                      .toString(),
                  //NumberFormat.simpleCurrency(decimalDigits: 0).format(dataGridCell.value),

                  //dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                ));
          }
        }).toList());
  }

  // @override
  // Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
  //   int startIndex = newPageIndex * rowsPerPage;
  //   int endIndex = startIndex + rowsPerPage;
  //   if (startIndex < employeesInClass.length && endIndex <= employeesInClass.length) {
  //     _paginatedEmployees = employeesInClass.getRange(startIndex, endIndex).toList(growable: false);
  //     buildPaginatedDataGridRows();
  //     notifyListeners();
  //   } else {
  //     _paginatedEmployees = employeesInClass.getRange(startIndex, employeesInClass.length).toList();
  //     buildPaginatedDataGridRows();
  //     notifyListeners();
  //   }
  //   return true;
  // }
  // @override              //async방식으로 만듬 위에꺼와 비교하여 그냥 대기시간문 추가됨
  // Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
  //   int startIndex = newPageIndex * rowsPerPage;
  //   int endIndex = startIndex + rowsPerPage;
  //   if (startIndex <  employeesInClass.length && endIndex <= employeesInClass.length) {
  //     await Future.delayed(Duration(milliseconds: 1000));
  //     _paginatedEmployees =
  //         employeesInClass.getRange(startIndex, endIndex).toList(growable: false);
  //     buildPaginatedDataGridRows();
  //     notifyListeners();
  //   } else {
  //         _paginatedEmployees = employeesInClass.getRange(startIndex, employeesInClass.length).toList();
  //         buildPaginatedDataGridRows();
  //         notifyListeners();
  //       }
  //   return true;
  // }
  // @override                     //처음꺼랑 다를거없음
  // Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) {
  //   final int _startIndex = newPageIndex * rowsPerPage;
  //   int _endIndex = _startIndex + rowsPerPage;
  //
  //   //if (_endIndex > employeesInClass.length) {_endIndex = employeesInClass.length;}  이걸하면 아래쪽의 else부분을 따로 처리안해도됨 둘중하나 선택하면됨
  //
  //   if (_startIndex < employeesInClass.length && _endIndex <= employeesInClass.length) {
  //     _paginatedEmployees = employeesInClass.getRange(_startIndex, _endIndex).toList();
  //   } else {
  //     _paginatedEmployees = employeesInClass.getRange(_startIndex, employeesInClass.length).toList();
  //   }
  //   buildPaginatedDataGridRows();
  //   notifyListeners();
  //   return Future<bool>.value(true);
  // }



  void updateDataGriDataSource() {
    notifyListeners();
  }


}