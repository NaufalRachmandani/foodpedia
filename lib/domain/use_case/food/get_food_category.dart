import 'package:dartz/dartz.dart';
import 'package:foodpedia/common/failure.dart';
import 'package:foodpedia/data/source/remote/food/food_category_response.dart';
import 'package:foodpedia/domain/repositories/food_repository.dart';

class GetFoodCategory {
  final FoodRepository foodRepository;

  GetFoodCategory(this.foodRepository);

  Future<Either<Failure, FoodCategoryResponse>> execute() {
    return foodRepository.getFoodCategory();
  }
}
