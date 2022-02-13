import 'package:flutter/material.dart';

import 'package:movies/controllers/movie_controller.dart';
import 'package:movies/models/movies_model.dart';
import 'package:movies/repositories/movies_repository_impl.dart';
import 'package:movies/service/dio_service_impl.dart';
import 'package:movies/widgets/custom_list_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = MovieController(
    MoviesRepositoryImpl(
      DioServiceImpl(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Movies',
                style: Theme.of(context).textTheme.headline3,
              ),
              ValueListenableBuilder<Movies?>(
                valueListenable: _controller.movies,
                builder: (_, movies, __) {
                  return movies != null
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: movies.listMovies.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (_, index) {
                            return CustomListCardWidget(
                              movie: movies.listMovies[index],
                            );
                          },
                        )
                      : Container(color: Colors.white);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
