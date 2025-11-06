part of 'add_central_office_bloc.dart';

sealed class AddCentralOfficeState extends Equatable {
  const AddCentralOfficeState();
  
  @override
  List<Object> get props => [];
}

final class AddCentralOfficeInitial extends AddCentralOfficeState {}
