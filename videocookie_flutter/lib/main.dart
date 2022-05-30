import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videocookie_flutter/view/Home.dart';
import 'package:videocookie_flutter/viewModel/item_list_view_model.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (c) => ItemListViewModel(),
        ),
      ],
        child: MaterialApp(
          theme: ThemeData(
              iconTheme: IconThemeData(
                  color: Color.fromRGBO(130, 66, 34, 1)),
              appBarTheme: AppBarTheme(
                  color: Color.fromRGBO(130, 66, 34, 1)
              ),
              textTheme: TextTheme(
                  bodyText2: TextStyle(color: Colors.red)
              )
          ),
          // home: List(),
          home: Home(),
          debugShowCheckedModeBanner: false,
        ),
      )
  );
}
