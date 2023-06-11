import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:foodpedia/common/base_url.dart';
import 'package:foodpedia/common/failure.dart';
import 'package:foodpedia/data/source/remote/food/FoodDetailResponse.dart';
import 'package:foodpedia/data/source/remote/food/FoodListResponse.dart';
import 'package:foodpedia/data/source/remote/food/food_category_response.dart';
import 'package:foodpedia/domain/repositories/food_repository.dart';
import 'package:http/http.dart' as http;

class FoodRepositoryImpl extends FoodRepository {
  final http.Client client;

  FoodRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, FoodCategoryResponse>> getFoodCategory() async {
    try {
      var uri = Uri.parse("$urlStaging/list.php?c=list");
      final response = await client.get(uri);

      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);

      return Right(FoodCategoryResponse.fromJson(jsonData));
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, FoodListResponse>> getFoodList(
      String? category) async {
    try {
      var uri = Uri.parse("$urlStaging/filter.php?c=$category");
      final response = await client.get(uri);

      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);

      return Right(FoodListResponse.fromJson(jsonData));
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, FoodDetailResponse>> getFoodDetail(
      String? foodId) async {
    try {
      var uri = Uri.parse("$urlStaging/lookup.php?i=$foodId");
      final response = await client.get(uri);

      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);

      return Right(FoodDetailResponse.fromJson(jsonData));
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }
}
