import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  final double width;
  final double height;
  CardSwiper(
      {@required this.movies, @required this.width, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: width,
        itemHeight: height,
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqueId = "${movies[index].id}-card";
          return Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                    child: FadeInImage(
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.cover,
                        image: NetworkImage(movies[index].getPosterImage())),
                    onTap: () {
                      Navigator.pushNamed(context, "detail",
                          arguments: movies[index]);
                    })),
          );
        },
        itemCount: movies.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
