import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/food_details/domain/entities/meal_entity.dart';
import 'package:fitness_app/features/food_details/domain/use_cases/get_meal_details_use_case.dart';
import 'package:fitness_app/features/food_details/presentation/view_model/food_details_cubit.dart';
import 'package:fitness_app/features/food_details/presentation/view_model/food_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_details_cubit_test.mocks.dart';

@GenerateMocks([GetMealDetailsUseCase])
void main() {
  provideDummy<BaseResponse<MealEntity>>(
    const SuccessBaseResponse<MealEntity>(
      data: MealEntity(idMeal: '', strMeal: ''),
    ),
  );

  late MockGetMealDetailsUseCase mockUseCase;
  late FoodDetailsCubit cubit;

  setUp(() {
    mockUseCase = MockGetMealDetailsUseCase();
    cubit = FoodDetailsCubit(mockUseCase);
  });

  tearDown(() => cubit.close());

  const tId = '52772';
  const tMeal = MealEntity(idMeal: '52772', strMeal: 'Test Meal');

  test('initial state of the cubit should be FoodDetailsState()', () {
    expect(cubit.state, const FoodDetailsState());
  });

  blocTest<FoodDetailsCubit, FoodDetailsState>(
    'emits [loading, success state] when use case returns success',
    build: () {
      when(mockUseCase(tId)).thenAnswer(
        (_) async => const SuccessBaseResponse<MealEntity>(data: tMeal),
      );
      return cubit;
    },
    act: (cubit) => cubit.getMealDetails(tId),
    expect: () => [
      const FoodDetailsState(isLoading: true),
      const FoodDetailsState(data: tMeal),
    ],
    verify: (_) {
      verify(mockUseCase(tId)).called(1);
    },
  );

  blocTest<FoodDetailsCubit, FoodDetailsState>(
    'emits [loading, error state] when use case returns failure',
    build: () {
      when(mockUseCase(tId)).thenAnswer(
        (_) async => const ErrorBaseResponse<MealEntity>(
          errorMessage: 'Something went wrong',
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.getMealDetails(tId),
    expect: () => [
      const FoodDetailsState(isLoading: true),
      const FoodDetailsState(errorMessage: 'Something went wrong'),
    ],
    verify: (_) {
      verify(mockUseCase(tId)).called(1);
    },
  );
}
