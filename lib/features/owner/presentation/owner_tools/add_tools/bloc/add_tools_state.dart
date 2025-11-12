part of 'add_tools_bloc.dart';

class AddToolsState extends Equatable {
  final bool isLoadingCategories;
  final bool isSubmitting;
  final List<ToolCategoryEntity> categories;
  final String? errorMessage;
  final String? successMessage;

  const AddToolsState({
    this.isLoadingCategories = false,
    this.isSubmitting = false,
    this.categories = const [],
    this.errorMessage,
    this.successMessage,
  });

  AddToolsState copyWith({
    bool? isLoadingCategories,
    bool? isSubmitting,
    List<ToolCategoryEntity>? categories,
    String? errorMessage,
    String? successMessage,
  }) {
    return AddToolsState(
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      categories: categories ?? this.categories,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingCategories,
    isSubmitting,
    categories,
    errorMessage,
    successMessage,
  ];
}
