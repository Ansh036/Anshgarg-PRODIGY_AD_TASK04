import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> b = List.filled(9, '');
  String p = 'X';
  String w = '';

  void play(int i) {
    if (b[i] == '' && w == '') {
      setState(() {
        b[i] = p;
        p = p == 'X' ? 'O' : 'X';
        checkWin();
      });
    }
  }

  void checkWin() {
    List<List<int>> c = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ];
    for (var p in c) {
      if (b[p[0]] != '' && b[p[0]] == b[p[1]] && b[p[1]] == b[p[2]]) {
        w = b[p[0]];
      }
    }
  }

  void reset() {
    setState(() {
      b = List.filled(9, '');
      p = 'X';
      w = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () => play(i),
                child: Container(
                  margin: EdgeInsets.all(4),
                  color: Colors.blue[100],
                  child: Center(
                    child: Text(
                      b[i],
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Text(
            w == '' ? 'Turn: $p' : '$w Wins!',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: reset,
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }
}
