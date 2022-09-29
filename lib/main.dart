
import 'package:datagrid/screen1_func/gridsource.dart';
import 'package:datagrid/view/screen10.dart';
import 'package:datagrid/view/screen11.dart';
import 'package:datagrid/view/screen12.dart';
import 'package:datagrid/view/screen13.dart';
import 'package:datagrid/view/screen14.dart';
import 'package:datagrid/view/screen15.dart';
import 'package:datagrid/view/screen16.dart';
import 'package:datagrid/view/screen17.dart';
import 'package:datagrid/view/screen18.dart';
import 'package:datagrid/view/screen2.dart';
import 'package:datagrid/view/screen3.dart';
import 'package:datagrid/view/screen5.dart';
import 'package:datagrid/view/screen6.dart';
import 'package:datagrid/view/screen7.dart';
import 'package:datagrid/view/screen8.dart';
import 'package:datagrid/view/screen9.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'screen1_func/getfromhttp.dart';
import 'screen1_func/getgridcolumn.dart';
import 'controller/controller.dart';
//https://www.syncfusion.com/kb/12646/how-to-populate-flutter-datatable-sfdatagrid-with-json-api


void main() {
  final controller = Get.put(Controller());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Mainscreen16(),
    );
  }
}
class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: getProductDataSource(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.hasData
                  ? SfDataGrid(source: snapshot.data, columns: getColumns())
                  : Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              );
            },
          ),
            floatingActionButton:  FloatingActionButton(
              onPressed: (){
                //Navigator.push(context,MaterialPageRoute(builder: (_) => MainScreen2()));
                Get.to(Mainscreen16());
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.redAccent,
            )
        ));
  }

  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await generateProductList();
    return ProductDataGridSource(productList);
  }

}




