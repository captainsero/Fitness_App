import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/food_details/data/data_sources/food_details_remote_data_source_contract.dart';
import 'package:fitness_app/features/food_details/data/models/meal_model.dart';
import 'package:fitness_app/features/food_details/data/models/meals_response_model.dart';
import 'package:fitness_app/features/food_details/data/repo/food_details_repo_impl.dart';
import 'package:fitness_app/features/food_details/domain/entities/meal_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_details_repo_impl_test.mocks.dart';

@GenerateMocks([FoodDetailsRemoteDataSourceContract])
void main() {
  provideDummy<BaseResponse<MealsResponseModel>>(
    const SuccessBaseResponse<MealsResponseModel>(
      data: MealsResponseModel(meals: []),
    ),
  );

  late MockFoodDetailsRemoteDataSourceContract mockRemoteDataSource;
  late FoodDetailsRepoImpl repo;

  setUp(() {
    mockRemoteDataSource = MockFoodDetailsRemoteDataSourceContract();
    repo = FoodDetailsRepoImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tId = '52772';

  group('getMealDetails', () {
    test(
      'should return SuccessBaseResponse<MealEntity> when meals is not empty',
      () async {
        // arrange
        const tMealModel = MealModel(idMeal: '52772', strMeal: 'Test Meal');
        const tResponseModel = MealsResponseModel(meals: [tMealModel]);

        when(mockRemoteDataSource.getMealDetails(tId)).thenAnswer(
          (_) async => const SuccessBaseResponse<MealsResponseModel>(
            data: tResponseModel,
          ),
        );

        // act
        final result = await repo.getMealDetails(tId);

        // assert
        expect(result, isA<SuccessBaseResponse<MealEntity>>());
        verify(mockRemoteDataSource.getMealDetails(tId)).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse with "No meal found" message when meals is empty',
      () async {
        // arrange
        const tResponseModel = MealsResponseModel(meals: []);

        when(mockRemoteDataSource.getMealDetails(tId)).thenAnswer(
          (_) async => const SuccessBaseResponse<MealsResponseModel>(
            data: tResponseModel,
          ),
        );

        // act
        final result = await repo.getMealDetails(tId);

        // assert
        expect(result, isA<ErrorBaseResponse<MealEntity>>());
        expect(
          (result as ErrorBaseResponse<MealEntity>).errorMessage,
          'No meal found',
        );
      },
    );

    test(
      'should return ErrorBaseResponse and forward the same error from the data source',
      () async {
        // arrange
        final tException = Exception('Server error');
        when(mockRemoteDataSource.getMealDetails(tId)).thenAnswer(
          (_) async => ErrorBaseResponse<MealsResponseModel>(error: tException),
        );

        // act
        final result = await repo.getMealDetails(tId);

        // assert
        expect(result, isA<ErrorBaseResponse<MealEntity>>());
        expect((result as ErrorBaseResponse<MealEntity>).error, tException);
      },
    );
  });
}
