import 'package:beacon/view_model/home_screen_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<HomeScreenViewModel>(HomeScreenViewModel());
}
