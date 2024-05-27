import 'package:mfe_core/mfe_core.dart';

import 'src/features/home/home_module.dart';

class MfeHomeResolver implements Mfe {
  @override
  String get mfeName => 'mfe_home';

  @override
  List<RouteModule> get routes => [
        (module: HomeModule(), route: Routes.home),
      ];
}
