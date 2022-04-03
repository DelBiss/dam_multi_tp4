
import 'package:dam_multi_tp4/component/button.dart';
import 'package:dam_multi_tp4/component/lock_status.dart';
import 'package:flutter/material.dart';

import 'temperature.dart';

class LockScreen extends StatelessWidget {
  final GlobalKey<ToogleWidgetState> _lockStatus = GlobalKey<ToogleWidgetState>();
  static String routeName = '/lock_screen';
  LockScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ma maison"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Serrure", style: TextStyle(fontSize: 30),),
            ToogleWidget(
              key: _lockStatus,
              active: const Icon(Icons.lock, size: 200,),
              inactive:  const Icon(Icons.lock_open, size: 200,),
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:  [
                BigButton.icon(Icons.lock, onPressed: () => _lockStatus.currentState?.showActive()),
                BigButton.icon(Icons.lock_open, onPressed: () => _lockStatus.currentState?.showInactive()),
                BigButton.icon(Icons.thermostat_outlined,
                  onPressed: () {
                    Navigator.pushNamed(context, TempScreen.routeName);
                  },),
              ],)
          ],
        )),
      ),
    );
  }
}