import 'package:equatable/equatable.dart';

class FoodCategoryResponse extends Equatable {
  List<Meals>? meals;

  FoodCategoryResponse({this.meals});

  FoodCategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(new Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [meals];
}

class Meals extends Equatable {
  String? strCategory;

  Meals({this.strCategory});

  Meals.fromJson(Map<String, dynamic> json) {
    strCategory = json['strCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCategory'] = this.strCategory;
    return data;
  }

  @override
  List<Object?> get props => [strCategory];
}
