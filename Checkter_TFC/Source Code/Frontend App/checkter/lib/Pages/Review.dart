import 'package:flutter/material.dart';

int tmp = 4;

class Review extends StatelessWidget {
  const Review({Key? key}) : super(key: key);

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
        title: const Text('Review Games'),
        backgroundColor: Colors.red.shade500
      ),

      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('resources/images/background_review.png'),
                fit: BoxFit.cover)),
        
        child: Column(
          children: [
            Container(
              width: width * 0.05,
              height: height * 0.09,
              margin: EdgeInsets.only(top: 20, right: width * 0.9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.orange.shade400,
                image: DecorationImage(image: AssetImage('resources/images/return_icon.png'), scale: 15)),
              child: InkWell(
                onTap: () {
                  tmp++;
                  Navigator.pushReplacementNamed(context, '/menu');
                },
              ),
            ),
            Container(
              width: width,
              height: height * 0.35,
              margin: EdgeInsets.only(top: height * 0.125),
              color: Colors.white.withOpacity(0.2),
              child: Container(
                width: width * 0.5,
                margin: EdgeInsets.only(right: width * 0.2, left: width * 0.025),
                child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Número total de partidas
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: (index < tmp) ? Colors.lightGreen.shade400  : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () {
                        showCustomSnackBar(context, 'La revision de partidas esta deshabilitada temporalmente.');
                      },
                      child: Text(
                        'Partida ${index + 1}',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              )
            )


          ],
        )
        
      )
    );
  }
}
