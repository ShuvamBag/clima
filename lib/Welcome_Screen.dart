import 'dart:async';
import 'package:clima/weather_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>WeatherApp()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.shade400,
                    Colors.pinkAccent,
                    Colors.yellowAccent
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight

              )
          ),
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Image.asset("assets/umbrella.gif",),
                AnimatedTextKit(
                    animatedTexts:[ScaleAnimatedText('clima',scalingFactor:0.5,textStyle: GoogleFonts.sacramento(fontSize: 120,color: Colors.white,fontWeight: FontWeight.bold),)]
                ),
              ],
            ),
          ),



        )
    );
  }
}
