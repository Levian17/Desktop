import 'package:flutter/material.dart';

class Util {

  Widget getImagePieza(String pieza) {
    Widget piezaWidget;
    switch (pieza) {
      case 'p':
        piezaWidget = Image(image: AssetImage('resources/images/Pawn_Blanco.png'));
        break;
      case 'r':
        piezaWidget = Image(image: AssetImage('resources/images/Torre_Blanca.png'));
        break;
      case 'n':
        piezaWidget = Image(image: AssetImage('resources/images/Caballo_Blanco.png'));
        break;
      case 'b':
        piezaWidget = Image(image: AssetImage('resources/images/Alfil_Blanco.png'));
        break;
      case 'q':
        piezaWidget = Image(image: AssetImage('resources/images/Reina_Blanca.png'));
        break;
      case 'k':
        piezaWidget = Image(image: AssetImage('resources/images/Rey_Blanco.png'));
        break;
      case 'P':
        piezaWidget = Image(image: AssetImage('resources/images/Pawn_Negro.png'));
        break;
      case 'R':
        piezaWidget = Image(image: AssetImage('resources/images/Torre_Negra.png'));
        break;
      case 'N':
        piezaWidget = Image(image: AssetImage('resources/images/Caballo_Negro.png'));
        break;
      case 'B':
        piezaWidget = Image(image: AssetImage('resources/images/Alfil_Negro.png'));
        break;
      case 'Q':
        piezaWidget = Image(image: AssetImage('resources/images/Reina_Negra.png'));
        break;
      case 'K':
        piezaWidget = Image(image: AssetImage('resources/images/Rey_Negro.png'));
        break;
      default:
        piezaWidget = Container();
        break;
    }
    return piezaWidget;
  }

  static String convertirMovimiento(String movimiento) {
    // Convertir la columna de notación algebraica a índice de matriz (0 a 7)
    int convertirColumna(String columna) {
      return columna.codeUnitAt(0) - 'a'.codeUnitAt(0);
    }

    // Convertir la fila de notación algebraica a índice de matriz (0 a 7)
    int convertirFila(String fila) {
      return 8 - int.parse(fila);
    }

    // Extraer las partes del movimiento
    String fromCol = movimiento[0];
    String fromRow = movimiento[1];
    String toCol = movimiento[2];
    String toRow = movimiento[3];

    // Convertir las partes del movimiento a índices de matriz
    int fromColIndex = convertirColumna(fromCol);
    int fromRowIndex = convertirFila(fromRow);
    int toColIndex = convertirColumna(toCol);
    int toRowIndex = convertirFila(toRow);

    // Crear la cadena de movimiento basado en índices de matriz con espacios
    String movimientoConvertido = '$fromColIndex $fromRowIndex $toColIndex $toRowIndex';

    return movimientoConvertido;
  }

  static List<String> translateMoves(List<String> movimientos) {
    List<String> translatedMoves = [];

    List<String> letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

    for (String move in movimientos) {

      String translatedMove = '';
      List<String> splittedMove = move.split(' ');

      for (int x=0; x<splittedMove.length; x++) {

        if (x == 0 || x == 2) {
          translatedMove += letters[int.parse(splittedMove[x])];
        }else {
          translatedMove += (8 - int.parse(splittedMove[x])).toString();
        }
      }

      translatedMoves.add(translatedMove);
    }

    return translatedMoves;
  }

  static String movesToString(List<String> movimientos) {

    String textMoves = '';

    for (String text in movimientos) {
      textMoves += text + ',  ';
    }

    return textMoves;
  }

  static List<List<String>> move(List<List<String>> tablero, String movimientoConvertido) {
    // Parsear el movimiento convertido
    List<String> partesMovimiento = movimientoConvertido.split(' ');
    print(partesMovimiento[0]);
    int fromCol = int.parse(partesMovimiento[0]);
    int fromRow = int.parse(partesMovimiento[1]);
    int toCol = int.parse(partesMovimiento[2]);
    int toRow = int.parse(partesMovimiento[3]);

    // Crear una copia del tablero para no modificar el original
    List<List<String>> nuevoTablero = List.generate(8, (i) => List.from(tablero[i]));

    // Realizar el movimiento
    nuevoTablero[toRow][toCol] = nuevoTablero[fromRow][fromCol];
    nuevoTablero[fromRow][fromCol] = '.';

    return nuevoTablero;
  }
}
