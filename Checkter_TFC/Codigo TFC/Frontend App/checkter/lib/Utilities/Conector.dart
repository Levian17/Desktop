import 'dart:convert';
import 'package:http/http.dart' as http;

class Conector {

static Future<String> blackMove(String movesToString) async {
    var client = http.Client();
    try {
      // Convertir los movimientos a una cadena JSON
      var jsonString = jsonEncode({'moves': movesToString});

      // Establecer el tipo de contenido a application/json
      var response = await client.post(
        Uri.http('localhost:5000', 'Stockfish/setPosition'),
        headers: {'Content-Type': 'application/json'},
        body: jsonString
      );

      // Procesar la respuesta si es necesario
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var bestMove = jsonResponse['move'];
        print('Best move: $bestMove');
        return bestMove;
      } else {
        print('Error: ${response.statusCode}');
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Exception: $e');
      return 'Exception: $e';
    } finally {
      client.close();
    }
}

  static Future<String> getBestMove() async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.http('localhost:5000', 'Stockfish/getBestMove'));
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      String bestMove = decodedResponse['move'].toString();

      return bestMove;
    } finally {
      client.close();
    }
  }

  static void postMovimientos(String movesToString /* {"moves": "d2d3, e5e7"} */) async {
    var client = http.Client();
    try {
      // Convert the moves to a JSON string
      var jsonString = jsonEncode({'moves': movesToString});

      // Set the content type to application/json
      client.post(
        Uri.http('localhost:5000', 'Stockfish/setPosition'),
        headers: {'Content-Type': 'application/json'},
        body: jsonString
      );
    } finally {
      client.close();
    }
  }
}