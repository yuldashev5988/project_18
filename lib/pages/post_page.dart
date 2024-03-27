import 'package:flutter/material.dart';
import 'package:project_18/model/new_api_model.dart';
import 'package:project_18/pages/new_api.dart';

import '../service/logger.dart';
import '../service/network_service.dart';
import '../service/toast.dart';

class PostPage extends StatefulWidget {
  static const String id = "post_page";
  Employee employee;

  PostPage({super.key,required this.employee});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController employeeSalaryController = TextEditingController();
  TextEditingController employeeAgeController = TextEditingController();
  TextEditingController profileImageController = TextEditingController();

  postInfo() {
    int id = widget.employee.id!;
    String employee_name = employeeNameController.text.trim();
    int employee_salary = int.parse(employeeSalaryController.text.trim());
    int age = int.parse(employeeAgeController.text.trim().toString());
    String profile_Image = "https://www.pngkey.com/png/full/72-729716_user-avatar-png-graphic-free-download-icon.png";

    Employee employee = Employee(
        id: id,
        employee_name: employee_name,
        employee_salary: employee_salary,
        employee_age: age,
        profile_image: profile_Image);
    NetworkService.POST(NetworkService.API_POST,
            NetworkService.paramsPOST(employee: employee))
        .then((response) => {
              LoggerService.infoLogger(response),
            });
    makeEmpty();
  }

  void makeEmpty() {
    employeeNameController.clear();
    employeeSalaryController.clear();
    employeeAgeController.clear();
    profileImageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.withOpacity(0.95),
        title: Text(
          "Post Page",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, EmployeePage.id);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: employeeNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Employee Name",
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: employeeSalaryController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "About Salary",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: employeeAgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Worker Age",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    postInfo();
                    setState(() {
                      if (employeeAgeController != null) {
                        Toast2222.showToast3();
                      } else {
                        Toast2222.showToast4();
                      }
                    });
                  },
                  child: const Text("Post")),
            ],
          )
        ],
      ),
    );
  }
}
