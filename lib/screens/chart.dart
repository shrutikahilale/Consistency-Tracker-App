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
                color: const Color.fromARGB(37, 255, 255, 255),
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
                    'Consistent hours this week: ',
                    style: GoogleFonts.lato(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  (sum.toStringAsPrecision(2)),
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Back to Home'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
