import 'package:dartz/dartz.dart';
import 'package:foodpedia/common/failure.dart';
import 'package:foodpedia/data/source/remote/food/FoodListResponse.dart';
import 'package:foodpedia/domain/repositories/food_repository.dart';

class GetFoodList {
  final FoodRepository foodRepository;

  GetFoodList(this.foodRepository);

  Future<Either<Failure, FoodListResponse>> execute(String? category) {
    return foodRepository.getFoodList(category);
  }
}
