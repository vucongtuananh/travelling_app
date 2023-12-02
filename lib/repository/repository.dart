import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  final uri = Uri.https("travelling-app-7aee1-default-rtdb.firebaseio.com", 'travel-user.json');
  registerUser(String name, String email, String pass) async {
    final response = await http.post(uri,
        // headers: {'Content-type' : 'application.json'}
        body: json.encode({'name': name, 'email': email, 'password': pass}));
    print(response.body);
  }
}
