part of 'add_merchandise_bloc.dart';

class AddMerchandiseState extends Equatable {
  final File? image;
  final bool isLoading;
  final String? error;
  final String? success;

  const AddMerchandiseState({
    this.image,
    this.isLoading = false,
    this.error,
    this.success,
  });

  AddMerchandiseState copyWith({
    File? image,
    bool? isLoading,
    String? error,
    String? success,
  }) {
    return AddMerchandiseState(
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success,
    );
  }

  @override
  List<Object?> get props => [image, isLoading, error, success];
}

class AddMerchandiseInitial extends AddMerchandiseState {
  const AddMerchandiseInitial() : super();
}
