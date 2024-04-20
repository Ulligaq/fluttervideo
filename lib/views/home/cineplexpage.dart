import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navbar.dart'; // Import your NavBar widget

class CineplexPage extends StatefulWidget {
  @override
  _CineplexPageState createState() => _CineplexPageState();
}

class _CineplexPageState extends State<CineplexPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _movieController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  late FirebaseFirestore _firestore;
  late CollectionReference _moviesCollection;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _moviesCollection = _firestore.collection('movietime');
  }

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white.withOpacity(0.7), 
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white.withOpacity(0.7), 
                  child: TextField(
                    controller: _movieController,
                    decoration: InputDecoration(
                      labelText: 'Movie',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white.withOpacity(0.7), 
                  child: TextField(
                    controller: _timeController,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _addMovie,
                    child: Text('Add Movie'),
                  ),
                  ElevatedButton(
                    onPressed: _getAllMovies,
                    child: Text('Get All Movies'),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _moviesCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final movies = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Card(
                          color: Colors.white.withOpacity(0.7), 
                          child: ListTile(
                            title: Text(movie['Date']),
                            subtitle: Text('${movie['Movie']} at ${movie['Time']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteMovie(movie.id),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addMovie() async {
    final date = _dateController.text.trim();
    final movie = _movieController.text.trim();
    final time = _timeController.text.trim();

    if (date.isNotEmpty && movie.isNotEmpty && time.isNotEmpty) {
      await _moviesCollection.add({
        'Date': date,
        'Movie': movie,
        'Time': time,
      });

      _dateController.clear();
      _movieController.clear();
      _timeController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter Date, Movie, and Time.'),
      ));
    }
  }

  void _getAllMovies() async {
    final movies = await _moviesCollection.get();
    movies.docs.forEach((movie) {
      print('Date: ${movie['Date']}, Movie: ${movie['Movie']}, Time: ${movie['Time']}');
    });
  }

  void _deleteMovie(String docId) async {
    await _moviesCollection.doc(docId).delete();
  }
}