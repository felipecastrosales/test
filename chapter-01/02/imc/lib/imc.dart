import 'dart:math';

double calcIMC(double height, double weight) {
  if (height < 1) {
    throw Exception('Your height need be more than 1');
  }

  if (weight < 1) {
    throw Exception('Your weight need be more than 1');
  }

  return weight / pow(height, 2);
}
