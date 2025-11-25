part of 'request_bloc.dart';

abstract class RequestEvent extends Equatable {
  const RequestEvent();

  @override
  List<Object?> get props => [];
}

class FetchToolRequests extends RequestEvent {
  const FetchToolRequests();
}

class FetchRestockRequests extends RequestEvent {
  const FetchRestockRequests();
}

class SearchToolRequests extends RequestEvent {
  final String query;

  const SearchToolRequests(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchRestockRequests extends RequestEvent {
  final String query;

  const SearchRestockRequests(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterToolRequests extends RequestEvent {
  final String? status;

  const FilterToolRequests(this.status);

  @override
  List<Object?> get props => [status];
}

class FilterRestockRequests extends RequestEvent {
  final String? status;

  const FilterRestockRequests(this.status);

  @override
  List<Object?> get props => [status];
}

class SortToolRequests extends RequestEvent {
  final String sortBy;
  final String sortDir;

  const SortToolRequests({required this.sortBy, required this.sortDir});

  @override
  List<Object?> get props => [sortBy, sortDir];
}

class SortRestockRequests extends RequestEvent {
  final String sortBy;
  final String sortDir;

  const SortRestockRequests({required this.sortBy, required this.sortDir});

  @override
  List<Object?> get props => [sortBy, sortDir];
}

class LoadMoreToolRequests extends RequestEvent {
  const LoadMoreToolRequests();
}

class LoadMoreRestockRequests extends RequestEvent {
  const LoadMoreRestockRequests();
}

class ApproveToolRequest extends RequestEvent {
  final int requestId;

  const ApproveToolRequest(this.requestId);

  @override
  List<Object?> get props => [requestId];
}

class RejectToolRequest extends RequestEvent {
  final int requestId;
  final String reason;

  const RejectToolRequest(this.requestId, this.reason);

  @override
  List<Object?> get props => [requestId, reason];
}

class CompleteRestockRequest extends RequestEvent {
  final int requestId;

  const CompleteRestockRequest(this.requestId);

  @override
  List<Object?> get props => [requestId];
}
