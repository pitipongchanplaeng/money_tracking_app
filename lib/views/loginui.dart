// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:money_tracking_app_6419410030/models/users.dart';
import 'package:money_tracking_app_6419410030/services/call_api.dart';
import 'package:money_tracking_app_6419410030/views/homeui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  bool _obscureText = true;
  bool pwdStatus = true;

  TextEditingController _usernameController = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");

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
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          ' เข้าใช้งาน Money Tracking',
          style: TextStyle(
            fontSize: 25,
            //fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            // กลับไปหน้าก่อนหน้า
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.values.first,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  ClipRRect(
                    child: Image.asset(
                      'assets/images/money.png',
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        hintText: 'username',
                        hintStyle: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 20,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'ชื่อผู้ใช้',
                        labelStyle: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 20,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.deepOrangeAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        labelText: 'รหัสผ่าน',
                        labelStyle: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        surfaceTintColor: Colors.deepOrangeAccent,
                        elevation: 30,
                        fixedSize: const Size(350, 50),
                        backgroundColor: Colors.deepOrangeAccent),
                    onPressed: () {
                      if (_usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        showDialogMassage(context, 'แจ้งเตือน',
                            'กรุณาป้อนข้อมูลให้ครบทุกช่อง');
                      } else {
                        User user = User(
                          userName: _usernameController.text,
                          userPassword: _passwordController.text,
                        );
                        CallApi.CheckLoginApi(user).then(
                          (value) => {
                            if (value[0].message == "1")
                              {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeUi(
                                      user: value[0],
                                    ),
                                  ),
                                ),
                              }
                            else
                              {
                                showDialogMassage(context, 'แจ้งเตือน',
                                    "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง"),
                              }
                          },
                        );
                      }
                    },
                    child: Text('เข้าใช้งาน',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        )),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
