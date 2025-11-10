part of 'owner_add_category_bloc.dart';

abstract class OwnerAddCategoryState extends Equatable {
  const OwnerAddCategoryState();

  @override
  List<Object?> get props => [];
}

class OwnerAddCategoryInitial extends OwnerAddCategoryState {}

class OwnerAddCategoryLoading extends OwnerAddCategoryState {}

class OwnerAddCategorySuccess extends OwnerAddCategoryState {
  final String message;
  const OwnerAddCategorySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class OwnerAddCategoryFailure extends OwnerAddCategoryState {
  final String message;
  const OwnerAddCategoryFailure(this.message);

  @override
  List<Object?> get props => [message];
}
