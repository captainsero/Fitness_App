import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  const BaseState({this.isLoading = false, this.data, this.errorMessage});

  final bool? isLoading;
  final T? data;
  final String? errorMessage;

  // !Removed Copy With, We Depend on Constractor

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}
