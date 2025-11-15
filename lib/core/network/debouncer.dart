import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

const debounceDuration = Duration(milliseconds: 400);
const throttleDuration = Duration(milliseconds: 800);

EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) => events.throttle(duration).switchMap(mapper);
}
