import 'package:expense/models/database_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      var total = db.calculateTotalExpense();
      return Row(
        children: [
          Expanded(
            flex: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Total Expense: ${NumberFormat.currency(
                      locale: 'en_IN',
                      symbol: '₹',
                    ).format(total)}',
                    // ignore: deprecated_member_use
                    textScaleFactor: 1.5,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ...list.map((e) => Padding(
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        children: [
                          Container(
                            width: 8.0,
                            height: 8.0,
                            color: Colors.primaries[list.indexOf(e)],
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(e.title),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                              '${((e.totalAmount / total) * 100).toStringAsFixed(2)}%')
                        ],
                      ),
                    )),
              ],
            ),
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
