import '../dto/Pod.dart';
import './OcpService.dart';

class OcpServiceFake extends OcpService {
  @override
  Future<void> deletePod(String? url, String? token, String name) async {}

  @override
  Future<List<Pod>> getPods(String url, String token) async {
    return [
      new Pod(isRunning: true, name: "a", runtime: "java"),
      new Pod(isRunning: true, name: "b", runtime: "java"),
      new Pod(isRunning: true, name: "c", runtime: "java")
    ];
  }

  @override
  Future<String> login(String url, String usr, String pass) async {
    if (url == "a" && usr == "a" && pass == "a")
      return "a";
    else
      return "";
  }
}
