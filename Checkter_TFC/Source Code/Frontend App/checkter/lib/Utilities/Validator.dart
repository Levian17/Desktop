class Validator {

  // Atributos
  List<List<String>> tablero = [];

  // Constructor
  Validator(this.tablero);

  // Metodos

  /* Comprueba si el movimiento de un peon se puede realizar o no. */
  bool validarMovimientoPeon(int fromRow, int fromCol, int toRow, int toCol, bool esBlanca) {
    int direction = esBlanca ? -1 : 1;
    int startRow = esBlanca ? 6 : 1;

    if (fromCol == toCol && tablero[toRow][toCol] == '.') {
      if (toRow == fromRow + direction) return true;
        if (fromRow == startRow && toRow == fromRow + 2 * direction) return true;
    }

    if ((toCol == fromCol + 1 || toCol == fromCol - 1) && toRow == fromRow + direction && tablero[toRow][toCol] != '.') {
      return true;
    }

    return false;
  }

  /* Comprueba si el movimiento de un torre se puede realizar o no. */
  bool validarMovimientoTorre(int fromRow, int fromCol, int toRow, int toCol) {
    if (fromRow != toRow && fromCol != toCol) return false;

    if (fromRow == toRow) {
      for (int col = (fromCol < toCol ? fromCol + 1 : toCol + 1); col < (fromCol < toCol ? toCol : fromCol); col++) {
        if (tablero[fromRow][col] != '.') return false;
      }
    } else {
      for (int row = (fromRow < toRow ? fromRow + 1 : toRow + 1); row < (fromRow < toRow ? toRow : fromRow); row++) {
        if (tablero[row][fromCol] != '.') return false;
      }
    }

    return true;
  }

  /* Comprueba si el movimiento de un caballo se puede realizar o no. */
  bool validarMovimientoCaballo(int fromRow, int fromCol, int toRow, int toCol) {
    int dRow = (toRow - fromRow).abs();
    int dCol = (toCol - fromCol).abs();
    return (dRow == 2 && dCol == 1) || (dRow == 1 && dCol == 2);
  }

  /* Comprueba si el movimiento de un alfil se puede realizar o no. */
  bool validarMovimientoAlfil(int fromRow, int fromCol, int toRow, int toCol) {
    int dRow = (toRow - fromRow).abs();
    int dCol = (toCol - fromCol).abs();
    if (dRow != dCol) return false;

    int rowStep = (toRow > fromRow) ? 1 : -1;
    int colStep = (toCol > fromCol) ? 1 : -1;
    for (int i = 1; i < dRow; i++) {
      if (tablero[fromRow + i * rowStep][fromCol + i * colStep] != '.') return false;
    }

    return true;
  }

  /* Comprueba si el movimiento de un reina se puede realizar o no. */
  bool validarMovimientoReina(int fromRow, int fromCol, int toRow, int toCol) {
    return validarMovimientoTorre(fromRow, fromCol, toRow, toCol) || validarMovimientoAlfil(fromRow, fromCol, toRow, toCol);
  }

  /* Comprueba si el movimiento de un rey se puede realizar o no. */
  bool validarMovimientoRey(int fromRow, int fromCol, int toRow, int toCol) {
    int dRow = (toRow - fromRow).abs();
    int dCol = (toCol - fromCol).abs();
    
    // Movimiento normal del rey (una casilla en cualquier dirección)
    if (dRow <= 1 && dCol <= 1) {
      return true;
    }
    
    return false;
  }

  /* Comprueba si el movimiento se puede realizar o no. */
  bool validarMovimiento(int fromRow, int fromCol, int toRow, int toCol) {
    String pieza = tablero[fromRow][fromCol];
    String destino = tablero[toRow][toCol];

    if (pieza == '.') return false;

    bool esBlanca = pieza == pieza.toLowerCase();

    // No podemos mover a una casilla ocupada por una pieza del mismo color
    if (destino != '.' && (esBlanca == (destino == destino.toLowerCase()))) {
      return false;
    }

    switch (pieza.toLowerCase()) {
      case 'p':
        return validarMovimientoPeon(fromRow, fromCol, toRow, toCol, esBlanca);
      case 'r':
        return validarMovimientoTorre(fromRow, fromCol, toRow, toCol);
      case 'n':
        return validarMovimientoCaballo(fromRow, fromCol, toRow, toCol);
      case 'b':
        return validarMovimientoAlfil(fromRow, fromCol, toRow, toCol);
      case 'q':
        return validarMovimientoReina(fromRow, fromCol, toRow, toCol);
      case 'k':
        return validarMovimientoRey(fromRow, fromCol, toRow, toCol);
      default:
        return false;
    }
  }
}