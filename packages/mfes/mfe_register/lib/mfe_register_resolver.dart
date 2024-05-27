import 'package:mfe_core/mfe_core.dart';

import 'src/features/register/register_module.dart';

class MfeRegisterResolver implements Mfe {
  @override
  String get mfeName => 'mfe_register';

  @override
  List<RouteModule> get routes => [
        (module: RegisterModule(), route: Routes.register),
      ];
}
