import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_digitalis_event_app/data/api/api_constants.dart';
import 'package:new_digitalis_event_app/data/services/auth/user_service.dart';
import 'package:new_digitalis_event_app/model/api_response_model.dart';

Future<ApiResponse> sendComment(String content, String eventId) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    int userID = await getUserid();
    final response = await http.post(Uri.parse(sendCommentUrl), body: {
      'content': content,
      'user_id': userID.toString(),
      'demande_id': eventId
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