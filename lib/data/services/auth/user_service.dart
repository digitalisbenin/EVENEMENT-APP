import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:new_digitalis_event_app/data/api/api_constants.dart';
import 'package:new_digitalis_event_app/model/api_response_model.dart';
import 'package:new_digitalis_event_app/model/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

// login
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_digitalis_event_app/model/api_response_model.dart';
import 'package:new_digitalis_event_app/model/profile.dart';

Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(loginUrl),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});
    print("statut du body : ${response.body}");
    print("statut de la réponse : ${response.statusCode}");

    final jsonResponse = jsonDecode(response.body);
    print("jsonResponse : $jsonResponse");

    switch (response.statusCode) {
      case 200:
        if (jsonResponse['access_token'] != null) {
          Profile profile = Profile(token: jsonResponse['access_token']);
          apiResponse.data = profile;
          apiResponse.message = "Connecté avec succès";
        } else {
          apiResponse.message = "Invalid response format";
        }
        break;
      case 422:
        final errors = jsonResponse['errors'];
        apiResponse.message = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.message = jsonResponse['message'];
        break;
      default:
        apiResponse.message = jsonResponse['message'];
        break;
    }
  } catch (e) {
    print("error ::::::::::: $e");
    apiResponse.message = serverError;
  }

  return apiResponse;
}


// register
Future<ApiResponse> register(String fullName,
    String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(registerUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      'name': fullName,
      'email': email,
      'password': password,
      'role_id': '2'
    });
    print('response du body ::: ${response.body}');
    switch (response.statusCode) {
      case 200:
        final jsonResponse = jsonDecode(response.body);
       apiResponse.data = Profile.fromJson(jsonDecode(response.body));
        apiResponse.message = jsonResponse['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.message = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        apiResponse.message = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.message = serverError;
  }
  return apiResponse;
}

// User
Future<ApiResponse> getUser() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(profileUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var jsonData = jsonDecode(response.body);
        apiResponse.data = Profile.fromJson(jsonData);
        break;
      case 401:
        apiResponse.message = unauthorized;
        break;
      default:
        apiResponse.message = somethingWentWrong;
        break;
    }
  } catch (e) {
    print('get user errors ::::: ${e}');
    apiResponse.message = serverError;
  }
  return apiResponse;
}

// get inscription
/*Future<ApiResponse> getInscriptionInfo() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(getInscriptionInfoUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var jsonData = jsonDecode(response.body);
        apiResponse.data = Code.fromJson(jsonData);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print('get user code errors ::::: ${e}');
    apiResponse.error = serverError;
  }
  return apiResponse;
}*/

// get user token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getString("token") ?? '';
}

//get uerId
Future<int> getUserid() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userid') ?? 0;
}

// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove("token");
}
