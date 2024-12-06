// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, prefer_const_constructors_in_immutables, dead_code

import 'package:flutter/material.dart';
import 'package:money_tracking_app_6419410030/models/money.dart';
import 'package:money_tracking_app_6419410030/models/users.dart';
import 'package:money_tracking_app_6419410030/services/call_api.dart';

class RecordUi extends StatefulWidget {
  User? user;

  RecordUi({
    this.user,
    super.key,
  });

  @override
  State<RecordUi> createState() => _RecordUiState();
}

class _RecordUiState extends State<RecordUi> {
  bool _isLoading = true;
  String _errorMessage = '';
  List<Money> _moneyList = [];

  @override
  void initState() {
    fetchMoneyList();
    super.initState();
  }

  Future<void> fetchMoneyList() async {
    try {
      List<Money> moneyList = await CallApi.getMoneyAPI(widget.user!.userId);
      setState(() {
        _moneyList = moneyList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Error fetching data: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
        ),
        width: double.infinity,
        color: Colors.white,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : _moneyList.isEmpty
                    ? Center(
                        child: Text(
                          'ไม่มีข้อมูลการเงิน',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _moneyList.length,
                        itemBuilder: (context, index) {
                          final money = _moneyList[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(money.moneyDetail ?? "ไม่มีข้อมูล"),
                                subtitle: Text(
                                    money.moneyDateTime ?? "ไม่ระบุวันที่"),
                                trailing: Text(
                                  "${(money.moneyInOut ?? 0.0).toStringAsFixed(2)} บาท",
                                  style: TextStyle(
                                    color: money.moneyType == 1
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                leading: Icon(
                                  money.moneyType == 1
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: money.moneyType == 1
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
      ),
    );
  }
}
