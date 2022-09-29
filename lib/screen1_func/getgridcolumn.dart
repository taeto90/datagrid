import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

List<GridColumn> getColumns() {
  return <GridColumn>[
    GridTextColumn(
        columnName: 'orderID',
        width: 70,
        label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('Order ID',
                overflow: TextOverflow.clip, softWrap: true))),
    GridTextColumn(
        columnName: 'customerID',
        width: 100,
        label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Text('Customer ID',
                overflow: TextOverflow.clip, softWrap: true))),
    GridTextColumn(
        columnName: 'employeeID',
        width: 100,
        label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('Employee ID',
                overflow: TextOverflow.clip, softWrap: true))),
    GridTextColumn(
        columnName: 'orderDate',
        width: 95,
        label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Text('Order Date',
                overflow: TextOverflow.clip, softWrap: true))),
    GridTextColumn(
        columnName: 'freight',
        width: 65,
        label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('Freight')))
  ];
}