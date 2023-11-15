import 'package:bmi_dart_console/bmi_dart_console.dart' as bmi_dart_console;
import 'dart:io';
import 'dart:math';

class BmiCalculator {
  final double weight;
  final double height;

  const BmiCalculator({required this.weight, required this.height});

  double calculateBmi() {
    return weight / (height * height);
  }

  String getInterpretation() {
    double bmi = calculateBmi();
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}

void main() {
  // Create a new BMI calculator object.
  print('enter weight\n');
  double wt = double.parse(stdin.readLineSync()!);

  print('enter height\n');
  double ht = double.parse(stdin.readLineSync()!);
  final bmiCalculator = BmiCalculator(weight: wt, height: ht);

  double bmi = bmiCalculator.calculateBmi();

  String interpretation = bmiCalculator.getInterpretation();

  print('BMI: $bmi');
  print('Interpretation: $interpretation');
}
