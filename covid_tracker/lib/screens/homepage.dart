import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_application_2/Services/world_stats.dart';
import 'package:flutter_application_2/screens/countries_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 7),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            FutureBuilder(
              future: statsServices.fetchWorldStatsApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: const Color.fromARGB(255, 239, 0, 0),
                        size: 60,
                        controller: _controller,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Expanded(
                    child: Center(
                      child: Text('No data available'),
                    ),
                  );
                } else {
                  final data = snapshot.data!;
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          'Total': double.parse(data.cases.toString()),
                          'Recovered': double.parse(data.recovered.toString()),
                          'Deaths': double.parse(data.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        chartRadius: 150,
                        animationDuration: const Duration(seconds: 3),
                        chartType: ChartType.ring,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                        child: Card(
                          color: const Color.fromARGB(255, 129, 126, 126),
                          child: Column(
                            children: [
                              ReusableCard(
                                  title: "Total cases", value: "${data.cases}"),
                              ReusableCard(
                                  title: "Recovered",
                                  value: "${data.recovered}"),
                              ReusableCard(
                                  title: "Deaths", value: "${data.deaths}"),
                              ReusableCard(
                                  title: "Active", value: "${data.active}"),
                              ReusableCard(
                                  title: "Critical", value: "${data.critical}"),
                              ReusableCard(
                                  title: "Cases today",
                                  value: "${data.todayCases}"),
                              ReusableCard(
                                  title: "Recovered today",
                                  value: "${data.todayRecovered}"),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CountriesList(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final String title;
  final String value;

  const ReusableCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
        ],
      ),
    );
  }
}
