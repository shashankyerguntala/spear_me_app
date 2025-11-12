part of 'tools_bloc.dart';

abstract class ToolsEvent extends Equatable {
  const ToolsEvent();

  @override
  List<Object?> get props => [];
}

class FetchToolCategories extends ToolsEvent {}

class FetchTools extends ToolsEvent {
  final String categoryName;
  const FetchTools({required this.categoryName});

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
  const SortTools({required this.sortBy, this.sortDir = "desc"});

  @override
  List<Object?> get props => [sortBy, sortDir];
}

class FilterTools extends ToolsEvent {
  final String filter;
  const FilterTools(this.filter);

  @override
  List<Object?> get props => [filter];
}

class LoadMoreTools extends ToolsEvent {}
