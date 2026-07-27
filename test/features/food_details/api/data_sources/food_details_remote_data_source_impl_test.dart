import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/food_details/api/api_client/food_details_api_client.dart';
import 'package:fitness_app/features/food_details/api/data_sources/food_details_remote_data_source_impl.dart';
import 'package:fitness_app/features/food_details/data/models/meals_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_details_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([FoodDetailsApiClient])
void main() {
  late MockFoodDetailsApiClient mockApiClient;
  late FoodDetailsRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockFoodDetailsApiClient();
    dataSource = FoodDetailsRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  const tId = '52772';
  const tMealsResponseModel = MealsResponseModel(meals: []);

  group('getMealDetails', () {
    test(
      'should return SuccessBaseResponse when apiClient returns data successfully',
      () async {
        // arrange
        when(
          mockApiClient.getMealDetails(tId),
        ).thenAnswer((_) async => tMealsResponseModel);

        // act
        final result = await dataSource.getMealDetails(tId);

        // assert
        expect(result, isA<SuccessBaseResponse<MealsResponseModel>>());
        final success = result as SuccessBaseResponse<MealsResponseModel>;
        expect(success.data, tMealsResponseModel);
        verify(mockApiClient.getMealDetails(tId)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return ErrorBaseResponse when apiClient throws an Exception',
      () async {
        // arrange
        final tException = Exception('Network error');
        when(mockApiClient.getMealDetails(tId)).thenThrow(tException);

        // act
        final result = await dataSource.getMealDetails(tId);

        // assert
        expect(result, isA<ErrorBaseResponse<MealsResponseModel>>());
        final error = result as ErrorBaseResponse<MealsResponseModel>;
        expect(error.error, tException);
        verify(mockApiClient.getMealDetails(tId)).called(1);
      },
    );
  });
}
