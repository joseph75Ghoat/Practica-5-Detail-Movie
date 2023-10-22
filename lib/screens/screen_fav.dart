import 'package:flutter/material.dart';
import 'package:login/database/agendadb.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  @override
  _FavoriteMoviesScreenState createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  List<Map<String, dynamic>> favoriteMovies = [];
  List<Map<String, dynamic>> filteredMovies = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteMovies();
  }

  Future<void> _loadFavoriteMovies() async {
    final favorites = await AgendaDB().getAllFavoriteMovies();
    setState(() {
      favoriteMovies = favorites?.map((movie) {
            final title = movie['title'];
            final posterPath = movie['posterPath'];
            return {
              'title': title,
              'posterPath': posterPath,
            };
          })?.toList() ??
          [];

      // Inicializa la lista filtrada con todas las películas favoritas
      filteredMovies = List.from(favoriteMovies);
    });
  }

  void _showMovieDetails(BuildContext context, Map<String, dynamic> movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MovieDetailsScreen(movie: movie);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas Favoritas'),
      ),
      body: filteredMovies.isEmpty
          ? Center(
              child: Text(
                "Por el momento no tienes películas en Favoritos, agrega una :D",
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                return GestureDetector(
                  onTap: () {
                    _showMovieDetails(context, movie);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Hero(
                          tag: 'movie_${movie['title']}',
                          child: Container(
                            width: 150,
                            height: 225,
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${movie['posterPath']}',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            movie['title'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class MovieDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> movie;

  MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'movie_${movie['title']}',
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${movie['posterPath']}',
                width: 300,
                height: 450,
              ),
            ),
            SizedBox(height: 20),
            Text(
              movie['title'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//vamos por 21 de /20