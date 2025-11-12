part of 'add_merchandise_bloc.dart';

sealed class AddMerchandiseState extends Equatable {
  const AddMerchandiseState();
  
  @override
  List<Object> get props => [];
}

final class AddMerchandiseInitial extends AddMerchandiseState {}
