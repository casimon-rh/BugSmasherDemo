import '../dto/Pod.dart';

abstract class OcpService {
  Future<String> login(String url, String usr, String pass);
  Future<List<Pod>> getPods(String url, String token);
  Future<void> deletePod(String url, String token, String name);
}
