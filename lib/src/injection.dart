import 'package:get_it/get_it.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_detail/pokedex_detail_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_list/pokedex_list_bloc.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_bloc.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_api.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_api_impl.dart';
import 'package:pokedex_sprout/src/utils/dio_client.dart';

final inject = GetIt.instance;
Future<void> initInjection() async {
  inject.registerFactory(() => SplashBloc());
  inject.registerFactory(() => PokedexListBloc());
  inject.registerFactory(() => PokedexDetailBloc());

  // NETWORK
  inject.registerLazySingleton(() => inject<DioClient>().dio);
  inject.registerLazySingleton(
    () => DioClient(baseUrl: 'https://run.mocky.io/').dio,
    instanceName: 'mocky',
  );
  inject.registerLazySingleton(() => DioClient());
  inject.registerLazySingleton<PokedexRepoApi>(
    () => PokedexRepoApiImpl(dio: inject()),
  );
}
