import 'package:flutter/material.dart';

import 'View/Login/login.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(130, 66, 34, 1)
        ),
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(130, 66, 34, 1)
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.red)
        )
      ),
      home: List(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'videocookie',
      home: AuthPage()
    );
  }
}


class List extends StatelessWidget {
  const List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비디오쿠키'),
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(130, 66, 34, 1),
              ),
              child: Text('온석태 님'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Text('ㅎㅇ'),
    );
  }
}
