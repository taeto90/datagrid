import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../screen2_func/employee_class.dart';
import 'package:collection/collection.dart';

class EditEmployeeDataSource extends DataGridSource {
  EditEmployeeDataSource({required List<Employee> employees}) {
    buildDataGridRows(employees);
    _employees=employees;
  }

  void buildDataGridRows(List<Employee> employees) {
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
  }List<DataGridRow> dataGridRows = [];


  List<Employee> _employees = <Employee>[];
  @override
  List<DataGridRow> get rows => dataGridRows;



  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
              alignment: (dataGridCell.columnName == 'id_ingrid' ||
                  dataGridCell.columnName == 'salary_ingrid')
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                dataGridCell.value.toString(),
                overflow: TextOverflow.ellipsis,
              ));
        }).toList());
  }
  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// DataGridCell on onCellSubmit method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();


  @override           //????????? ???????????? ??????  notifyListeners ??? ????????????????????? ???????????? UI??? ??????
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
        .getCells()
        .firstWhereOrNull((DataGridCell dataGridCell) =>
    dataGridCell.columnName == column.columnName)?.value ?? '';
    //dataGridRow.getCells() ??? ?????? ?????? dataGridCell???????????????
    // dataGridCell??? columnName??? column.columnName??? ?????????
    // DataGridCell.value???  ????????? ''??? oldValue??? ?????????
    // ????????? _ingrid???  _incolumn????????? ????????? ????????????
    // ?????????????????? ???????????????????????? ????????????......
    print('Oldvalue is ~~~~~~~~~~~~~~~');
    print(dataGridRow.getCells()[0].columnName);   //id_ingrid ??????
    print(dataGridRow.getCells()[1].columnName);   //name_ingrid ??????
    print(dataGridRow.getCells()[2].columnName);   //designation_ingrid ??????
    print(column.columnName);                      //name_incolumn ??????
    print(oldValue);

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'id_ingrid') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'id_ingrid', value: newCellValue);
      _employees[dataRowIndex].id_inclass = newCellValue as int;
    } else if (column.columnName == 'name_ingrid') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'name_ingrid', value: newCellValue);
      _employees[dataRowIndex].name_inclass = newCellValue.toString();
    } else if (column.columnName == 'designation_ingrid') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'designation_ingrid', value: newCellValue);
      _employees[dataRowIndex].designation_inclass = newCellValue.toString();
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'salary_ingrid', value: newCellValue);
      _employees[dataRowIndex].salary_inclass = newCellValue as int;
    }
  }

  @override                    //????????????????????? ???????????????????????? ????????? ??? ?????? onCellSubmit?????? ?????? ??????
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
        .getCells()
        .firstWhereOrNull((DataGridCell dataGridCell) =>
    dataGridCell.columnName == column.columnName)
        ?.value
        ?.toString() ??
        '';

    print('displayText is ~~~~~~~~~~~~~~~~~~~');
    print(displayText);

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    //??? ??? ?????? ??????????????? ?????????.????????? ???????????? ?????? [DataGridCell] ?????? ???????????? ????????? ?????? ??????.
    newCellValue = null;

    final bool isNumericType =
        column.columnName == 'id_ingrid' || column.columnName == 'salary_ingrid';

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,         //?????? ????????? ??????????????????(?????????)??? ???????????? ???????????? ?????????
        controller: editingController..text = displayText,  //??????????????? ???????????????????????? ?????? ???????????? ??????
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),   //16??? 0 ??????????????? ????????? ?????? ???????????????
        ),
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);     //String??? int??? ??????
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          // In Mobile Platform.
          // Call [CellSubmit] callback to fire the canSubmitCell and
          // onCellSubmit to commit the new value in single place.

          //????????? ???????????????. [CellSubmit] ????????? ???????????? canSubmitCell ???
          // onCellSubmit??? ???????????? ??? ????????? ??? ?????? ???????????????.          ??????????????
          submitCell();
        },
      ),
    );
  }

  @override   //??? ??? ?????? ????????? ????????? ??? ??????  ????????? GridColumn ?????? allowEditing: false,???????????? ????????????
  bool onCellBeginEdit(
      DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    if (column.columnName == 'id_ingrid') {
      // Return false, to restrict entering into the editing.
      return false;
    } else {
      return true;
    }
  }

  @override  //?????? ????????? ????????? ?????? ?????? ?????????????????? null??????
  bool canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    if (column.columnName == 'salary_ingrid' && newCellValue == null) {
      // Return false, to retain in edit mode.
      // To avoid null value for cell
      return false;
    } else if (rowColumnIndex.equals(RowColumnIndex(2, 2))) {  //??????????????? ?????????... ?????? 2,3??? ????????? ????????? ????????? ?????? ???????????? error??????
      return false;
    }else {
      return true;
    }
  }
                       // ESC key??? ?????????  canSubmitCell and onCellSubmit will not be called
  @override         //called when you press the Esc key from Web and Desktop platforms
  void onCellCancelEdit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    print('ESC??? ??????');              //???????????????????????? ???????????? ???????????? ??????
    // handle the cancel editing code here
  }


}