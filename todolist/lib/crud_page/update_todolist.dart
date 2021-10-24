import 'package:flutter/material.dart';

//http method api start
import 'package:http/http.dart' as http;
import 'dart:async';
//http method api end

class UpdatePage extends StatefulWidget {
  final idDetail, titleDetail, contentDetail;
  const UpdatePage(this.idDetail, this.titleDetail, this.contentDetail);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  var _v1, _v2, _v3;

  @override
  void initState() {
    super.initState();
    _v1 = widget.idDetail;
    _v2 = widget.titleDetail;
    _v3 = widget.contentDetail;

    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  Future updateTodo() async {
    var url = Uri.http('xxx.xxx.x.xxx:8000', '/api/update-alltodolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';

    var response = await http.put(
        //ส่งข้อมูล Data json ขึ้น server
        url,
        headers: header,
        body: jsondata);
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http('xxx.xxx.x.xxx:8000', '/api/delete-alltodolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};

    var response = await http.delete(
      //ส่งข้อมูล Data json ขึ้น server
      url,
      headers: header,
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล $_v2'),
        actions: [
          IconButton(
              onPressed: () {
                deleteTodo();
                Navigator.pop(context, 'delete'); //เป็นฟังก์ชันเมื่อลบแล้วให้ไปหน้าแรก
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
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
                  updateTodo();
                  final snackBar = SnackBar(
                    content: const Text('อัพเดทข้อมูลเสร็จสิ้น'),
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
                child: Text('บันทึกข้อมูลเพื่ออัพเดท',
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
