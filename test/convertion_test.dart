import 'package:dam_multi_tp4/convertion.dart';
import 'package:flutter_test/flutter_test.dart';
List<Map<TemperatureUnit, double>> convertionTest = [
  {
    TemperatureUnit.celcius:0,
    TemperatureUnit.fahrenheit:32,
    TemperatureUnit.kelvin:273.15,
  },
  {
    TemperatureUnit.celcius:-17.78,
    TemperatureUnit.fahrenheit:0,
    TemperatureUnit.kelvin:255.37,
  }
];

Matcher closeToTemperature(value){
  return closeTo(value, 0.1);
}

testTemperatureConvertion(TemperatureConvertion obj, Map<TemperatureUnit, double> testCase, TemperatureUnit to){
  expect(obj.as(to).unit, to, reason: "Convertion Unit from ${obj.unit} to $to");
  expect(obj.as(to).value, closeToTemperature(testCase[to]), reason: "Convertion value ${obj.value} from ${obj.unit} to $to");
  expect(obj.as(to).toString(), "${(testCase[to]!*10).round()/10}${to.suffix}", reason: "Convertion to string  ${obj.value} from ${obj.unit} to $to");
}

testAllTemperatureConvertion(TemperatureConvertion obj, Map<TemperatureUnit, double> testCase){
  for (var to in testCase.keys) {
    testTemperatureConvertion(obj, testCase, to);
  }  
}

void main() {

  group("Convertion de température", 
    () {

      group("Creation d'object", 
        () {
          test("Creation par default", 
            (){
              TemperatureConvertion temp = TemperatureConvertion(22);
              expect(temp.unit, TemperatureUnit.celcius);
              expect(temp.value, 22);
              expect(temp.toString(),"22.0\u00B0C");
            }
          );
          test("Creation par Unit", 
            (){
              TemperatureConvertion temp = TemperatureConvertion(22, unit:TemperatureUnit.celcius);
              expect(temp.unit, TemperatureUnit.celcius);
              expect(temp.value, 22);
              expect(temp.toString(),"22.0\u00B0C");
            }
          );
          test("Création Celcius",
            (){
              TemperatureConvertion temp = TemperatureConvertion.celcius(22);
              expect(temp.unit, TemperatureUnit.celcius);
              expect(temp.value, 22);
              expect(temp.toString(),"22.0\u00B0C");
            }
          );
          test("Création Fahrenheit",
            (){
              TemperatureConvertion temp = TemperatureConvertion.fahrenheit(22);
              expect(temp.unit, TemperatureUnit.fahrenheit);
              expect(temp.value, 22);
              expect(temp.toString(),"22.0\u00B0F");
            }
          );
          test("Création Kelvin",
            (){
              TemperatureConvertion temp = TemperatureConvertion.kelvin(22);
              expect(temp.unit, TemperatureUnit.kelvin);
              expect(temp.value, 22);
              expect(temp.toString(),"22.0 K");
            }
          );
        }
      );
      
      group("Convertion", 
        (){
          test("Celcius",
            (){
              TemperatureUnit from = TemperatureUnit.celcius;
              for (var testCase in convertionTest) {
                TemperatureConvertion temp = TemperatureConvertion.celcius(testCase[from]!);
                testAllTemperatureConvertion(temp, testCase);
              }
            }
          );
          test("fahrenheit",
            (){
              TemperatureUnit from = TemperatureUnit.fahrenheit;
              for (var testCase in convertionTest) {
                TemperatureConvertion temp = TemperatureConvertion.fahrenheit(testCase[from]!);
                testAllTemperatureConvertion(temp, testCase);
              }
            }
          );
          test("kelvin",
            (){
              TemperatureUnit from = TemperatureUnit.kelvin;
              for (var testCase in convertionTest) {
                TemperatureConvertion temp = TemperatureConvertion.kelvin(testCase[from]!);
                testAllTemperatureConvertion(temp, testCase);
              }
            }
          );
        }
      );
    }
  );
}