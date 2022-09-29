import 'package:datagrid/main.dart';
import 'package:datagrid/view/screen18.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screen2_func/emoloyee_datasource.dart';
import '../screen2_func/employee_class.dart';
import '../screen2_func/getEmployeedata.dart';
import '../sources/datasource11.dart';
import '../sources/datasource_page.dart';

class Mainscreen17 extends StatefulWidget {
  @override
  State<Mainscreen17> createState() => _Mainscreen17State();
}

class _Mainscreen17State extends State<Mainscreen17> {
  int _rowsPerPage = 7; //한페이지에 나오는 데이터의수
  final double _dataPagerHeight = 80.0; //아래 페이지표시하는곳의 높이 클수록 위로 올라감
  bool showLoadingIndicator = false;

  late OrderInfoDataSource _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  final DataGridController gridcontroller = DataGridController();
  DataPagerController _controller = DataPagerController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData3();
    _employeeDataSource = OrderInfoDataSource(
        employeesInClass: _employees, rowsPerPage: _rowsPerPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('17. Paging'),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Column(children: [
          SizedBox(
              height: constraint.maxHeight - _dataPagerHeight - 100,
              width: constraint.maxWidth,
              child: _buildStack(constraint) //데이터가 위치할공간
              ),
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.firstPage();
                  },
                  child: Text('처음'),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.previousPage();
                  },
                  child: Text('이전'),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.nextPage();
                  },
                  child: Text('다음'),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.lastPage();
                  },
                  child: Text('마지막'),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Container(
              //아래 페이지표시하는곳이 위치할공간
              height: _dataPagerHeight,
              //color: Colors.redAccent,
              child: SfDataPagerTheme(
                data: SfDataPagerThemeData(
                  // itemBorderWidth: 5,
                  // //화살표,숫자경계 두께
                  // itemBorderColor: Colors.grey.shade400,
                  // //화살표,숫자 경계색
                  // itemColor: Colors.white,
                  // selectedItemColor: Colors.lightGreen,
                  // itemBorderRadius: BorderRadius.circular(5),
                  // backgroundColor: Colors.teal,
                ),
                child: SfDataPager(
                    delegate: _employeeDataSource,
                    pageCount: (_employees.length % _rowsPerPage) == 0
                        ? _employees.length / _rowsPerPage
                        : _employees.length / _rowsPerPage + 1,
                    //아무것도없는페이지로 가버리면 에러뜸

                    visibleItemsCount: 3,
                    direction: Axis.horizontal,
                    initialPageIndex: 1,
                    controller: _controller,


                    // itemWidth: 40,
                    // itemHeight: 60,
                    //숫자 default : 각각 50
                    navigationItemWidth: 100,
                    navigationItemHeight: 70,
                    //화살표 default : 각각 50
                    firstPageItemVisible: false,
                    //처음으로가는버튼 비활성화
                    lastPageItemVisible: false,
                    //마지막으로가는버튼 비활성화

                    pageItemBuilder: (String itemName) {
                      if (itemName == 'Next') {
                        return Center(
                          child: Text('Next'),
                        );
                      }
                      if (itemName == 'Previous') {
                        return Center(
                          child: Text('Previous'),
                        );
                      }
                    },
                    itemPadding: EdgeInsets.all(10.0), //아이템들사이의 거리

                    // availableRowsPerPage: [10, 20, 30],
                    // onRowsPerPageChanged: (int? rowsPerPage) {
                    //   setState(() {
                    //     _employeeDataSource.rowsPerPage = rowsPerPage!;
                    //     _employeeDataSource.updateDataGriDataSource();
                    //   });
                    // },

                    onPageNavigationStart: (int pageIndex) {
                      setState(() {
                        showLoadingIndicator = true;
                        print('--------------------------------start');
                      });
                    },
                    onPageNavigationEnd: (int pageIndex) {
                      setState(() {
                        showLoadingIndicator = false;
                        print('--------------------------------end');
                      });
                    }),
              )),
        ]);
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(Mainscreen18());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      )
    );
  }

  Widget _buildDataGrid(BoxConstraints constraint) {
    return SfDataGrid(
        source: _employeeDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        rowsPerPage: _rowsPerPage,      //이걸해버리면 source에서 handlePageChange을 정의할필요가없어짐 이걸 왜 맨뒤에 둬서.... 개뻘짓됨....
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id_incolumn',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Id',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'name_incolumn',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'designation_incloumn',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Designation',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'salary_incolumn',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Salary',
                    overflow: TextOverflow.ellipsis,
                  )))
        ]);
  }

  Widget _buildStack(BoxConstraints constraints) {
    List<Widget> _getChildren() {
      //새로운함수를 정의
      final List<Widget> stackChildren = [];
      stackChildren.add(_buildDataGrid(constraints)); //제일아래 원래 datagrid가 깔림

      if (showLoadingIndicator) {
        stackChildren.add(Container(
            //다음에 indicator를 포함한 container가 위치
            color: Colors.black12,
            //black12로하면 화면이 약간 어두워지지만 뒤에꺼가보임 white로 하면 완전히 하얀색으로 뒤에가 안보임
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 3, //회전하는 동그라미의 굵기
                ))));
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }
}
