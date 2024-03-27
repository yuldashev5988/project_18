import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../model/new_api_model.dart';

class NetworkService {
  static var logger = Logger();

  static String BASE = "dummy.restapiexample.com";
  static Map<String, String> header = {};

  ///APIs
  static String API_GET_ALL = "/api/v1/employees";
  static String API_GET_ONE = "/api/v1/employees/"; // + id;
  static String API_POST = "/api/v1/create";
  static String API_PUT = "/api/v1/update/"; // + id;
  static String API_DELETE = "/api/v1/delete/"; // + id;

  /// request methods
  static Future<String> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api, params);
    Response response = await get(uri, headers: header);
    if (response.statusCode == 200) {
      return response.body;
    }
    return "";
  }

  static Future<String> POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api, params);
    Response response =
    await post(uri, headers: header, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return "";
  }

  static Future<String> PUT(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api);
    Response response =
    await put(uri, headers: header, body: jsonEncode(params));
    if (response.statusCode == 200) {
      return response.body;
    }
    return "";
  }

  static Future<String> DELETE(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await delete(uri, headers: header, body: jsonEncode(params));
    log("response status : ${response.statusCode}");

    if (response.statusCode == 200) {
      return "Deleted";
    }
    return response.body;
  }

  static Map<String, dynamic> paramsGET() {
    Map<String, dynamic> params = {};
    return params;
  }

  static paramsPOST({required Employee employee}) {
    Employee employee1 = Employee(id: employee.id,
        employee_name: employee.employee_name,
        employee_salary: employee.employee_salary,
        employee_age: employee.employee_age,
        profile_image: employee.profile_image);
    return employee1.toJson();
  }

  static paramsPUT({required Employee employee}) {
    Employee employee1 = Employee(id: employee.id,
        employee_name: employee.employee_name,
        employee_salary: employee.employee_salary,
        employee_age: employee.employee_age,
        profile_image: employee.profile_image);
    return employee1.toJson();
  }

  static Map<String, String> paramsDELETE() {
    Map<String, String> params = {};
    return params;
  }

  static parsingResponse(String response) {
    dynamic json = jsonDecode(response);
    List<Employee> employees = List<Employee>.from(
        json['data'].map((employee) => Employee.fromJson(employee)));
    logger.i(employees.runtimeType);
    return employees;
  }
}
/*
  static Future<String> DELETE(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await delete(uri, headers: header, body: jsonEncode(params));
    log("response status : ${response.statusCode}");

    if (response.statusCode == 200) {
      return "Deleted";
    }
    return response.body;
  }
*/
