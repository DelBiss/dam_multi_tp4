import 'dart:async';

enum TemperatureUnit {unknow, celcius, fahrenheit, kelvin}



abstract class TemperatureValue {
  double value;
  TemperatureUnit unit;// = TemperatureUnit.unknow;

  TemperatureValue(this.value, this.unit);

  TemperatureValue to(TemperatureUnit toUnit){
    switch (toUnit) {
      case TemperatureUnit.celcius:
        return toCelcius();
      case TemperatureUnit.fahrenheit:
        return toFahrenheit();
      case TemperatureUnit.kelvin:
        return toKelvin();
      default:
        return this;
    }
  }
  TemperatureValue toCelcius(){
    return this;
  }

  TemperatureValue toFahrenheit(){
    return toCelcius().toFahrenheit();
  }

  TemperatureValue toKelvin(){
    return toCelcius().toKelvin();
  }

  @override
  String toString(){
    //That complicated beaucause of -0.0
    return "${((value*10).round()/10)}${unit.suffix}";
  }
}

class CelciusValue extends TemperatureValue{
  CelciusValue(double value) : super(value, TemperatureUnit.celcius);

  @override
  TemperatureValue toFahrenheit() {
    return FahrenheitValue((value * (9/5)) + 32);
    
  }

  @override
  TemperatureValue toKelvin() {
    return KelvinValue(value+273.15);
  }

}

class FahrenheitValue extends TemperatureValue{
  FahrenheitValue(double value) : super(value, TemperatureUnit.fahrenheit);

  @override
  TemperatureValue toCelcius() {
    return CelciusValue((value-32)*(5/9));
  }
}

class KelvinValue extends TemperatureValue{
  KelvinValue(double value) : super(value, TemperatureUnit.kelvin);

  @override
  TemperatureValue toCelcius() {
    return CelciusValue(value-273.15);
  }
}

class TemperatureConvertion {
  final TemperatureValue _temperature;
  TemperatureUnit _viewUnit;
  final _view = StreamController<String>();

  TemperatureConvertion(double temperature, {TemperatureUnit unit=TemperatureUnit.unknow}):
    _viewUnit=unit,
    _temperature=unit.getValue(temperature);

  TemperatureConvertion.celcius(double temperature):
    _temperature = CelciusValue(temperature),
    _viewUnit = TemperatureUnit.celcius;

  TemperatureConvertion.fahrenheit(double temperature):
    _temperature = FahrenheitValue(temperature),
    _viewUnit = TemperatureUnit.fahrenheit;

  TemperatureConvertion.kelvin(double temperature):
   _temperature = KelvinValue(temperature),
    _viewUnit = TemperatureUnit.kelvin;

  set temperature(double value){
    _temperature.value = value;
  }

  TemperatureUnit get unit{
    return _temperature.unit;
  }
  double get value{
    return _temperature.value;
  }

  @override
  String toString(){
    return _temperature.toString();
  }

  set view(TemperatureUnit inUnit){
    _viewUnit = inUnit;
    _view.sink.add(viewTemperature);
  }

  String get viewTemperature{
    return as(_viewUnit).toString();
  }

  Stream<String> get stream{
    _view.sink.add(viewTemperature);
    return _view.stream;
  }

  TemperatureValue as(TemperatureUnit inUnit){
     return _temperature.to(inUnit);
  }

  String changeView(TemperatureUnit inUnit){
    view = inUnit;
    return viewTemperature;
  }
}

extension TemperatureUnitSuffix on TemperatureUnit{
  String get suffix {
    switch (this) {
      case TemperatureUnit.celcius:
        return "\u00B0C";
      case TemperatureUnit.fahrenheit:
        return "\u00B0F";
      case TemperatureUnit.kelvin:
        return " K";
      default:
        return "";
    }
  }

  TemperatureValue getValue(double value){
    switch (this) {
      case TemperatureUnit.celcius:
        return CelciusValue(value);
      case TemperatureUnit.fahrenheit:
        return FahrenheitValue(value);
      case TemperatureUnit.kelvin:
        return KelvinValue(value);
      default:
        return CelciusValue(value);
    }
  }
}