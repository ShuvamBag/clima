import 'dart:async';

import 'package:clima/WeatherModel.dart';
import 'package:clima/getGeoLocation.dart';
import 'package:clima/weatherRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WeatherApp extends StatefulWidget {

  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String timeText = "";
  String dateText = "";
  String formatCurrentLiveTime(DateTime time)
  {
    return DateFormat("hh:mm a").format(time);
  }
  String formatCurrentDate(DateTime date)
  {
    return DateFormat("dd MMMM, yyyy").format(date);
  }
  getCurrentLiveTime(){
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);
    if(this.mounted)
    {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }
  var data;
  var client = WeatherRepo();
  info() async{
    var position = await GetPosition();
    data = await client.getWeather(position.latitude, position.longitude);
    return data;
  }
  @override
  void initState() {

    super.initState();
    timeText = formatCurrentLiveTime(DateTime.now());
    dateText = formatCurrentDate(DateTime.now());
    Timer.periodic(const Duration(minutes: 1), (timer) {
      getCurrentLiveTime();
    });

    info();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: GestureDetector(
                  onTap: () {
                    print("menu clicked");
                  },
                  child: SvgPicture.asset(
                    "assets/icons8-menu.svg",
                    height: 30,
                    width: 30,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        body: FutureBuilder(
          future: info(),
          builder: ((context,snapshot){
            return Container(
              child: Stack(
                children: [
                  Image.asset(
                    "assets/peakpx (1).jpg",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: Text(
                          '${data?.CityName}',
                          style: GoogleFonts.lato(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        child: Text(
                          "$timeText - $dateText",
                          style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 320, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "${data?.temp}°C",
                                  style: GoogleFonts.shipporiAntique(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Image.asset("assets/moon.png",width: 60,height: 60,),
                                //     SizedBox(width: 10,),
                                //     Text("${data.description}",style: GoogleFonts.lato(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)
                                //   ],
                                // )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 30, 8, 120),
                            child: Container(

                              margin: EdgeInsets.symmetric(vertical: 40),

                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white54,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30,710, 30, 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Wind",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                            Text("Rain",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                            Text("Humidity",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)


                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${data?.windspeed}",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 27, 0),
                                child: Text("${data?.rain}",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Text("${data?.humidity}",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                              )


                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Km/h",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                              child: Text("%",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                              child: Text("%",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                            )


                          ],
                        ),
                      ],
                    ),)
                ],
              ),
            );

          }),)
    );
  }
}