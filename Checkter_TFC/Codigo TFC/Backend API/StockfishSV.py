from flask import json
from stockfish import Stockfish

stockfish = Stockfish(path='/home/levian/Documentos/TFC/Codigo TFC/Backend API/stockfish/stockfish-ubuntu-x86-64-sse41-popcnt')
stockfish.update_engine_parameters({"Hash": 2048, "UCI_Chess960": "true"})

stockfish.get_board_visual()

# Definimos los metodos del motor que vamos a utilizar
def setELO(elo):
    stockfish.set_elo_rating(elo)
    return "Elo del motor ajustado a " + str(elo)

# Definimos los metodos del motor que vamos a utilizar
def bestMove():
    return stockfish.get_best_move()

def setPosition(moves_string):
    # Separar los movimientos y eliminar espacios extra
    position = [move.strip() for move in moves_string.split(',')]
    
    # Ajustar la posición en Stockfish
    stockfish.set_position(position)
    
    # Obtener la visualización del tablero de Stockfish (opcional, si quieres imprimirlo)
    board_visual = stockfish.get_board_visual()
    
    # Devolver un mensaje de confirmación (opcional)
    return "Posición ajustada."
