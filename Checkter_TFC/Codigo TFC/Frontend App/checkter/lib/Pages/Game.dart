import 'package:flutter/material.dart';
import 'package:checkter/Utilities/Validator.dart';
import 'package:checkter/Utilities/Util.dart';
import 'package:checkter/Utilities/Conector.dart';

// Matriz con el tablero base, las mayusculas son negras, las minusculas blancas.
List<List<String>> tablero = [
  ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R'],
  ['P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'],
  ['.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.', '.', '.', '.'],
  ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'],
  ['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'],
];

List<List<int>> movimientosNegro = [
  [0, 1, 2, 2], // e5
  [1, 4, 2, 4], // Nc6
  [1, 3, 3, 3], // Qe7
  [0, 5, 3, 2], // Nd4
  [1, 6, 2, 6], // Nf6
  [3, 7, 3, 5], // d6
  [5, 5, 5, 3], // Nc6
  [4, 7, 2, 5], // Be6
  [1, 7, 1, 6], // Bd7
  [1, 6, 1, 4], // O-O
  [0, 1, 2, 1], // a6
  [1, 4, 2, 2], // b5
  [2, 5, 4, 3], // Be6
  [4, 3, 5, 2], // Bxe6
  [1, 4, 1, 3], // O-O
  [2, 1, 3, 3], // Qd7
  [4, 6, 3, 4], // d6
  [4, 4, 2, 3], // Nxd4
  [5, 2, 2, 3], // Nxd4
  [2, 7, 3, 6], // Qe8
  [7, 7, 6, 7], // h6
  [2, 2, 3, 2], // e5
  [4, 2, 5, 2], // Qg6
  [5, 5, 7, 7], // Nh5
  [6, 7, 6, 6], // Nxg3
  [7, 6, 7, 5], // Qxg3+
  [4, 6, 3, 7], // Rxf3
  [6, 5, 7, 6], // Qxg3
  [7, 7, 6, 6], // Rxh3+
  [7, 6, 7, 5]  // Qxh2+
];

int contador = 0;

// Lista que almacenará los movimientos que se van realizando
List<String> movimientos = [];

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkter'),
        backgroundColor: Colors.orange.shade300,
      ),
      body: const MyHomePage(title: 'Checkter'),
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
  @override
  Widget build(BuildContext context) {
    // Objetos que se emplean posteriormente
    Validator validator = Validator(tablero);

    // Variables de contexto
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Funciones internas
    void showCustomSnackBar(BuildContext context, String message, Color color) {
      final snackBar = SnackBar(
      content: Text(message, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),), duration: Duration(seconds: 2), backgroundColor: color,);
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Container crearTablero() {
      return Container(
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(8, (i) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(8, (j) {
                return DragTarget<String>(
                  onAccept: (data) async {
                    setState(() {
                      List<String> dataParts = data.split(',');
                      int fromRow = int.parse(dataParts[0]);
                      int fromCol = int.parse(dataParts[1]);
                      String pieza = dataParts[2];

                      // Comprobamos si el movimiento se puede realizar
                      if (validator.validarMovimiento(fromRow, fromCol, i, j)) {
                        tablero[i][j] = pieza;
                        tablero[fromRow][fromCol] = '.';

                        movimientos.add(fromCol.toString() + ' ' + fromRow.toString() + ' ' + 
                        j.toString() + ' ' + i.toString());

                        tablero[movimientosNegro[contador][2]][movimientosNegro[contador][3]] = tablero[movimientosNegro[contador][0]][movimientosNegro[contador][1]];
                        tablero[movimientosNegro[contador][0]][movimientosNegro[contador][1]] = '.';
                        contador++;

                        if(tablero[1][5] == 'q') {
                          showCustomSnackBar(context, "El jugador de las piezas blancas a ganado", Colors.green);
                        }

                      }
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    // Atributos de las casillas
                    Widget piezaWidget = Util().getImagePieza(tablero[i][j]);
                    double altoCasilla = height * 0.08;
                    double anchoCasilla = width * 0.05;
                    Color blanco = const Color.fromARGB(255, 255, 235, 208);
                    Color negro = const Color.fromARGB(255, 94, 61, 49);

                    return tablero[i][j] != '.' && tablero[i][j] == tablero[i][j].toLowerCase()
                        ? Draggable<String>(
                            data: '$i,$j,${tablero[i][j]}',
                            child: Container(
                              width: anchoCasilla,
                              height: altoCasilla,
                              color: (i + j) % 2 == 0 ? blanco : negro,
                              child: Center(child: piezaWidget),
                            ),
                            feedback: Material(
                              child: Container(
                                width: anchoCasilla,
                                height: altoCasilla,
                                color: Colors.lightGreen.shade300,
                                child: Center(child: piezaWidget),
                              ),
                            ),
                            childWhenDragging: Container(
                              width: anchoCasilla,
                              height: altoCasilla,
                              color: (i + j) % 2 == 0 ? blanco : negro,
                            ),
                          )
                        : Container(
                            width: anchoCasilla,
                            height: altoCasilla,
                            color: (i + j) % 2 == 0 ? blanco : negro,
                            child: Center(child: piezaWidget),
                          );
                  },
                );
              }),
            );
          }),
        ),
      );
    }

    // Contenido pantalla
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('resources/images/background_game.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          margin: const EdgeInsets.all(65),
          child: Row(
            children: [
              // Tablero
              Container(
                height: height * 0.8,
                width: width * 0.4575,
                margin: EdgeInsets.only(right: height * 0.15),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(10)),
                child: crearTablero(),
              ),

              // Panel
              Container(
                height: height * 0.8,
                width: width * 0.3,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    // Label movimientos
                    Container(
                      height: height * 0.04,
                      width: width * 0.9,
                      margin: EdgeInsets.only(
                          right: width * 0.1, left: width * 0.005),
                      child: const Text(
                        'Movimientos realizados:',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    // Movimientos
                    Container(
                      width: width * 0.3,
                      height: height * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        Util.movesToString(Util.translateMoves(movimientos)),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),

                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 150,
                          margin: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(25)),
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red.shade400),),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/menu');
                            },
                            child: const Text('Rendirse', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(25)),
                          margin: EdgeInsets.only(top: 30, left: 35),
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.orange.shade300)),
                            onPressed: () {
                              showCustomSnackBar(context, 'Stockfish ha rechazado las tablas...', Colors.red.shade500);
                            },
                            child: const Text('Pedir Tablas', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
