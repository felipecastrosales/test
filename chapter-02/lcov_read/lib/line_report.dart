class LineReport {
  LineReport({
    required this.sourceFile,
    required this.lineFound,
    required this.lineHit,
  });

  final String sourceFile;
  final int lineFound, lineHit;
}
