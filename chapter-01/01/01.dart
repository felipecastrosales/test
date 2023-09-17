import 'dart:math';

void main() {
  final result = calcIMC(1.83, 76.0);

  if (result == 22.694018931589476) {
    print('Maybe IMC from Felipe Sales');
  } else {
    print('IMC from another person');
  }

  print('-------------------------------------------------------------------');

  try {
    print('Height less than 1');
    calcIMC(0, 80);
  } catch (e) {
    print('Catching another value without height less than 1');
    calcIMC(1.80, 80);
  }

  print('-------------------------------------------------------------------');

  try {
    print('Weight less than 1');
    calcIMC(1.80, 0);
  } catch (e) {
    print('Catching another value without height less than 1');
    calcIMC(1.80, 80);
  }

  print('-------------------------------------------------------------------');

  print(result);
}

double calcIMC(double height, double weight) {
  if (height < 1) {
    throw Exception('Your height need be more than 1');
  }

  if (weight < 1) {
    throw Exception('Your weight need be more than 1');
  }

  return weight / pow(height, 2);
}
