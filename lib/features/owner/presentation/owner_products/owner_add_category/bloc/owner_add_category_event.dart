part of 'owner_add_category_bloc.dart';

abstract class OwnerAddCategoryEvent extends Equatable {
  const OwnerAddCategoryEvent();

  @override
  List<Object?> get props => [];
}

class AddCategoryRequested extends OwnerAddCategoryEvent {
  final String categoryName;
  final String description;

  const AddCategoryRequested({
    required this.categoryName,
    required this.description,
  });

  @override
  List<Object?> get props => [categoryName, description];
}
