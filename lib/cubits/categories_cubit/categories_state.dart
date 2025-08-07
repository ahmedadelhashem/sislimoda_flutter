part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();
}

final class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

final class CategoriesLoaded extends CategoriesState {
  final List<CategoryModel> categories;

  const CategoriesLoaded({required this.categories});
  @override
  List<Object> get props => [categories];
}

final class CategoriesFailed extends CategoriesState {
  @override
  List<Object> get props => [];
}
