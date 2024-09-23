from flask import Flask, request, jsonify
from DatabaseSV import ask_DB, insert_DB
from StockfishSV import bestMove, setELO, setPosition

# Definimos el objeto Flask
app = Flask(__name__);

# ------------------------------------------------------ DATABASE

# Devolver usuarios
@app.route('/DB/getUsuarios', methods=['GET'])
def getUsuarios():
  resultado = ask_DB('select * from Usuario')
  return jsonify(resultado)

# Devolver partidas
@app.route('/DB/getPartidas', methods=['GET'])
def getPartidas():
  resultado = ask_DB('select * from Game')
  return jsonify(resultado)

# Insertar partida
@app.route('/DB/insertPartida', methods=['POST'])
def insertPartida():
    # Obtiene los datos del cuerpo de la solicitud
    data = request.json

    # Extrae los datos de la solicitud
    ID_Game = data.get('ID_Game')
    Type = data.get('Type')
    Mean_ELO = data.get('Mean_ELO')
    White_ID = data.get('White_ID')
    Black_ID = data.get('Black_ID')
    Moves = data.get('Moves')

    # Define la consulta INSERT
    query = "INSERT INTO Game (ID_Game, Type, Mean_ELO, White_ID, Black_ID, Moves) VALUES (%s, %s, %s, %s, %s, %s)"
    values = (ID_Game, Type, Mean_ELO, White_ID, Black_ID, Moves)

    resultado = insert_DB(query, values)

    return jsonify({"Resultado": resultado}), 201

# ------------------------------------------------------ STOCKFISH

# Devolver mejor movimiento en la posicion
@app.route('/Stockfish/getBestMove', methods=['GET'])
def getBestMove():
  
  return jsonify({'move': bestMove()})

# Devolver mejor movimiento en la posicion
@app.route('/Stockfish/setELO', methods=['POST'])
def set_ELO():

  # Obtiene los datos del cuerpo de la solicitud
  data = request.json

  elo = data.get('Elo')

  resultado = setELO(elo)
  
  return jsonify({"Resultado": resultado}), 201

# Actualizar posicion y enviar mejor movimiento
@app.route('/Stockfish/setPosition', methods=['POST'])
def setPos():
    # Obtiene los datos del cuerpo de la solicitud
    data = request.json
    moves = data.get('moves')
    resultado = setPosition(moves)
    best_move = bestMove()
    return jsonify({'move': best_move})


# ------------------------------------------------------ API START

# Iniciamos la API
app.run()