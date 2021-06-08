import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network{
  final String _urlauth = 'http://surveyqu.com/sqws/sqmid/index.php/auth';
  var token,id;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
    id = jsonDecode(localStorage.getString('id'));
  }

  postDataAuth(data, apiUrl) async{
    var fullUrl = _urlauth + apiUrl;
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: {
          'Client-Service' : 'surveyqu',
          'Auth-Key' : 'svq1234',
        }
    );
  }

  postDataId(apiUrl) async {
    var fullUrl = _urlauth + apiUrl;
    await _getToken();
    return await http.post(
        Uri.parse(fullUrl),
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

  postToken(apiUrl) async {
    var fullUrl = _urlauth + apiUrl;
    await _getToken();
    return await http.post(
      Uri.parse(fullUrl),
      headers: {
        'Client-Service' : 'surveyqu',
        'Auth-Key' : 'svq1234',
        'token' : token,
      },
    );
  }

  postDataToken(data, apiUrl) async {
    var fullUrl = _urlauth + apiUrl;
    await _getToken();
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: {
        'Client-Service' : 'surveyqu',
        'Auth-Key' : 'svq1234',
        'token' : token,
      },
    );
  }
}