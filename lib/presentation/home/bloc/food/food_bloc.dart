import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodpedia/data/source/remote/food/food_list_response.dart';
import 'package:foodpedia/domain/use_case/food/get_food_list.dart';

part 'food_event.dart';

part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetFoodList getFoodList;

  FoodBloc({required this.getFoodList}) : super(FoodInitialState()) {
    on<GetFoodListEvent>(_getFoodList);
  }

  void _getFoodList(GetFoodListEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoadingState());
    final result = await getFoodList.execute(event.category);

    await result.fold(
      (failure) async {
        emit(FoodErrorState());
      },
      (response) async {
        emit(FoodLoadedState(foodListResponse: response),);
      },
    );
  }
}
