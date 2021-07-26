import 'package:dio/dio.dart';
import 'base_network.dart';



class LoginManager {
  Future<dynamic> createLoginToken(Map<String, dynamic> data) async {
    FormData formData = FormData.fromMap(data);
    Response response = await dioClient.ref.get("https://api.github.com",);

    if (response?.statusCode == 200) {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      // here the issuw is with the if statement
      // in the response we dont have a key named status  so that is the reason
      // response.data['status'] returned null when comparing this kind of dynamic data its better to user == true
      // Okay?
      print(response.data);

    }
  }
}

final loginManager = LoginManager();
