import 'package:dam_multi_tp4/convertion.dart';
import 'package:flutter/material.dart';

import '../component/button.dart';





class TempScreen extends StatelessWidget {
  static String routeName = '/temp_screen';
  final TemperatureConvertion temp = TemperatureConvertion.celcius(22);
  TempScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(0, 0, 255, 0.25),
      appBar: AppBar(
        title: const Text("Température"),
      ),
      body: 
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StreamBuilder(
              stream: temp.stream,
              builder: (context, AsyncSnapshot<String> snapshot) {
                if(snapshot.hasData){
                  return Text(snapshot.data??"",style: const TextStyle(fontSize: 60),);
                }
                return const Icon(Icons.not_interested,size: 60,);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:  [
                BigButton.text("C",onPressed: () => temp.changeView(TemperatureUnit.celcius),),
                BigButton.text("F",onPressed: () => temp.changeView(TemperatureUnit.fahrenheit),),
                BigButton.text("K",onPressed: () => temp.changeView(TemperatureUnit.kelvin),),
                
              ],)
          ],
        ),
        ),
      ),
      );
  }
}