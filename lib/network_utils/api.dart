import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network{
  final String _url = 'http://surveyqu.com/sqws/sqmid/index.php/auth';
  var token,id;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
    id = jsonDecode(localStorage.getString('id'));
  }

  authData(data, apiUrl) async{
    var fullUrl = _url + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: {
          'Client-Service' : 'surveyqu',
          'Auth-Key' : 'svq1234',
        }
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.post(
        fullUrl,
        body:{
          'id' : id,
        },
        headers: {
          'Client-Service' : 'surveyqu',
          'Auth-Key' : 'svq1234',
          'token' : token,
        }
    );
  }
}