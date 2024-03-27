import 'package:flutter/material.dart';
import 'package:project_18/model/new_api_model.dart';
import 'package:project_18/pages/new_api.dart';
import 'package:project_18/pages/post_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  EmployeePage(),
      routes: {
        EmployeePage.id: (context) =>  EmployeePage(),
        PostPage.id:(context)=>PostPage(employee: Employee(id: 0, employee_name: "", employee_salary: 0, employee_age: 0, profile_image: ""),),
      },
    );
  }
}
