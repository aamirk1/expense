import 'package:expense/models/database_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalChart extends StatefulWidget {
  const TotalChart({super.key});

  @override
  State<TotalChart> createState() => _TotalChartState();
}

class _TotalChartState extends State<TotalChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var list = db.categories;
      return Row(
        children: [
          const Expanded(
            flex: 60,
            child: Text('Chart'),
          ),
          Expanded(
            flex: 40,
            child: PieChart(PieChartData(
              centerSpaceRadius: 20,
              sections: list
                  .map((e) => PieChartSectionData(
                        showTitle: false,
                        value: e.totalAmount,
                        color: Colors.primaries[list.indexOf(e)],
                      ))
                  .toList(),
            )),
          )
        ],
      );
    });
  }
}
