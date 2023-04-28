part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {}
class ProductsCheckOutState extends ProductsState {}
class ProductsErrorState extends ProductsState {
  const ProductsErrorState({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
