import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Constants/Colors_.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  bool isX_turn = true;
  String resultDeclaration = '';

  bool winnerFound = false;
  int x_score = 0;
  int o_score = 0;
  String scoreBoard = "";
  int fillBoxes = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Tic-Tac-Toe',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(66, 63, 62, 62),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Player-O',
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          ),
                          Text(
                            o_score.toString(),
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            'Player-X',
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          ),
                          Text(
                            x_score.toString(),
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          onButtonTapped(index);
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          child: Center(
                              child: Text(
                            displayXO[index],
                            style: TextStyle(fontSize: 60, color: Colors.black),
                          )),
                          decoration: BoxDecoration(
                              color: ColorHub.secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(width: 4, color: Colors.white)),
                        ),
                      );
                    }),
                  ),
                  flex: 4),
              Expanded(
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            resultDeclaration,
                            style: TextStyle(
                                fontSize: 30, color: Colors.yellowAccent),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  elevation: 0,
                                  padding: EdgeInsets.all(10)),
                              onPressed: () {
                                onClearBoard();
                              },
                              child: Text(
                                'Try Again',
                                style: TextStyle(fontSize: 30),
                              ))
                        ]),
                  ),
                  flex: 2)
            ],
          ),
        ));
  }

  void onButtonTapped(int index) {
    setState(() {
      if (!winnerFound) {
        if (displayXO[index] == '' && isX_turn) {
          fillBoxes++;
          displayXO[index] = 'X';
        } else if (!isX_turn && displayXO[index] == '') {
          displayXO[index] = 'O';
          fillBoxes++;
        }
        isX_turn = !isX_turn;

        checkWinner();
      } else {
        const sb = SnackBar(
          content: Text(
            'The game is Over!',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.deepOrange,
        );

        ScaffoldMessenger.of(context).showSnackBar(sb);
      }
      //updateWinnersScore(currentWinner);
    });
  }

  void updateWinnersScore(String currentWinner) {
    if (currentWinner == 'X') {
      x_score++;
    } else if (currentWinner == 'O') {
      print('incremented O.\n');
      o_score++;
    }
    print(o_score);
    winnerFound = true;
  }

  void checkWinner() {
    //1row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins ';
        updateWinnersScore(displayXO[0]);
      });
    }
    //2row
    else if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[3] + ' Wins ';
        updateWinnersScore(displayXO[3]);
      });
    }
    //3row
    else if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins ';
        updateWinnersScore(displayXO[6]);
      });
    }

    //1col
    else if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins ';
        updateWinnersScore(displayXO[0]);
      });
    }
    // 2col
    else if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[1] + ' Wins ';
        updateWinnersScore(displayXO[1]);
      });
    }
    // 3col
    else if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[2] + ' Wins ';
        updateWinnersScore(displayXO[2]);
      });
    }

    //diagonal 1
    else if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins ';
        updateWinnersScore(displayXO[0]);
      });
    }

    //diagonal 2
    else if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[2] + ' Wins ';
        updateWinnersScore(displayXO[2]);
      });
    } else if (fillBoxes == 9 && !winnerFound) {
      setState(() {
        resultDeclaration = 'Nobody Wins';
      });
    }
  }

  void onClearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
      fillBoxes = 0;
      winnerFound = false;
      isX_turn = true;
      x_score = 0;
      o_score = 0;
    });
  }
}
