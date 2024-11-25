import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/photo_repository.dart';
import '../data/model/photo.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository repository;
  final List<String> searchHistory = [];

  PhotoBloc(this.repository) : super(PhotoInitial()) {
    on<SearchPhotos>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = await repository.searchPhotos(event.query);
        if (!searchHistory.contains(event.query)) {
          searchHistory.add(event.query);
        }
        emit(SearchHistoryUpdated(List.from(searchHistory)));
        emit(PhotoLoaded(photos));
      } catch (e) {
        emit(PhotoError('Error al buscar imágenes'));
      }
    });

    on<ClearHistory>((event, emit) {
      searchHistory.clear();
      emit(SearchHistoryUpdated(List.from(searchHistory)));
    });
  }
}

//  Eventos del BLoC  --------------------------------------------------
abstract class PhotoEvent {}

class SearchPhotos extends PhotoEvent {
  final String query;

  SearchPhotos(this.query);
}

class ClearHistory extends PhotoEvent {}

//  Estados del BLoC  --------------------------------------------------
abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<Photo> photos;

  PhotoLoaded(this.photos);
}

class PhotoError extends PhotoState {
  final String message;

  PhotoError(this.message);
}

class SearchHistoryUpdated extends PhotoState {
  final List<String> history;

  SearchHistoryUpdated(this.history);
}
