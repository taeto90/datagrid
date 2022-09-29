import 'package:datagrid/main.dart';
import 'package:datagrid/view/screen11.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource10.dart';




class Mainscreen10 extends StatefulWidget {
  @override
  State<Mainscreen10> createState() => _Mainscreen10State();
}

class _Mainscreen10State extends State<Mainscreen10> {
  late EmployeeDataSource10 _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController gridcontroller = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource10(employees: _employees);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('10. summary'),),
        body: SfDataGrid(
            source: _employeeDataSource,
            selectionMode: SelectionMode.singleDeselect,
            gridLinesVisibility: GridLinesVisibility.both,
            //navigationMode: GridNavigationMode.cell,

            tableSummaryRows: [
              GridTableSummaryRow(
                  // showSummaryInRow: true,         //아래의 title이 출력
                  // title: 'Total Salary: {Sum} for ${_employeeDataSource.rows.length} employees',//실제로 출력되는 내용
                  // columns: [
                  //   GridSummaryColumn(
                  //       name: 'Sum',
                  //       columnName: 'salary_ingrid',
                  //       summaryType: GridSummaryType.sum)   //Sum Average Count Maximum Minimum가능
                  // ],
                  //_ingrid 와 _incolumn의 name이 같은경우
                //showSummaryInRow 가 true : title표시 false면 해당column 밑에 sum만표시
                // _ingrid 와 _incolumn의 name이 다른경우
                //showSummaryInRow 가 true : title표시 false면 아무것도 안나타남
                // true인데 name이 ingrid면 제대로 계산이됨 incolumn이면 title이 나오기는 하지만 계산이안됨

                  // showSummaryInRow: false,
                  // columns: [
                  //   GridSummaryColumn(
                  //       name: 'Count',
                  //       columnName: 'id',
                  //       summaryType: GridSummaryType.count)
                  // ],
                  // position: GridTableSummaryRowPosition.top)

                  color: Colors.indigo,
                  showSummaryInRow: false,                      //true로하면 title만 출력
                  title: 'Count: {Count}',
                  titleColumnSpan: 2,                           //title을 몇개의 column을 사용해서 보여줄거냐
                  columns: [                                    //너무 적으면 잘림
                    GridSummaryColumn(
                        name: 'Count',
                        columnName: 'id',
                        summaryType: GridSummaryType.count),
                    GridSummaryColumn(
                      name: 'count2',
                      columnName: 'designation',
                      summaryType: GridSummaryType.count,),
                    GridSummaryColumn(
                        name: 'Deviation',
                        columnName: 'salary',
                        summaryType: GridSummaryType.sum)
                  ],
                  position: GridTableSummaryRowPosition.bottom),
            ],
            //       color: Colors.indigo,                        //표준편차구하고싶을때사용
            //       showSummaryInRow: true,                      //summary의 글자가 하얀색이랑 컬러를 지정해줘야함
            //       title: 'Standard Deviation: {Deviation}',
            //       columns: [
            //         GridSummaryColumn(
            //             name: 'Deviation',
            //             columnName: 'salary',
            //             summaryType: GridSummaryType.sum)
            //       ],
            //       position: GridTableSummaryRowPosition.bottom),
            // ],
            columns: [
              GridColumn(
                  columnName: 'id',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.center,
                      child: Text(
                        'ID',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'designation',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Designation',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'salary',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Salary',
                        overflow: TextOverflow.ellipsis,
                      ))),
            ]),



        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Mainscreen11());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        )
    );
  }
}

