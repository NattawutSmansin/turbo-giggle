import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:todolist/crud_page/add.dart';
import 'package:todolist/crud_page/update_todolist.dart';

class TodolistPage extends StatefulWidget {
  @override
  _TodolistPageState createState() => _TodolistPageState();
}

class _TodolistPageState extends State<TodolistPage> {
  List todolistitems = [];

  @override
  void initState() {
    super.initState();
    getTodolist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPage()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('List ข้อมูล API'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getTodolist();
                });
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      ),
      body: todolistCreate(),
    );
  }

  Widget todolistCreate() {
    return ListView.builder(
        itemCount: todolistitems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('${todolistitems[index]['title']}'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdatePage(
                              todolistitems[index]['id'],
                              todolistitems[index]['title'],
                              todolistitems[index]['detail'],
                            ))).then((value) {
                               getTodolist();
                  setState(() {
                    if (value == "delete") {
                      //ถ้าข้อมูลลบเสร็จสิ้น จะวนกลับมาหน้าเดิมและส่ง Popup ขึ้นมา
                      final snackBar = SnackBar(
                        content: const Text('ลบข้อมูลเสร็จสิ้น'),
                        action: SnackBarAction(
                          label: 'รีเฟซ',
                          onPressed: () {
                            setState(() {
                              getTodolist();
                            });
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      getTodolist();
                    } 
                   
                    
                  });
                });
              },
            ),
          );
        });
  }

  Future<void> getTodolist() async {
    // List alltodo = [];
    var url = Uri.http('xxx.xxx.x.xxx:8000', '/api/get-alltodolist');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    //print(result);
    setState(() {
      todolistitems = jsonDecode(result);
    });
  }
}
