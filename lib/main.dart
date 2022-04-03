import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tiles = List.filled(9, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isWinning(1, tiles)
                  ? 'You Won !!'
                  : isWinning(2, tiles)
                      ? 'You lost !!'
                      : 'Your Turn',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: GridView.count(
                crossAxisCount: 3,
                children: [
                  for (var i = 0; i < 9; i++)
                    Container(
                      color: Colors.blueGrey,
                      margin: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            tiles[i] = 1;
                          });
                          compTurn();
                        },
                        child: Center(
                          child: Text(
                            tiles[i] == 0
                                ? ''
                                : tiles[i] == 1
                                    ? 'X'
                                    : 'O',
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    tiles = List.filled(9, 0);
                  });
                },
                child: const Text('RESTART')),
          ],
        ),
      ),
    );
  }

  Future<void> compTurn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    int? w, b, n;
    for (var i = 0; i < 9; i++) {
      var val = tiles[i];
      if (val > 0) continue;

      var temp = [...tiles];
      temp[i] = 2;

      // chack for computer to win
      if (isWinning(2, temp)) {
        w = i;
      }

      // chack for user to win to block thir path
      temp[i] = 1;
      if (isWinning(1, temp)) {
        b = i;
      }

      // normal case if both of them is not there
      n = i;
    }

    int loc = w ?? b ?? n ?? 0;
    setState(() {
      tiles[loc] = 2;
    });
  }

  bool isWinning(int p, var t) {
    return (t[0] == p && t[1] == p && t[2] == p) ||
        (t[3] == p && t[4] == p && t[5] == p) ||
        (t[6] == p && t[7] == p && t[8] == p) ||
        (t[0] == p && t[3] == p && t[6] == p) ||
        (t[1] == p && t[4] == p && t[7] == p) ||
        (t[2] == p && t[5] == p && t[8] == p) ||
        (t[0] == p && t[4] == p && t[8] == p) ||
        (t[2] == p && t[4] == p && t[6] == p);
  }
}