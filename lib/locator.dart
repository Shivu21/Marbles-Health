import 'package:get_it/get_it.dart';
import 'form_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FormModel());
}
