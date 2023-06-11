import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodpedia/data/source/remote/food/FoodDetailResponse.dart';
import 'package:foodpedia/domain/use_case/food/get_food_detail.dart';

part 'food_detail_event.dart';
part 'food_detail_state.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  final GetFoodDetail getFoodDetail;

  FoodDetailBloc({required this.getFoodDetail})
      : super(FoodDetailLoadingState()) {
    on<GetFoodDetailEvent>(_getFoodList);
  }

  void _getFoodList(
      GetFoodDetailEvent event, Emitter<FoodDetailState> emit) async {
    final result = await getFoodDetail.execute(event.foodId);

    await result.fold(
      (failure) async {
        emit(FoodDetailErrorState());
      },
      (response) async {
        emit(FoodDetailLoadedState(foodDetailResponse: response));
      },
    );
  }
}
