import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTurnO = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreX = 0;
  int scoreO = 0;
  String winnerTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                for (int i = 0; i < xOrOList.length; i++) {
                  xOrOList[i] = '';
                }
              });
              filledBoxes = 0;
              isTurnO = true;
              gameHasResult = false;
              scoreX = 0;
              scoreO = 0;
            },
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
        centerTitle: true,
        title: const Text('TicTacToe'),
        elevation: 0,
        backgroundColor: Colors.grey[900],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            scoreBoard(),
            const SizedBox(
              height: 20,
            ),
            resultButton(),
            const SizedBox(
              height: 20,
            ),
            gameBoard(),
            const SizedBox(
              height: 20,
            ),
            getTurn(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget resultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            gameHasResult = false;
            clearGame();
          });
        },
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Text(
          '$winnerTitle, play again!',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget gameBoard() {
    return Expanded(
      child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                tapped(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    xOrOList[index],
                    style: TextStyle(
                      color: xOrOList[index] == 'X' ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void tapped(int index) {
    setState(() {
      if (gameHasResult) {
        return;
      }
      if (xOrOList[index] != '') {
        return;
      }
      if (isTurnO) {
        xOrOList[index] = 'O';
        filledBoxes++;
      }
      if (!isTurnO) {
        xOrOList[index] = 'X';
        filledBoxes++;
      }
      isTurnO = !isTurnO;
      checkWinner();
    });
  }

  void checkWinner() {
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[0]}');
      return;
    }
    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[3]}');
      return;
    }
    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[6]}');
      return;
    }
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[0]}');
      return;
    }
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[1]}');
      return;
    }
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[2]}');
      return;
    }
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[0]}');
      return;
    }
    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[2]}');
      return;
    }
    if (filledBoxes == 9) {
      setResult('', 'Draw');
    }
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;
      if (winner == 'X') {
        scoreX++;
      } else if (winner == 'O') {
        scoreO++;
      } else {
        scoreX++;
        scoreO++;
      }
    });
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
    });
    filledBoxes = 0;
    isTurnO = true;
    gameHasResult = false;
  }

  Widget scoreBoard() {
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: isTurnO,
                  child: const Icon(
                    Icons.arrow_right,
                    size: 30,
                    color: Colors.green,
                  ),
                ),
                const Text(
                  'Player O',
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$scoreO',
                style: const TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
          ],
        )),
        Expanded(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: !isTurnO,
                  child: const Icon(
                    Icons.arrow_right,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                const Text(
                  'Player X',
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$scoreX',
                style: const TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
