// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  double sum = 0;
  List<double> heights = [];
  List<BarChartGroupData> barChartGroupData = [];
  List<Color> barRodColor = List.generate(7, (index) => Colors.white);

  // CollectionReference hrs = FirebaseFirestore.instance.collection('_hours');

  // from current user -> get email -> go to that user document -> get hours collection
  CollectionReference hrs =
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).collection('hours');

  LoadingScreen({super.key});

  // getdata from firestore
  Future<void> getData() async {
    //
    for (int i = 0; i < 7; i++) {
      await hrs
          .doc(i.toString())
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map mp = documentSnapshot.data() as Map;
          heights.add(double.parse(mp['hours'].toString()));
        }
      });
    }
  }

  // get index of last bar which is empty
  int getLastBar() {
    // week starts from 1
    return (DateTime.now().weekday - 1);
  }

  // set up chart list
  setupChartList() {
    // get last index
    int idx = getLastBar();
    barRodColor[idx] = Colors.lightGreen;

    // set up list<barchartgroupdata>
    for (int i = 0; i < 7; i++) {
      sum += heights[i];

      barChartGroupData.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: heights[i],
              color: barRodColor[i],
              width: 5,
              backDrawRodData: BackgroundBarChartRodData(
                toY: 15,
                show: true,
                color: const Color.fromARGB(62, 158, 158, 158),
              ),
            )
          ],
        ),
      );
    }
  }

  // update the firestore data and chartlist
  updateDatainFS(double input) {
    String today = (DateTime.now().weekday - 1).toString();
    hrs.doc(today).update({'hours': input});
  }

  List<BarChartGroupData> getChart() {
    return barChartGroupData;
  }

  // clear records on monday
  clearRecords() async {
    for (int i = 0; i < 7; i++) {
      await hrs.doc(i.toString()).update({'hours': 0});
    }
  }

  // update data in firestore then get data (update heights list), setup chart list and navigate to chartscreen
  setUp(BuildContext context, double input) async {
    // if today is monday then clear all graph
    if (DateTime.now().weekday == 1) {
      await clearRecords();
    }

    // update in firestore database
    await updateDatainFS(input);

    // get updated data
    await getData();

    // set up chartdata list
    await setupChartList();

    // navigate to charts screen
    Navigator.popAndPushNamed(context, '/chart', arguments: {
      'barChartGroupData': barChartGroupData,
      'sum': sum.toString(),
    });
  }

  // after getting data from database, setup chart list and navigate to chartscreen
  showGraph(BuildContext context) async {
    // get data from firestore database
    await getData();

    // set up chart data list
    await setupChartList();

    // navigate to charts screen
    Navigator.popAndPushNamed(context, '/chart', arguments: {
      'barChartGroupData': barChartGroupData,
      'sum': sum.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    Map mp = ModalRoute.of(context)!.settings.arguments as Map;

    if (mp['input'] == 0) {
      // when view graph only
      showGraph(context);
    } else {
      // on getting input
      setUp(context, double.parse(mp['input']));
    }

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 0, 54),
      ),
      child: const Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
