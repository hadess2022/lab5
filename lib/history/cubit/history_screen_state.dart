abstract class HistoryScreenState{}

class HistoryScreenUpdateState extends HistoryScreenState{
  final bool sterio;
  final int discretisation;
  final int dip;
  final int long;

  HistoryScreenUpdateState({required this.sterio, required this.discretisation, required this.dip, required this.long});
}