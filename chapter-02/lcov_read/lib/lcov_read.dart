import 'dart:io';

import 'package:lcov_read/line_report.dart';

void main(List<String> arguments) {
  final result = coverage(arguments[0]);
  print(result);
}

String coverage(String lcovPath) {
  final file = File(lcovPath);
  final content = file.readAsLinesSync();
  final reports = <LineReport>[];

  var sf = '';
  var lf = 0;
  var lh = 0;

  for (final item in content) {
    if (item == 'end_of_record') {
      final report = LineReport(sourceFile: sf, lineFound: lf, lineHit: lh);
      reports.add(report);
      continue;
    }

    final line = item.split(':');

    if (line[0] == 'SF') {
      sf = line[1];
    } else if (line[0] == 'LF') {
      lf = int.parse(line[1]);
    } else if (line[0] == 'LH') {
      lh = int.parse(line[1]);
    }
  }

  int totalLF = 0;
  int totalLH = 0;

  for (var report in reports) {
    totalLF += report.lineFound;
    totalLH += report.lineHit;
  }

  final percent = (totalLH / totalLF) * 100;
  print('percent is: $percent - $totalLH - $totalLF');

  return '$percent%';
}
