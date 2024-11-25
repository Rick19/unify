import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/photo.dart';

class PhotoRepository {
  final String apiKey = '7YliIjhnaumSHh_yIQq0EEDX6jo3NG0rWUaJjuPjq64';  // Se pretende no mostrarla en prod, se solicitaría la primera vez que se inicie la app
  final String baseUrl = 'https://api.unsplash.com/search/photos';

  Future<List<Photo>> searchPhotos(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl?query=$query'),
      headers: {
        'Authorization': 'Client-ID $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      //  Recupera los primeros diez, habrá que modificar para paginar
      return (data['results'] as List)
          .map((photo) => Photo.fromJson(photo))
          .toList();
    } else {
      throw Exception('Error al cargar imágenes');
    }
  }
}
