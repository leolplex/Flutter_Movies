import 'package:flutter/material.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Movies at cinemas'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[_swipeCards()],
          ),
        ));
  }

  Widget _swipeCards() {
    return CardSwiper(
      movies: [1, 2, 3, 4, 5],
    );
  }
}
