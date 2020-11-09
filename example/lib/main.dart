import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:persian_date/persian_date.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  PersianDate persianDate = PersianDate(format: "yyyy/mm/dd  \n DD  , d  MM  ");
  String _datetime = '';
  String _format = 'yyyy-mm-dd';
  String _value = '';
  String _valuePiker = '';
  DateTime selectedDate = DateTime.now();

  Future _selectDate() async {
    String picked = await jalaliCalendarPicker(
        context: context,
        convertToGregorian: false,
        showTimePicker: true,
        hore24Format: true);
    if (picked != null) setState(() => _value = picked);
    print('val:$_value');
  }

  @override
  void initState() {
    super.initState();
    print(
        "Parse TO Format ${persianDate.gregorianToJalali("2019-02-20T00:19:54.000Z", "yyyy-m-d hh:nn")}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Date'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _selectDate,
                    child: Text('Taghvim'),
                  ),
                  new RaisedButton(
                    onPressed: _showDatePicker,
                    child:  Text('Date Picker'),
                  ),
                  Text(
                    "\n Right Now :  ${persianDate.now}",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  Divider(),
                  Text(
                    "Taghvim",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _value,
                    textAlign: TextAlign.center,
                  ),
                  Divider(),
                  Text(
                    _valuePiker,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
            // Expanded(child: ShowCalender())
          ],
        ),
      ),
    );
  }

  void _showDatePicker() {
    final bool showTitleActions = false;
    DatePicker.showDatePicker(context,
        minYear: 1300,
        maxYear: 1450,
/*      initialYear: 1368,
      initialMonth: 05,
      initialDay: 30,*/
        confirm: Text(
          'accept',
          style: TextStyle(color: Colors.red),
        ),
        cancel: Text(
          'cancel',
          style: TextStyle(color: Colors.cyan),
        ),
        dateFormat: _format, onChanged: (year, month, day) {
      if (!showTitleActions) {
        _changeDatetime(year, month, day);
      }
    }, onConfirm: (year, month, day) {
      _changeDatetime(year, month, day);
      _valuePiker =
          " Date : $_datetime  \n Year : $year \n  Month :   $month \n  Day :  $day";
    });
  }

  void _changeDatetime(int year, int month, int day) {
    setState(() {
      _datetime = '$year-$month-$day';
    });
  }
}
