abstract class CalculatorScreenState{}

class CalculatorScreenUpdateState extends CalculatorScreenState{
  final bool sterio;
  final int discretisation;
  final int dip;
  final int long;

  CalculatorScreenUpdateState({required this.sterio, required this.discretisation, required this.dip, required this.long});
}