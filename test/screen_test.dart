// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dam_multi_tp4/component/button.dart';
import 'package:dam_multi_tp4/component/lock_status.dart';
import 'package:dam_multi_tp4/screen/lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';



Widget wrapWithMaterialApp(Widget w) => MaterialApp( home: w);

void main() {

  Widget getLockScreen() => wrapWithMaterialApp(LockScreen());
  bool estComponentSerrure(element)=>(element is BigButton) || (element is ToogleWidget);

  group(
    "Page Serrure", 
    ()
    {
      testWidgets("AppBar contien le bon titre", (WidgetTester tester) async {
          await tester.pumpWidget(getLockScreen());
          expect(find.widgetWithText(AppBar, 'Ma maison'), findsOneWidget);
        }
      );

      testWidgets("Consigne #1: Le padding est de 8 tout autour", (WidgetTester tester) async {
          await tester.pumpWidget(getLockScreen());
          var allScreenComponent = find.byWidgetPredicate(estComponentSerrure);
          final parentPaddingComponent = find.ancestor(of: allScreenComponent, matching: find.byType(Padding));
          
          //Trouver l'element qui contient le meme nombre d'enfant que le nombre de component présent
          var validElement = parentPaddingComponent.evaluate().where((padElement){
            return find.descendant(
                of: find.byElementPredicate((element) => element == padElement),
                
                matching: find.byWidgetPredicate(estComponentSerrure)
            ).evaluate().length >= allScreenComponent.evaluate().length;
          });
          
          //Retourn l'element comme un finder
          var uniqueFinder = find.byElementPredicate((element) => validElement.contains(element),);

          expect((tester.widget<Padding>(uniqueFinder)).padding, const EdgeInsets.all(8.0));
        }
      );
      testWidgets("Consigne #2: Le texte “Serrure” a une taille de 30", (WidgetTester tester) async{
        await tester.pumpWidget(getLockScreen());
        expect((tester.widget<Text>(find.text("Serrure"))).style?.fontSize,30);
      });

      testWidgets("Consigne #3: Les boutons ont une taille de 100x100 et leur icône une taille de 50", (WidgetTester tester) async{
        await tester.pumpWidget(getLockScreen());
        var allButton = find.byType(BigButton);
        expect(allButton, findsNWidgets(3));
        tester.widgetList(allButton).forEach((element) {
          var myButton = find.byWidget(element);
          var myButtonSize = tester.getSize(myButton);
          expect(myButtonSize.height, 100);
          expect(myButtonSize.width, 100);
          var myIcon =find.descendant(of: myButton, matching: find.byType(Icon));
          expect(myIcon, findsOneWidget);
          expect(tester.widget<Icon>(myIcon).size, 50);
        });
      });
    }
  );
}
