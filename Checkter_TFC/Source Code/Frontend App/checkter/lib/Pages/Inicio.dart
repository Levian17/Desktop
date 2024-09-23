import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

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
        title: const Text('Checkter'),
        backgroundColor: Colors.red.shade500
      ),

      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('resources/images/background_menu.gif'),
                fit: BoxFit.cover)),
        
        child: Row(
          children: [
            Container(
              height: height * 0.65,
              width: width * 0.45,
              margin: EdgeInsets.only(left: width * 0.075),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('resources/images/main_icon.png'), fit: BoxFit.cover),),
            ),
            Container(
              height: height * 0.2,
              width: width * 0.3,
              margin: EdgeInsets.only(top: height * 0.4, left: width * 0.1),
              child: Column(
                children: [
                  Container(
                    width: width,
                    height: height * 0.075,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red.shade500)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/menu');
                      },
                      child: const Text('Iniciar Sesión', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
                      ,),
                  ),
                  Container(
                    width: width,
                    height: height * 0.075,
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey.shade500)),
                      onPressed: () {
                        showCustomSnackBar(context, 'La creacion de cuentas esta deshabilitada.');
                      },
                      child: const Text('Crear Cuenta', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
                      ,),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
