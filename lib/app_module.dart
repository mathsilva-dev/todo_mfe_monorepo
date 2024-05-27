import 'package:dependencies/dependencies.dart';
import 'package:mfe_core/mfe_core.dart';
import 'package:mfe_home/mfe_home_resolver.dart';
import 'package:mfe_register/mfe_register_resolver.dart';
import 'package:mfe_shared/mfe_shared.dart';

class AppModule extends Module {
  final List<RouteModule> _featureModules = [
    ...MfeHomeResolver().routes,
    ...MfeRegisterResolver().routes,
  ];

  @override
  List<Module> get imports => [
        SharedModule(),
      ];

  @override
  void routes(r) {
    for (RouteModule feature in _featureModules) {
      r.module(feature.route, module: feature.module);
    }
  }
}
