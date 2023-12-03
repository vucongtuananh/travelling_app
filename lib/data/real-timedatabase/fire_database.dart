import 'dart:convert';
import 'package:http/http.dart' as http;

class FireDatabase {
  final String? uid;
  FireDatabase(this.uid);

  postUserFile(String email, String pass) async {
    final uri = Uri.https("travelling-app-7aee1-default-rtdb.firebaseio.com", '$uid.json');
    final response = await http.post(uri,
        // headers: {'Content-type' : 'application.json'}
        body: json.encode({'email': email, 'password': pass}));
    print(response.body);
  }
}
