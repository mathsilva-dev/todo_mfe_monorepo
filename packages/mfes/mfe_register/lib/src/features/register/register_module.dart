import 'package:dependencies/dependencies.dart';
import 'package:mfe_shared/mfe_shared.dart';

import 'presenter/business/register_controller.dart';
import 'presenter/ui/pages/register_page.dart';

class RegisterModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<RegisterController>(
      () => RegisterController(Modular.get<ToDosUsecase>()),
    );
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const RegisterPage());
  }
}
