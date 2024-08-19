import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_digitalis_event_app/data/api/api_constants.dart';
import 'package:new_digitalis_event_app/model/api_response_model.dart';

Future<ApiResponse> getPub() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(Uri.parse(pubUrl), headers: {
      'Accept': 'application/json',
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        apiResponse.data;
        break;
      case 401:
        apiResponse.message = "Unauthorized";
        break;
      default:
        apiResponse.message = "Something went wrong";
        break;
    }
  } catch (e) {
    apiResponse.message = "Server error: $e";
  }
  return apiResponse;
}