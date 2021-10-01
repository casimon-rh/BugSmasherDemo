import 'package:smasher/service/OcpServiceFake.dart';

import 'OcpService.dart';
import 'OcpServiceRest.dart';
import 'OcpServiceFake.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerLazySingleton<OcpService>(() => OcpServiceFake());
  // getIt.registerLazySingleton<OcpService>(() => OcpServiceRest());
}
