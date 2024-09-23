import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Variables de contexto
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void showCustomSnackBar(BuildContext context, String message) {
      final snackBar = SnackBar(
      content: Text(message), duration: Duration(seconds: 2),);
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: Colors.red.shade500
      ),

      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('resources/images/background_menu.gif'),
                fit: BoxFit.cover)),
        
        child: Center(
          child: Column(
            children: [
              Container(
                height: 100,
                width: 300,
                margin: EdgeInsets.only(top: 75, right: 800),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 101, 77, 146))),
                  onPressed: () {
                    showCustomSnackBar(context, 'La configuracion esta deshabilitada temporalmente.');
                  },
                  child: Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('resources/images/ajustes_icon.png'))
                          ),
                        ),
                        const Text('Configuración', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),),
                      ],
                    ),
                  )
                ),
              ),
              Container(
                height: 150,
                width: 150,
                margin: EdgeInsets.only(top: 75,),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.orange.shade400)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/game');
                  },
                  child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('resources/images/play_icon.png'))
                          ),
                        ),
                        const Text('Jugar Partida', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),),
                      ],
                    
                  )
                ),
              ),
              Container(
                height: 100,
                width: 300,
                margin: EdgeInsets.only(top: 75, left: 800),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 101, 77, 146))),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/review');
                  },
                  child: Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('resources/images/review_icon.png'))
                          ),
                        ),
                        const Text('Revisar Partidas', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),),
                      ],
                    ),
                  )
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
