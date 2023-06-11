import 'package:foodpedia/data/repositories/food_repository_impl.dart';
import 'package:foodpedia/domain/repositories/food_repository.dart';
import 'package:foodpedia/domain/use_case/food/get_food_category.dart';
import 'package:foodpedia/domain/use_case/food/get_food_detail.dart';
import 'package:foodpedia/domain/use_case/food/get_food_list.dart';
import 'package:foodpedia/presentation/food_detail/bloc/food_detail_bloc.dart';
import 'package:foodpedia/presentation/home/bloc/food/food_bloc.dart';
import 'package:foodpedia/presentation/home/bloc/homepage/homepage_bloc.dart';
import 'package:foodpedia/presentation/home/bottom_sheet_category/bloc/bts_category_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

void init() {
  initRepository();
  initUseCase();
  initBloc();

  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton(() => Logger());
}

void initRepository() {
  getIt.registerLazySingleton<FoodRepository>(
    () => FoodRepositoryImpl(client: getIt.get<http.Client>()),
  );
}

void initUseCase() {
  getIt.registerLazySingleton(
    () => GetFoodCategory(
      getIt.get<FoodRepository>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetFoodList(
      getIt.get<FoodRepository>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetFoodDetail(
      getIt.get<FoodRepository>(),
    ),
  );
}

void initBloc() {
  getIt.registerFactory(
    () => HomepageBloc(),
  );

  getIt.registerFactory(
    () => BtsCategoryBloc(
      getFoodCategory: getIt.get<GetFoodCategory>(),
    ),
  );

  getIt.registerFactory(
    () => FoodBloc(
      getFoodList: getIt.get<GetFoodList>(),
    ),
  );

  getIt.registerFactory(
    () => FoodDetailBloc(
      getFoodDetail: getIt.get<GetFoodDetail>(),
    ),
  );
}
