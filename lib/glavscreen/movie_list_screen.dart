import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Movie {
  final String title;
  final String genre;
  final int year;
  final double rating;
  final String imagePath;

  Movie({
    required this.title,
    required this.genre,
    required this.year,
    required this.rating,
    required this.imagePath,
  });
}

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final List<Movie> movies = [
    Movie(
      title: '1+1',
      genre: 'Драма',
      year: 2014,
      rating: 9.6,
      imagePath: 'lib/assets/images/perviy1.jpg',
    ),
    Movie(
      title: 'Интерстеллар',
      genre: 'Фантастика',
      year: 2014,
      rating: 9.5,
      imagePath: 'lib/assets/images/perviy2.jpg',
    ),
    Movie(
      title: 'Побег из Шоушенка',
      genre: 'Драма',
      year: 1994,
      rating: 9.3,
      imagePath: 'lib/assets/images/perviy3.jpg',
    ),
    Movie(
      title: 'Зелёная миля',
      genre: 'Драма',
      year: 1999,
      rating: 9.2,
      imagePath: 'lib/assets/images/perviy4.jpg',
    ),
    Movie(
      title: 'Остров проклятых',
      genre: 'Триллер',
      year: 2010,
      rating: 8.5,
      imagePath: 'lib/assets/images/perviy5.jpg',
    ),
    Movie(
      title: 'Начало',
      genre: 'Фантастика',
      year: 2010,
      rating: 9.0,
      imagePath: 'lib/assets/images/tretiy1.jpg',
    ),
    Movie(
      title: 'Достучаться до небес',
      genre: 'Драма',
      year: 1997,
      rating: 8.7,
      imagePath: 'lib/assets/images/tretiy2.jpg',
    ),
    Movie(
      title: 'Зелёная книга',
      genre: 'Драма',
      year: 2018,
      rating: 9.1,
      imagePath: 'lib/assets/images/tretiy3.jpg',
    ),
    Movie(
      title: 'Криминальное чтиво',
      genre: 'Криминал',
      year: 1994,
      rating: 9.4,
      imagePath: 'lib/assets/images/tretiy4.jpg',
    ),
    Movie(
      title: 'Гладиатор',
      genre: 'Исторический',
      year: 2000,
      rating: 9.2,
      imagePath: 'lib/assets/images/tretiy5.jpg',
    ),
    Movie(
      title: 'Бойцовский клуб',
      genre: 'Драма',
      year: 1999,
      rating: 9.3,
      imagePath: 'lib/assets/images/vtoroy1.jpg',
    ),
    Movie(
      title: 'Форрест Гамп',
      genre: 'Драма',
      year: 1994,
      rating: 9.5,
      imagePath: 'lib/assets/images/vtoroy2.jpg',
    ),
    Movie(
      title: 'Леон',
      genre: 'Драма',
      year: 1994,
      rating: 9.4,
      imagePath: 'lib/assets/images/vtoroy3.jpg',
    ),
    Movie(
      title: 'Джентельмены',
      genre: 'Криминал',
      year: 2019,
      rating: 8.8,
      imagePath: 'lib/assets/images/vtoroy4.jpg',
    ),
    Movie(
      title: 'Терминатор',
      genre: 'Фантастика',
      year: 1984,
      rating: 8.5,
      imagePath: 'lib/assets/images/vtoroy5.jpg',
    ),
  ];

  List<Movie> filteredMovies = [];
  final TextEditingController _searchController = TextEditingController();
  String selectedGenre = '';
  int selectedYear = 0;
  double selectedRating = 0.0;

  @override
  void initState() {
    super.initState();
    filteredMovies = movies;
  }

  void _filterMovies() {
    setState(() {
      filteredMovies = movies.where((movie) {
        bool genreMatch = selectedGenre.isEmpty || movie.genre == selectedGenre;
        bool yearMatch = selectedYear == 0 || movie.year == selectedYear;
        bool ratingMatch = selectedRating == 0.0 || movie.rating >= selectedRating;
        return genreMatch && yearMatch && ratingMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кино список'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'genre') {
                _showGenreDialog();
              } else if (value == 'year') {
                _showYearDialog();
              } else if (value == 'rating') {
                _showRatingDialog();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'genre',
                child: Text('Фильтровать по жанру'),
              ),
              const PopupMenuItem<String>(
                value: 'year',
                child: Text('Фильтровать по году выпуска'),
              ),
              const PopupMenuItem<String>(
                value: 'rating',
                child: Text('Фильтровать по рейтингу'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Color.fromRGBO(255, 238, 0, 1.0)),
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  filteredMovies = movies
                      .where((movie) =>
                          movie.title.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Поиск по названию',
                prefixIcon: Icon(Icons.search, color: Color.fromRGBO(255, 238, 0, 1.0)),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Color.fromRGBO(255, 238, 0, 1.0)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: filteredMovies[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Регистрация',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            _showRegistrationDialog(context);
          }
        },
      ),
    );
  }

  void _showGenreDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите жанр'),
          content: DropdownButton<String>(
            value: selectedGenre,
            onChanged: (value) {
              setState(() {
                selectedGenre = value!;
                _filterMovies();
                Navigator.of(context).pop();
              });
            },
            items: <String>['', 'Драма', 'Фантастика', 'Триллер', 'Криминал', 'Исторический']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showYearDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите год выпуска'),
          content: DropdownButton<int>(
            value: selectedYear == 0 ? null : selectedYear,
            onChanged: (value) {
              setState(() {
                selectedYear = value!;
                _filterMovies();
                Navigator.of(context).pop();
              });
            },
            items: <int>[0, 1984, 1994, 1997, 1999, 2000, 2010, 2014, 2018, 2019]
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value == 0 ? 'Все' : value.toString()),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите минимальный рейтинг'),
          content: DropdownButton<double>(
            value: selectedRating == 0.0 ? null : selectedRating,
            onChanged: (value) {
              setState(() {
                selectedRating = value!;
                _filterMovies();
                Navigator.of(context).pop();
              });
            },
            items: <double>[0.0, 8.0, 8.5, 8.7, 8.8, 9.0, 9.1, 9.2, 9.3, 9.4, 9.5, 9.6]
                .map<DropdownMenuItem<double>>((double value) {
              return DropdownMenuItem<double>(
                value: value,
                child: Text(value == 0.0 ? 'Все' : value.toString()),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showRegistrationDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Регистрация'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Пароль'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Регистрация успешна')),
                  );
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Ошибка регистрации')),
                  );
                }
              },
              child: const Text('Зарегистрироваться'),
            ),
          ],
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              movie.imagePath,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Жанр: ${movie.genre}'),
                  const SizedBox(height: 4.0),
                  Text('Год выпуска: ${movie.year}'),
                  const SizedBox(height: 4.0),
                  Text('Рейтинг: ${movie.rating}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}