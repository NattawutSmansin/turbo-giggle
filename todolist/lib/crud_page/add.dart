import 'package:flutter/material.dart';

//http method api start
import 'package:http/http.dart' as http;
import 'dart:async';
//http method api end

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  Future postTodo() async {
    // var url = Uri.https('6b3f-2405-9800-ba01-94dd-f1eb-e409-322d-670e.ngrok.io',
    //     '/api/post-alltodolist');
    var url = Uri.http('xxx.xxx.x.xxx:8000', '/api/post-alltodolist');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';

    var response = await http.post(
        //ส่งข้อมูล Data json ขึ้น server
        url,
        headers: header,
        body: jsondata);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการใหม่'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  // ช่องกรอกข้อมูล
                  controller: todo_title,
                  decoration: InputDecoration(
                    labelText: "ชื่อสินค้า",
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  // ช่องกรอกข้อมูล
                  minLines: 4,
                  maxLines: 8,
                  controller: todo_detail,
                  decoration: InputDecoration(
                    labelText: "รายละเอียด",
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(20)),
                onPressed: () {
                  postTodo();
                  todo_title.clear();
                  todo_detail.clear();
                  final snackBar = SnackBar(
                    content: const Text('เพิ่มข้อมูลเสร็จสิ้น'),
                    action: SnackBarAction(
                          label: 'กลับหน้าหลัก',
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context); //กลับหน้าหลัก
                            });
                          },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text('บันทึก',
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ),
            ),
            
          ], // end children
        ),
      ),
    );
  }
}
