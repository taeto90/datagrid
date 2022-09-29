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


  @override           //편집이 완료되면 호출  notifyListeners 를 호출할필요없이 자동으로 UI가 바뀜
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
        .getCells()
        .firstWhereOrNull((DataGridCell dataGridCell) =>
    dataGridCell.columnName == column.columnName)?.value ?? '';
    //dataGridRow.getCells() 를 통해 얻은 dataGridCell셀에대하여
    // dataGridCell의 columnName이 column.columnName과 같으면
    // DataGridCell.value를  아니면 ''를 oldValue에 넣는다
    // 여기서 _ingrid와  _incolumn에서의 이름이 같아야함
    // 다르게할려면 많이복잡해지므로 같게하자......
    print('Oldvalue is ~~~~~~~~~~~~~~~');
    print(dataGridRow.getCells()[0].columnName);   //id_ingrid 출력
    print(dataGridRow.getCells()[1].columnName);   //name_ingrid 출력
    print(dataGridRow.getCells()[2].columnName);   //designation_ingrid 출력
    print(column.columnName);                      //name_incolumn 출력
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

  @override                    //편집하기위하여 더블클릭하는순간 실행됨 즉 위의 onCellSubmit보다 먼저 실행
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
    //새 셀 값을 재설정해야 합니다.이전에 수정되지 않은 [DataGridCell] 값에 커밋되지 않도록 하기 위해.
    newCellValue = null;

    final bool isNumericType =
        column.columnName == 'id_ingrid' || column.columnName == 'salary_ingrid';

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,         //이걸 해줘야 편집모드진입(더블탭)시 키보드가 자동으로 올라옴
        controller: editingController..text = displayText,  //바꾸기위해 더블클릭하였을때 미리 적혀있는 문장
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),   //16을 0 으로바꾸면 글자가 너무 내려가있음
        ),
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);     //String을 int로 변화
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

          //모바일 플랫폼에서. [CellSubmit] 콜백을 호출하여 canSubmitCell 및
          // onCellSubmit을 실행하여 한 곳에서 새 값을 커밋합니다.          뭔말이지??
          submitCell();
        },
      ),
    );
  }

  @override   //셀 이 편집 모드로 들어갈 때 호출  밖에서 GridColumn 안에 allowEditing: false,하는것과 같은효과
  bool onCellBeginEdit(
      DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    if (column.columnName == 'id_ingrid') {
      // Return false, to restrict entering into the editing.
      return false;
    } else {
      return true;
    }
  }

  @override  //셀이 편집을 끝내기 전에 호출 대표적으로는 null방지
  bool canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    if (column.columnName == 'salary_ingrid' && newCellValue == null) {
      // Return false, to retain in edit mode.
      // To avoid null value for cell
      return false;
    } else if (rowColumnIndex.equals(RowColumnIndex(2, 2))) {  //편집모드가 안끝남... 그후 2,3을 바꾸는 버튼을 누르면 값이 같아지는 error발생
      return false;
    }else {
      return true;
    }
  }
                       // ESC key를 누르면  canSubmitCell and onCellSubmit will not be called
  @override         //called when you press the Esc key from Web and Desktop platforms
  void onCellCancelEdit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    print('ESC키 누름');              //에뮬레이터에서는 실행안됨 웹에서는 잘됨
    // handle the cancel editing code here
  }


}