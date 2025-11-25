part of 'add_tools_bloc.dart';

abstract class AddToolsEvent extends Equatable {
  const AddToolsEvent();

  @override
  List<Object?> get props => [];
}

class FetchToolCategories extends AddToolsEvent {}

class CreateTool extends AddToolsEvent {
  final String name;
  final int categoryId;
  final String type;
  final String isExpensive;
  final int threshold;

  const CreateTool({
    required this.name,
    required this.categoryId,
    required this.type,
    required this.isExpensive,
    required this.threshold,
  });

  @override
  List<Object?> get props => [name, categoryId, type, isExpensive, threshold];
}

class UpdateTool extends AddToolsEvent {
  final int toolId;
  final String name;
  final int categoryId;
  final String toolType;
  final String isExpensive;
  final int threshold;

  const UpdateTool({
    required this.toolId,
    required this.name,
    required this.categoryId,
    required this.toolType,
    required this.isExpensive,
    required this.threshold,
  });

  @override
  List<Object?> get props => [
    toolId,
    name,
    categoryId,
    toolType,
    isExpensive,
    threshold,
  ];
}
