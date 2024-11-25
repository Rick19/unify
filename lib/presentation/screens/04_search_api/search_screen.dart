import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../bloc/photo_bloc.dart';
import '../../../data/model/photo.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final photoBloc = BlocProvider.of<PhotoBloc>(context);
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Búsqueda de Imágenes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Buscar',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: searchController.clear,
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      photoBloc.add(SearchPhotos(value));
                    }
                  },
                ),
                BlocBuilder<PhotoBloc, PhotoState>(
                  builder: (context, state) {
                    if (state is SearchHistoryUpdated) {
                      return Wrap(
                        children: state.history
                            .map((query) => InputChip(
                                  label: Text(query),
                                  onDeleted: () {
                                    photoBloc.add(ClearHistory());
                                  },
                                  onPressed: () {
                                    searchController.text = query;
                                    photoBloc.add(SearchPhotos(query));
                                  },
                                ))
                            .toList(),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<PhotoBloc, PhotoState>(
              builder: (context, state) {
                if (state is SearchHistoryUpdated) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PhotoLoaded) {
                  return MasonryGridView.builder(
                      //  Se usa una libreria externa para aprovechar los espacios
                      padding: EdgeInsets.all(8),
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      itemCount: state.photos.length, //  Para manejo dinámico
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final photo = state.photos[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      FullPhotoScreen(photo),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Hero(
                                tag: photo.title,
                                child: Image.network(
                                  photo.thumbnailUrl,
                                  fit: BoxFit.fill,
                                ),
                              )),
                        );
                      });
                } else if (state is PhotoError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('Busca imágenes'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FullPhotoScreen extends StatelessWidget {
  final Photo photo;

  FullPhotoScreen(this.photo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
      ),
      body: Hero(
        tag: photo.title,
        child: Image.network( //  Faltó mejorar el efecto al mostrar con un shimeer
          photo.fullImageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
