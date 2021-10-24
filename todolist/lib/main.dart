import 'package:flutter/material.dart';

import 'package:todolist/crud_page/todolist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodolistPage(),
    );
  }
}

// class MainPage extends StatefulWidget {
//   //const MainPage({ Key? key }) : super(key: key);

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold( 
      
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'หน้าแรก',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.category),
//             label: 'หมวดหมู่',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.contact_phone),
//             label: 'ติดต่อเรา',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'ฉัน',
//           ),
//         ],
//         selectedItemColor: Colors.blueAccent,
//       ),
//     );
//   }
// }