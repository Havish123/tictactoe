import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIC TAC TOE"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Player 1 Score:$player1score",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20.0))),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Player 2 Score:$player2score ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20.0)))
                  ],
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        // ignore: deprecated_member_use
                        child: OutlineButton(
                            disabledBorderColor: Colors.red,
                            highlightColor: Colors.red,
                            highlightedBorderColor: Colors.red,
                            color: Colors.red,
                            child: Text("Reset"),
                            onPressed: () => _resetboard()),
                      )),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    customOutlineButton(0, 0),
                    customOutlineButton(0, 1),
                    customOutlineButton(0, 2),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    customOutlineButton(1, 0),
                    customOutlineButton(1, 1),
                    customOutlineButton(1, 2),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    customOutlineButton(2, 0),
                    customOutlineButton(2, 1),
                    customOutlineButton(2, 2),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customOutlineButton(int n, int m) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          padding: EdgeInsets.all(3.0),
          child: OutlineButton(
            padding: EdgeInsets.all(3.0),
            child: Text(
              list[n][m],
              style: TextStyle(fontSize: 80, fontStyle: FontStyle.italic),
            ),
            onPressed: () => _btnclick(n, m),
          ),
        ),
      ),
    );
  }

  var list = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
  ];

  int player1score = 0, player2score = 0;
  bool player1 = true;
  String res = "";
  int _roundcount = 0;
  _btnclick(int n, int m) {
    if (list[n][m] != "") {
      return;
    }
    if (player1) {
      _roundcount++;
      setState(() {
        list[n][m] = "X";
      });
    } else {
      _roundcount++;
      setState(() {
        list[n][m] = "O";
      });
    }
    print("Round COunt=" + _roundcount.toString());

    if (_winorlose()) {
      if (player1) {
        _player1wins();
      } else {
        _player2wins();
      }
    } else if (_roundcount == 9) {
      _draw();
    } else {
      player1 = !player1;
      print(player1);
    }
  }

  _showDialog(String win) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(" $win"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Play Again"))
            ],
          );
        });
  }

  _draw() {
    _showDialog("Match Draw");
    setState(() {
      list = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""]
      ];

      _roundcount = 0;
    });
  }

  _player1wins() {
    _showDialog(" Winner is Player 1");
    setState(() {
      list = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""]
      ];
      player1score++;
      _roundcount = 0;
    });
  }

  _player2wins() {
    _showDialog("Winner is Player 2");
    setState(() {
      list = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""]
      ];
      player2score++;
      _roundcount = 0;
    });
  }

  _resetboard() {
    setState(() {
      list = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""]
      ];
      player1score = 0;
      player2score = 0;
      _roundcount = 0;
    });
  }

  _winorlose() {
    for (int i = 0; i < 3; i++) {
      if (list[i][0] == list[i][1] &&
          list[i][0] == list[i][2] &&
          list[i][0] != "") {
        return true;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (list[0][i] == list[1][i] &&
          list[0][i] == list[2][i] &&
          list[0][i] != "") {
        return true;
      }
    }
    if (list[0][0] == list[1][1] &&
        list[0][0] == list[2][2] &&
        list[0][0] != "") {
      return true;
    }
    if (list[2][0] == list[1][1] &&
        list[2][0] == list[0][2] &&
        list[0][2] != "") {
      return true;
    }
    return false;
  }
}
