import 'package:flutter/material.dart';
import 'package:flutter_application_2/Services/world_stats.dart';
import 'package:flutter_application_2/screens/countries_stats.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatsServices statsService = StatsServices();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 47, 47),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 47, 47),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Set the color of the back arrow
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 20, 20, 20),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter the country name",
                  hintStyle: const TextStyle(fontSize: 17, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Using Flexible here instead of Expanded
            Flexible(
              child: FutureBuilder(
                future: statsService.fetchCountries(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: Color.fromARGB(255, 239, 0, 0),
                        size: 60,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    var countries = snapshot.data as List;
                    return ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (name
                            .toLowerCase()
                            .contains(_controller.text.toLowerCase())) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CountriesStats(
                                          name: snapshot.data![index]
                                              ['country'],
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          deaths: snapshot.data![index]
                                              ['deaths'],
                                          todayCases: snapshot.data![index]
                                              ['todayCases'],
                                          todayDeaths: snapshot.data![index]
                                              ['todayDeaths'],
                                          recovered: snapshot.data![index]
                                              ['recovered'],
                                          totalCases: snapshot.data![index]
                                              ['cases'],
                                          critical: snapshot.data![index]
                                              ['critical'])));
                            },
                            title: Text(
                              snapshot.data![index]['country'],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            subtitle: Text(
                              snapshot.data![index]['cases'].toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 172, 169, 169)),
                            ),
                            leading: Image.network(
                              countries[index]['countryInfo']['flag'],
                              width: 50,
                              height: 50,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
