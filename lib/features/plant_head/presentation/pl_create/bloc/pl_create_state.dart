part of 'pl_create_bloc.dart';

sealed class PlCreateState extends Equatable {
  const PlCreateState();

  @override
  List<Object?> get props => [];
}

class PlCreateDataState extends PlCreateState {
  final bool isLoading;
  final List<BayEntity> bays;
  final String selectedRole;
  final int? selectedBayId;

  const PlCreateDataState({
    this.isLoading = false,
    this.bays = const [],
    this.selectedRole = "CHIEF_SUPERVISOR",
    this.selectedBayId,
  });

  PlCreateDataState copyWith({
    bool? isLoading,
    List<BayEntity>? bays,
    String? selectedRole,
    int? selectedBayId,
  }) {
    return PlCreateDataState(
      isLoading: isLoading ?? this.isLoading,
      bays: bays ?? this.bays,
      selectedRole: selectedRole ?? this.selectedRole,
      selectedBayId: selectedBayId ?? this.selectedBayId,
    );
  }

  @override
  List<Object?> get props => [isLoading, bays, selectedRole, selectedBayId];
}

class PlCreateSuccess extends PlCreateState {
  final String message;
  const PlCreateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PlCreateFailure extends PlCreateState {
  final String message;
  const PlCreateFailure(this.message);

  @override
  List<Object?> get props => [message];
}
