import 'package:flutter/material.dart';
import 'api.dart';
import 'movie.dart';
import 'navbar.dart'; 

class AboutPage extends StatelessWidget {
  final Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/matsuvideo.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3), 
          ),
          Column(
            children: <Widget>[
              NavBar(), 
              SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Now Playing Movies:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: FutureBuilder<List<Movie>>(
                          future: api.getNowPlayingMovies(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError || snapshot.data == null) {
                              return Center(child: Text('Error fetching now playing movies', style: TextStyle(color: Colors.white)));
                            } else {
                              List<Movie> nowPlayingMovies = snapshot.data!;
                              return ListView.builder(
                                itemCount: nowPlayingMovies.length,
                                itemBuilder: (context, index) {
                                  Movie movie = nowPlayingMovies[index];
                                  return ListTile(
                                    leading: Image.network(
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                      width: 50,
                                      height: 75,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(movie.title, style: TextStyle(color: Colors.white)),
                                    subtitle: Text(movie.overview, style: TextStyle(color: Colors.white)),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Upcoming Movies:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: FutureBuilder<List<Movie>>(
                          future: api.getUpcomingMovies(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError || snapshot.data == null) {
                              return Center(child: Text('Error fetching upcoming movies', style: TextStyle(color: Colors.white)));
                            } else {
                              List<Movie> upcomingMovies = snapshot.data!;
                              return ListView.builder(
                                itemCount: upcomingMovies.length,
                                itemBuilder: (context, index) {
                                  Movie movie = upcomingMovies[index];
                                  return ListTile(
                                    leading: Image.network(
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                      width: 50,
                                      height: 75,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(movie.title, style: TextStyle(color: Colors.white)),
                                    subtitle: Text(movie.overview, style: TextStyle(color: Colors.white)),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}