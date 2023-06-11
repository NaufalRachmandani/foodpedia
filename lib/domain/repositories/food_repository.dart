import 'package:dartz/dartz.dart';
import 'package:foodpedia/common/failure.dart';
import 'package:foodpedia/data/source/remote/food/food_category_response.dart';
import 'package:foodpedia/data/source/remote/food/food_detail_response.dart';
import 'package:foodpedia/data/source/remote/food/food_list_response.dart';

abstract class FoodRepository {
  Future<Either<Failure, FoodCategoryResponse>> getFoodCategory();

  Future<Either<Failure, FoodListResponse>> getFoodList(String? category);

  Future<Either<Failure, FoodDetailResponse>> getFoodDetail(String? foodId);
}
