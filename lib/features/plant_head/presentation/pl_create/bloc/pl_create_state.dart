part of 'pl_create_bloc.dart';

abstract class PlCreateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlCreateLoading extends PlCreateState {}

class PlCreateSuccess extends PlCreateState {
  final String msg;

  PlCreateSuccess({required this.msg});
}

class PlCreateLoaded extends PlCreateState {
  final List<BayEntity> bays;
  final String selectedRole;
  final int? selectedBayId;
  final String? message;

  PlCreateLoaded({
    required this.bays,
    required this.selectedRole,
    this.selectedBayId,
    this.message,
  });

  PlCreateLoaded copyWith({
    List<BayEntity>? bays,
    String? selectedRole,
    int? selectedBayId,
    String? message,
  }) {
    return PlCreateLoaded(
      bays: bays ?? this.bays,
      selectedRole: selectedRole ?? this.selectedRole,
      selectedBayId: selectedBayId ?? this.selectedBayId,
      message: message,
    );
  }
}

class PlCreateFailure extends PlCreateState {
  final String message;
  PlCreateFailure(this.message);

  @override
  List<Object?> get props => [message];
}
