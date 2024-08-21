import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/homepage.dart';
// import 'package:flutter_application_2/screens/homepage.dart';
// import 'package:pie_chart/pie_chart.dart';

class CountriesStats extends StatefulWidget {
  final String? name;
  final String? image;
  final int? totalCases, deaths, recovered, critical, todayCases, todayDeaths;

  CountriesStats({
    Key? key,
    this.name,
    this.image,
    this.deaths,
    this.todayCases,
    this.todayDeaths,
    this.recovered,
    this.totalCases,
    this.critical,
  }) : super(key: key);

  @override
  State<CountriesStats> createState() => _CountriesStatsState();
}

class _CountriesStatsState extends State<CountriesStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 47, 47),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 47, 47),
        title: Text(
          widget.name.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Set the color of the back arrow
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Card(
                  child: Column(
                    children: [
                      ReusableCard(
                          title: "Total cases",
                          value:
                              "${double.parse(widget.totalCases.toString())}"),
                      ReusableCard(
                          title: "Recovered",
                          value:
                              "${double.parse(widget.recovered.toString())}"),
                      ReusableCard(
                          title: "Deaths",
                          value: "${double.parse(widget.deaths.toString())}"),
                      ReusableCard(
                          title: "Critical",
                          value: "${double.parse(widget.critical.toString())}"),
                      ReusableCard(
                          title: "Cases today",
                          value:
                              "${double.parse(widget.todayCases.toString())}"),
                      ReusableCard(
                          title: "Recovered today",
                          value:
                              "${double.parse(widget.todayDeaths.toString())}"),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.image.toString()),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
