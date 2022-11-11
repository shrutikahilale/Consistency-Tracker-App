import 'package:flutter/material.dart';
import 'package:practice3/barchart.dart';
import 'package:google_fonts/google_fonts.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map mp = ModalRoute.of(context)!.settings.arguments as Map;
    double sum = double.parse(mp['sum']);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Consistency Tracker',
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              margin: const EdgeInsets.only(top: 50.0),
              child: Text(
                'Your Consistency graph this week',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w800,
                  fontSize: 30.0,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4, 30, 30, 10),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: AspectRatio(
                aspectRatio: 1.3,
                child: BarChartWidget(),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Text(
                    'Total hours worked this week: ',
                    style: GoogleFonts.lato(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  (sum.toStringAsPrecision(2)),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
