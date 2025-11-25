part of 'tools_bloc.dart';

abstract class ToolsEvent extends Equatable {
  const ToolsEvent();

  @override
  List<Object?> get props => [];
}

class FetchToolCategories extends ToolsEvent {}

class FetchTools extends ToolsEvent {
  final String? categoryName;

  const FetchTools({this.categoryName});

  @override
  List<Object?> get props => [categoryName];
}

class SearchTools extends ToolsEvent {
  final String query;

  const SearchTools(this.query);

  @override
  List<Object?> get props => [query];
}

class SortTools extends ToolsEvent {
  final String sortBy;
  final String sortDir;

  const SortTools({required this.sortBy, required this.sortDir});

  @override
  List<Object?> get props => [sortBy, sortDir];
}

class FilterTools extends ToolsEvent {
  final String filter;

  const FilterTools(this.filter);

  @override
  List<Object?> get props => [filter];
}

class FilterByCategory extends ToolsEvent {
  final String? categoryName;

  const FilterByCategory(this.categoryName);

  @override
  List<Object?> get props => [categoryName];
}

class LoadMoreTools extends ToolsEvent {}

class EditToolEvent extends ToolsEvent {
  final ToolEntity tool;

  const EditToolEvent(this.tool);

  @override
  List<Object?> get props => [tool];
}

class AddCategoryEvent extends ToolsEvent {
  final String name;
  final String description;

  const AddCategoryEvent({required this.name, required this.description});

  @override
  List<Object?> get props => [name, description];
}

class UpdateCategoryEvent extends ToolsEvent {
  final int id;
  final String name;
  final String description;

  const UpdateCategoryEvent({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, description];
}

class DeleteCategoryEvent extends ToolsEvent {
  final int categoryId;

  const DeleteCategoryEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
