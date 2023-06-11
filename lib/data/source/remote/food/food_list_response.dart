import 'package:equatable/equatable.dart';

class FoodListResponse extends Equatable {
  FoodListResponse({
    this.meals,
  });

  FoodListResponse.fromJson(dynamic json) {
    if (json['meals'] != null) {
      meals = [];
      json['meals'].forEach((v) {
        meals?.add(Meals.fromJson(v));
      });
    }
  }

  List<Meals>? meals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (meals != null) {
      map['meals'] = meals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  List<Object?> get props => [meals];
}

class Meals extends Equatable {
  Meals({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  Meals.fromJson(dynamic json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }

  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strMeal'] = strMeal;
    map['strMealThumb'] = strMealThumb;
    map['idMeal'] = idMeal;
    return map;
  }

  @override
  List<Object?> get props => [idMeal];
}
