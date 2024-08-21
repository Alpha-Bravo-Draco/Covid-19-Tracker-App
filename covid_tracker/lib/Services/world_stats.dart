// import 'package:flutter/material.dart';
import 'dart:convert';

// import 'package:flutter_application_2/Model/countries_model.dart';
import 'package:flutter_application_2/Model/model.dart';
import 'package:flutter_application_2/Services/Utils/appurl.dart';
import 'package:http/http.dart' as http;
// import 'package:intl_phone_field/countries.dart';

class StatsServices {
  Future<Model> fetchWorldStatsApi() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatsApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return Model.fromJson(data);
    } else {
      throw Exception("Could not find the required data");
    }
  }

  Future<List<dynamic>> fetchCountries() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("Could not find the required data");
    }
  }
}
