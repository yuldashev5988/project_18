import 'package:flutter/material.dart';
import 'package:project_18/model/new_api_model.dart';
import 'package:project_18/pages/new_api.dart';
import '../service/logger.dart';
import '../service/network_service.dart';
import '../service/toast.dart';

class PutPage extends StatefulWidget {
  Employee employee;
  PutPage({super.key, required this.employee});

  @override
  State<PutPage> createState() => _PutPageState();
}

class _PutPageState extends State<PutPage> {


  TextEditingController employeeNameController =
  TextEditingController();

  //text: pet.title
  TextEditingController employeeSalaryController = TextEditingController();
  TextEditingController employeeAgeController = TextEditingController();
  TextEditingController profileImageController = TextEditingController();

  //text: pet.body
  putInfo() {
    int? id = widget.employee.id;
    String employee_name=employeeNameController.text.trim();
    int employee_salary=int.parse(employeeSalaryController.text.trim());
    int employee_age = int.parse(employeeAgeController.text.trim());
    String profile_image = profileImageController.text.trim();

    Employee employee = Employee( employee_name: employee_name, employee_salary: employee_salary, employee_age: employee_age, profile_image: profile_image, id: id);
    NetworkService.PUT(
        NetworkService.API_PUT + id.toString() , NetworkService.paramsPUT(employee: employee))
        .then((response) => {
      LoggerService.infoLogger(response),
    });
    makeEmpty();
  }
  void makeEmpty(){
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
        title: const Text(
          "Put Page",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, EmployeePage.id);

            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
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
                controller: employeeNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Employee Name",
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
                controller: employeeSalaryController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Employee Salary",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: profileImageController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Worker image",
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
                    putInfo();
                    setState(() {
                      if(NetworkService.API_PUT!=null){
                        Toast2222.showToast();
                      }else{
                        Toast2222.showToast2();
                      }
                    });
                  },
                  child: const Text("Update")),
            ],
          )
        ],
      ),
    );
  }
}
