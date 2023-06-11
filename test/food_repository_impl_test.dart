import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodpedia/common/base_url.dart';
import 'package:foodpedia/common/failure.dart';
import 'package:foodpedia/data/repositories/food_repository_impl.dart';
import 'package:foodpedia/data/source/remote/food/food_category_response.dart';
import 'package:foodpedia/data/source/remote/food/food_detail_response.dart';
import 'package:foodpedia/data/source/remote/food/food_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_repository_impl_test.mocks.dart';
import 'json_reader.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient client;
  late FoodRepositoryImpl foodRepositoryImpl;

  setUp(() {
    client = MockClient();
    foodRepositoryImpl = FoodRepositoryImpl(client: client);
  });

  group("Get Food Category", () {
    var uri = Uri.parse("$urlStaging/list.php?c=list");
    const String filePath = "/dummy_data/food_category_response.json";

    var jsonData = jsonDecode(readFile(filePath));
    final expectedFoodCategoryResponse =
        FoodCategoryResponse.fromJson(jsonData);

    test("should return food category", () async {
      when(client.get(uri)).thenAnswer((_) async {
        return http.Response(
          readFile(filePath),
          200,
        );
      });

      final result = await foodRepositoryImpl.getFoodCategory();
      var actual;
      result.fold((failure) {
        actual = failure;
      }, (response) {
        actual = response;
      });

      expect(actual, equals(expectedFoodCategoryResponse));
    });

    test("should return ServerFailure", () async {
      when(client.get(uri)).thenAnswer((_) async {
        return http.Response(
          "",
          500,
        );
      });

      final result = await foodRepositoryImpl.getFoodCategory();
      var actual;
      result.fold((failure) {
        actual = failure;
      }, (response) {
        actual = response;
      });

      expect(actual, equals(ServerFailure('')));
    });
  });

  group("Get Food List", () {
    var uri = Uri.parse("$urlStaging/filter.php?c=Beef");
    const String filePath = "/dummy_data/food_list_response.json";
    var jsonData = jsonDecode(readFile(filePath));
    final expected = FoodListResponse.fromJson(jsonData);

    test("should return food list", () async {
      when(foodRepositoryImpl.getFoodList("Beef")).thenAnswer((_) async {
        Either<Failure, FoodListResponse> either = Right(expected);
        Future<Either<Failure, FoodListResponse>> response = Future.value(either);
        return response;
      });

      final result = await foodRepositoryImpl.getFoodList("Beef");
      var actual;
      result.fold((failure) {
        actual = expected;
      }, (response) {
        actual = response;
      });

      expect(actual, equals(expected));
    });

    test("should return ServerFailure", () async {
      when(client.get(uri)).thenAnswer((_) async {
        return http.Response(
          "",
          500,
        );
      });

      final result = await foodRepositoryImpl.getFoodList("Beef");
      var actual;
      result.fold((failure) {
        actual = failure;
      }, (response) {
        actual = response;
      });

      expect(actual, equals(ServerFailure('')));
    });
  });

  group("Get Food Detail", () {
    var uri = Uri.parse("$urlStaging/lookup.php?i=52772");
    const String filePath = "/dummy_data/food_detail_response.json";

    var jsonData = jsonDecode(readFile(filePath));
    final expected = FoodDetailResponse.fromJson(jsonData);

    test("should return food detail", () async {
      when(client.get(uri)).thenAnswer((_) async {
        return http.Response(
          readFile(filePath),
          200,
        );
      });

      final result = await foodRepositoryImpl.getFoodDetail("52772");
      var actual;
      result.fold((failure) {
        actual = failure;
      }, (response) {
        actual = response;
      });

      expect(actual, equals(expected));
    });

    test("should return ServerFailure", () async {
      when(client.get(uri)).thenAnswer((_) async {
        return http.Response(
          "",
          500,
        );
      });

      final result = await foodRepositoryImpl.getFoodDetail("52772");
      var actual;
      result.fold((failure) {
        actual = failure;
      }, (response) {
        actual = response;
      });

      expect(actual, equals(ServerFailure('')));
    });
  });
}
