// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_tracking_app_6419410030/models/money.dart';
import 'package:money_tracking_app_6419410030/models/users.dart';
import 'package:money_tracking_app_6419410030/services/call_api.dart';

class AddIncomeScreenUi extends StatefulWidget {
  User? user;
  AddIncomeScreenUi({
    this.user,
    super.key,
  });

  @override
  State<AddIncomeScreenUi> createState() => _AddIncomeScreenUiState();
}

class _AddIncomeScreenUiState extends State<AddIncomeScreenUi> {
  TextEditingController _moneyDetailController =
      TextEditingController(text: "");
  TextEditingController _moneyInOutController = TextEditingController(text: "");
  TextEditingController _moneyDateController = TextEditingController(text: "");
  TextEditingController _moneyTimeController = TextEditingController(text: "");

  DateTime initDate = DateTime(1900);
  DateTime lastDate = DateTime(2100);
  DateTime defaultDate = DateTime.now();
  TimeOfDay defaultTime = TimeOfDay.now();

  Future displayCalendar(BuildContext context) async {
    return await showDatePicker(
      context: context,
      firstDate: initDate,
      lastDate: lastDate,
      initialDate: defaultDate,
    );
  }

  Future<TimeOfDay?> displayTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: defaultTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  Future<void> showDialogMassage(context, titleText, msg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            titleText,
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'เพิ่มรายการเงินเข้า',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                TextField(
                  controller: _moneyDetailController,
                  decoration: InputDecoration(
                    labelText: 'รายการเงินเข้า',
                    hintText: "Lists",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                TextField(
                  controller: _moneyInOutController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'จํานวนเงิน',
                    hintText: "0.00",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                TextField(
                  controller: _moneyDateController,
                  decoration: InputDecoration(
                    labelText: 'วันที่เงินเข้า',
                    hintText: "YYYY-MM-DD",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_month,
                        color: Colors.deepOrangeAccent,
                      ),
                      onPressed: () {
                        displayCalendar(context).then((value) {
                          setState(() {
                            if (value != null) {
                              _moneyDateController.text =
                                  value.toString().substring(0, 10);
                            }
                          });
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                TextField(
                  controller: _moneyTimeController,
                  decoration: InputDecoration(
                    labelText: 'เวลาที่เงินเข้า',
                    hintText: "ในกรณีไม่ระบุเวลาจะเป็วเวลาปัจจุบัน",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.clock,
                        color: Colors.deepOrangeAccent,
                      ),
                      onPressed: () {
                        displayTime(context).then((value) {
                          setState(() {
                            if (value != null) {
                              _moneyTimeController.text =
                                  value.toString().substring(10, 15);
                              // value.toString();
                            }
                          });
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_moneyDetailController.text.isEmpty) {
                      showDialogMassage(
                        context,
                        'แจ้งเตือน',
                        'กําหนดรายการเงินเข้า',
                      );
                    } else if (_moneyInOutController.text.isEmpty) {
                      showDialogMassage(
                        context,
                        'แจ้งเตือน',
                        'กําหนดจํานวนเงินเข้า',
                      );
                    } else if (_moneyDateController.text.isEmpty) {
                      showDialogMassage(
                        context,
                        'แจ้งเตือน',
                        'กําหนดวันที่เงินเข้า',
                      );
                    } else {
                      Money money = Money(
                        moneyDetail: _moneyDetailController.text,
                        moneyInOut: double.parse(_moneyInOutController.text),
                        moneyDateTime: _moneyTimeController.text == ''
                            ? _moneyDateController.text +
                                DateTime.now().toString().substring(10, 19)
                            : _moneyDateController.text +
                                ' ' +
                                _moneyTimeController.text,
                        moneyType: 1,
                        userId: widget.user!.userId,
                      );
                      CallApi.AddMoneyApi(money).then(
                        (value) {
                          if (value.isNotEmpty) {
                            showDialogMassage(
                              context,
                              'แจ้งเตือน',
                              'บันทึกข้อมูลเรียบร้อยแล้ว',
                            );
                            _moneyDetailController =
                                TextEditingController(text: "");
                            _moneyInOutController =
                                TextEditingController(text: "");
                            _moneyDateController =
                                TextEditingController(text: "");
                            _moneyTimeController =
                                TextEditingController(text: "");
                          }
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.80,
                      MediaQuery.of(context).size.height * 0.060,
                    ),
                  ),
                  child: Text(
                    'บันทึก',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height *
                          0.02, // ขนาดฟอนต์
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
