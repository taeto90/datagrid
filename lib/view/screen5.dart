import 'package:datagrid/view/screen6.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource_autofit.dart';




class Mainscreen5 extends StatefulWidget {
  @override
  State<Mainscreen5> createState() => _Mainscreen5State();
}

class _Mainscreen5State extends State<Mainscreen5> {
  late EmployeeDataSource_Autofit _employeeDataSource_Autofit;
  List<Employee> _employees = <Employee>[];

  final DataGridController gridcontroller = DataGridController();
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource_Autofit = EmployeeDataSource_Autofit(employees: _employees);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('5.Columns Sizing'),),
        body: Column(
          children: [
            Expanded(
              child: SfDataGrid(
                source: _employeeDataSource_Autofit,

                // gridLinesVisibility: GridLinesVisibility.both,
                // headerGridLinesVisibility: GridLinesVisibility.both,

                //columnWidthCalculationRange: ColumnWidthCalculationRange.allRows, //아래의 autofit을 쓰기위하여 설정
                columnSizer: _customColumnSizer,
                columnWidthMode: ColumnWidthMode.auto,  //fitByCellValue는 왠만하면 하지말자
                columns: <GridColumn>[
                  GridColumn(
                      //autoFitPadding: EdgeInsets.all(30.0),  //왜하는지모르겠음 이걸바꿔도 변화x source의 padding을바꾸면 변화 d
                      columnName: 'ID_incolumn',
                      label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.center,
                          child: Text(
                            'ID',
                            softWrap: false,
                          ))),
                  GridColumn(
                      columnName: 'Name_incolumn',
                      label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Name',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'Designation_incolumn',
                      label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Designation',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'Salary_incolumn',

                      label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Salary',
                            overflow: TextOverflow.ellipsis,
                          ))),
                ],
                controller: gridcontroller,
                selectionMode: SelectionMode.multiple,
                // allowSorting: true,          //컬럼의 헤더를 선택시 정렬가능하게해줌
              ),
            ),
          ],
        ),
        floatingActionButton:  FloatingActionButton(
          onPressed: (){
            Get.to(Mainscreen6());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}
