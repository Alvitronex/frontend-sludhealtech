import 'package:flutter/material.dart';

class SugerenteMedicine extends StatelessWidget {
  final Widget child;
  const SugerenteMedicine({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _CardBox(),
          child,
        ],
      ),
    );
  }
}

class _CardBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(child: _CardView()),
          Positioned(child: _CardView()),
          Positioned(child: _CardView()),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 63, 93, 210),
          Color.fromARGB(255, 48, 207, 235),
        ]),
      );
}

class _CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("data"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
