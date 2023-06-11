import 'package:dartz/dartz.dart';
import 'package:foodpedia/common/failure.dart';
import 'package:foodpedia/data/source/remote/food/FoodDetailResponse.dart';
import 'package:foodpedia/domain/repositories/food_repository.dart';

class GetFoodDetail {
  final FoodRepository foodRepository;

  GetFoodDetail(this.foodRepository);

  Future<Either<Failure, FoodDetailResponse>> execute(String? foodId) {
    return foodRepository.getFoodDetail(foodId);
  }
}
