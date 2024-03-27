import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_18/pages/post_page.dart';
import 'package:project_18/pages/put_page.dart';

import '../model/new_api_model.dart';
import '../service/network_service.dart';

class EmployeePage extends StatefulWidget {
  static const String id = "emp_page";

   EmployeePage({super.key,});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  var logger = Logger();
  List items = [];

  void _getData() {
    NetworkService.GET(NetworkService.API_GET_ALL, NetworkService.paramsGET())
        .then((response) => {
              logger.i(response),
            });
  }

  void _parsingData() {
    NetworkService.GET(NetworkService.API_GET_ALL, NetworkService.paramsGET())
        .then((response) => {
              logger.i(response),
              setState(() {
                items = NetworkService.parsingResponse(response);
              })
            });
  }


  deleteDataFromUI(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _parsingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.withOpacity(0.95),
        title: const Text(
          "Employee Page",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    _parsingData();
                  },
                  icon: const Icon(
                    Icons.refresh_outlined,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, PostPage.id);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )),
            ],
          )
        ],
      ),
      body: items.isNotEmpty
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://image.winudf.com/v2/image/b3JnLmthbGVlbS5iNHdvcmxkLm5pY2VzdW5zZXRmcmVlaW1hZ2VzX3NjcmVlbnNob3RzXzRfNGUyOTQ1MWQ/screen-4.jpg?fakeurl=1&type=.jpg"),
                    fit: BoxFit.cover),
              ),
              child: RefreshIndicator(
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (ctx, index) {
                      return empData(items[index], index);
                    }),
                onRefresh: () async {
                  _parsingData();
                },
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget empData(Employee employee, int index) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.yellow.shade300.withOpacity(0.45),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            employee.id.toString().toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 100,
            width: 20,
            decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                color: Colors.black54,
                width: 2,
              )),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    employee.employee_name.toString().toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Age: ${employee.employee_age.toString().toUpperCase()}",
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Salary: ${employee.employee_salary.toString().toUpperCase()}\$",
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              IconButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PutPage(employee: employee,),));
              }, icon:const  Icon(Icons.update_rounded)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      deleteDataFromUI(index);
                    });
                  },
                  icon:const  Icon(Icons.delete)),
            ],
          ),
        ],
      ),
    );
  }
}
