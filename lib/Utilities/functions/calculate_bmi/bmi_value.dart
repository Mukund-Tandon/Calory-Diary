import 'dart:math';
double BMIValue(int hieght, int weight){
  double bmi = ((weight*10000)/pow(hieght,2));
  return bmi;
}