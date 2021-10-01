import '../dto/Pod.dart';
import './OcpService.dart';

class OcpServiceFake extends OcpService {
  @override
  Future<void> deletePod(String url, String token, String name) async {}

  @override
  Future<List<Pod>> getPods(String url, String token) async {
    return new List<Pod>.empty();
  }

  @override
  Future<String> login(String url, String usr, String pass) async {
    if (url == "a" && usr == "a" && pass == "a")
      return "a";
    else
      return "";
  }
}
