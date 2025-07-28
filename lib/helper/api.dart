import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String url, @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("there is a problem i satusCode ${response.statusCode}");
    }
  }

  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 201 || response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'ther ia a problem  ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {
      // 'Content-Type': 'application/json'
    };
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response =
        await http.put(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 201 || response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception(
          'ther ia a problem  ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

//هاد حصرا للاستبيان
  Future<dynamic> postt({
    required String url,
    required Map<String, dynamic>
        body, // Or Map<String, String> if it's form-urlencoded
    required String token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body), // Ensure the request body is JSON encoded
    );

    if (response.statusCode == 200) {
      // Success case
      return jsonDecode(response.body);
    } else {
      // This is where the problematic exception is being thrown
      // print('API Error Response Body: ${response.body}'); // Add this for more debugging
      throw Exception(
          'ther is a problem ${response.statusCode} with body ${response.body}'); // <--- **CHANGE IS HERE**
    }
  }

  Future<dynamic> delete({required String url, required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response =
        await http.delete(Uri.parse(url), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 204) {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } else {
      throw Exception(
          'هناك مشكلة في الحذف، رمز الحالة: ${response.statusCode} مع نص الرد: ${response.body}');
    }
  }
}
