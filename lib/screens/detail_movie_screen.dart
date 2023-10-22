import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/actor_model.dart';
import 'package:login/models/popular_model.dart';
import 'package:login/network/api_popular.dart';
import 'package:login/provider/test_provider.dart';
import 'package:login/widgets/item_actor_popular.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  final PopularModel model;
  DetailMovieScreen(
      {Key? key, required this.model, required Map<String, dynamic> movieData})
      : super(key: key);

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  final ApiPopular apiPopular = ApiPopular();
  bool isFavorite = false;
  late AgendaDB agendaDB;

  Color getRandomBorderColor() {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];
    return colors[DateTime.now().millisecond % colors.length];
  }

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    initIsFavorite();
  }

  void initIsFavorite() async {
    final favorites = await agendaDB.getAllFavoriteMovies();
    setState(() {
      isFavorite =
          favorites?.any((movie) => movie['movieId'] == widget.model.id) ??
              false;
    });
  }

  void toggleFavorite() async {
    final movieId = widget.model.id;
    if (movieId != null) {
      if (isFavorite) {
        await agendaDB.deleteFavoriteMovie(movieId);
      } else {
        final movieData = {
          'movieId': movieId,
          'title': widget.model.title,
          'posterPath': widget.model.posterPath,
        };
        await agendaDB.insertFavoriteMovie(movieData);
      }

      setState(() {
        isFavorite = !isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TestProvider flag = Provider.of<TestProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL MOVIE'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Hero(
        tag: widget.model.id!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${widget.model.backdropPath}',
                    ),
                    fit: BoxFit.fitHeight,
                    opacity: 0.3,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TyperAnimatedTextKit(
                          isRepeatingAnimation:
                              false, // Set to true for looping animation
                          speed: Duration(milliseconds: 100), // Animation speed
                          text: [widget.model.title.toString()],
                          textStyle: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 200,
                            width: 100,
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${widget.model.posterPath}',
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                RatingBar.builder(
                                  initialRating: widget.model.voteAverage! / 2,
                                  itemCount: 5,
                                  itemSize: 30,
                                  ignoreGestures: true,
                                  itemBuilder: (context, index) {
                                    switch (index) {
                                      case 0:
                                        return Icon(
                                          Icons.sentiment_very_dissatisfied,
                                          color: Colors.red,
                                        );
                                      case 1:
                                        return Icon(
                                          Icons.sentiment_dissatisfied,
                                          color: Colors.redAccent,
                                        );
                                      case 2:
                                        return Icon(
                                          Icons.sentiment_neutral,
                                          color: Colors.amber,
                                        );
                                      case 3:
                                        return Icon(
                                          Icons.sentiment_satisfied,
                                          color: Colors.lightGreen,
                                        );
                                      case 4:
                                        return Icon(
                                          Icons.sentiment_very_satisfied,
                                          color: Colors.green,
                                        );
                                      default:
                                        return Container();
                                    }
                                  },
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Calificación: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                Text(
                                  widget.model.voteAverage.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Movie Description',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.7),
                        ),
                        child: Text(
                          widget.model.overview.toString(),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Watch Movie & Trailers',
                          style: GoogleFonts.lobster(
                            // Usar la fuente de los nombres de los actores
                            textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: apiPopular.getVideo(widget.model.id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: snapshot.data.toString(),
                                flags: const YoutubePlayerFlags(
                                  autoPlay: false,
                                  mute: true,
                                  captionLanguage: AutofillHints.countryName,
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Actores',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder<List<ActorModel>?>(
                        future: apiPopular.getAllActors(widget.model),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  ActorModel actor = snapshot.data![index];
                                  return Container(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: getRandomBorderColor(),
                                              width: 3,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                              actor.profilePath != null
                                                  ? 'https://image.tmdb.org/t/p/original${actor.profilePath}'
                                                  : 'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          actor.name.toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lobster(
                                            // Aplicando Google Fonts a continuación
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
