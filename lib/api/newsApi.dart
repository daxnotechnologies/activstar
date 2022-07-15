import 'dart:convert';
import 'dart:io';

import 'package:activstar/constants/Urls.dart';
import 'package:activstar/models/categoryModel.dart';
import 'package:activstar/models/newsModel.dart';
import 'package:activstar/models/testimonialModel.dart';

import '../constants/constants.dart';
import 'package:http/http.dart' as http;

class newsApi {
  Future<TestimonialModal> getTestimonials() async {
    var response = await http
        .get(Uri.parse('https://appka.activstar.eu/wp-json/app/testimonials'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Testimonial Body" + response.body);
      List<dynamic> arr = [];
      return TestimonialModal.fromJson(jsonDecode(response.body));
    } else {
      // print(response.reasonPhrase);
      throw Exception("failed to load Testimonial data");
    }
  }

  Future<newsModel> getNews() async {
    var response = await http
        .get(Uri.parse('https://appka.activstar.eu/wp-json/app/blog/'));
    //print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return newsModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.reasonPhrase);
      throw Exception("failed to load news data");
    }
  }

  Future<List<categoryItems>?> getCategory() async {
    var headers = {
      "Authorization": "$access_token",
    };
    var response = await http.get(Uri.parse('${baseUrl}/news/categories'),
        headers: headers);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return categoryModel.fromJson(jsonDecode(response.body)).items;
    } else {
      print(response.reasonPhrase);
      throw Exception("failed to load news data");
    }
  }

  Future<Map<String, dynamic>> getAccountInfo() async {
    var headers = {
      "Authorization": "$access_token",
    };
    var response = await http.get(Uri.parse('${baseUrl}/user/accountinfo'),
        headers: headers);
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      // print(response.reasonPhrase);
      throw Exception("failed to load news data");
    }
  }
}
