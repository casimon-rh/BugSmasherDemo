import 'dart:convert';

import '../dto/Pod.dart';
import './OcpService.dart';
import 'package:http/http.dart';

class OcpServiceRest extends OcpService {
  @override
  Future<void> deletePod(String url, String token, String name) async {
    Map<String, String> headers = {'Authorization': token};
    try {
      await delete(Uri.parse(url + "/$name"), headers: headers);
    } catch (e) {
      print('Caught error: $e');
    }
  }

  @override
  Future<List<Pod>> getPods(String url, String token) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': token
    };
    try {
      Response res = await get(Uri.parse(url), headers: headers);
      if (res.statusCode == 401)
        return [new Pod(isRunning: true, name: "a", runtime: "java")];
      return jsonDecode(res.body);
    } catch (e) {
      print('Caught error: $e');
      return [new Pod(isRunning: true, name: "a", runtime: "java")];
    }
  }

  @override
  Future<String> login(String url, String usr, String pass) async {
    Map<String, String> headers = {'Content-type': 'application/json'};
    String json = '{"user":$usr,"pass":$pass}';
    try {
      Response res = await post(Uri.parse(url), headers: headers, body: json);
      if (res.statusCode != 200) return "";
      return res.body;
    } catch (e) {
      print('Caught error: $e');
      return "";
    }
  }
}
