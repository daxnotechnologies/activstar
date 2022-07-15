
import 'dart:convert';
import 'dart:io';

import 'package:activstar/constants/Urls.dart';
import 'package:activstar/models/productModel.dart';

import '../constants/constants.dart';
import 'package:http/http.dart' as http;
class productApi{
  Future<productModel> getproduct() async {
    var headers = {"Authorization":"$access_token",
    };
    var response =await http.get( Uri.parse('${baseUrl}/product/newproducts'),headers: headers);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return  productModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.reasonPhrase);
      throw Exception("failed to load product data");
    }
  }
}