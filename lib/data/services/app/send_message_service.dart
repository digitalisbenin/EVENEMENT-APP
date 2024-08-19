import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_digitalis_event_app/data/api/api_constants.dart';
import 'package:new_digitalis_event_app/model/api_response_model.dart';

Future<ApiResponse> sendMessage(String userName, String email, String message) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(sendMessageUrl), body: {
      'name': userName,
      'email': email,
      'message': message,
    }, headers: {
      'Accept': 'application/json',
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.message = jsonDecode(response.body)['message'];
        break;
      case 422:
        final messages = jsonDecode(response.body)['messages'];
        apiResponse.message = messages[messages.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.message = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.message = jsonDecode(response.body)['message'];
        break;
    }
  } catch (e) {
    print("caatch message ::: $e");
    apiResponse.message = serverError;
  }
  return apiResponse;
}