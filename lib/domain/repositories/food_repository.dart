import 'package:dartz/dartz.dart';
import 'package:foodpedia/common/failure.dart';
import 'package:foodpedia/data/source/remote/food/food_category_response.dart';
import 'package:foodpedia/data/source/remote/food/FoodDetailResponse.dart';
import 'package:foodpedia/data/source/remote/food/FoodListResponse.dart';

abstract class FoodRepository {
  Future<Either<Failure, FoodCategoryResponse>> getFoodCategory();

  Future<Either<Failure, FoodListResponse>> getFoodList(String? category);

  Future<Either<Failure, FoodDetailResponse>> getFoodDetail(String? foodId);
}
