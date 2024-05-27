import 'package:dependencies/dependencies.dart';
import 'package:mfe_shared/mfe_shared.dart';

import 'presenter/business/home_controller.dart';
import 'presenter/ui/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<HomeController>(
      () => HomeController(Modular.get<ToDosUsecase>()),
    );
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
