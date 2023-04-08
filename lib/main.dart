import 'package:flutter/material.dart';
import 'package:flutter_future_builder/view/pages/detail_page.dart';
import 'package:flutter_future_builder/view/widget/widget_drink.dart';

import 'data/drink.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Drink>>(
            // GA PERLU PAKAI INITSTATE
            // PAKAI FUTURE:
            future: Drink.fetchDrink(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final cocktails = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      height: 200,
                      color: Colors.red,
                    ),
                    Container(
                      height: 250,
                      // MEMBUAT LISTVIEW BUILDER
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cocktails.length,
                        itemBuilder: (context, index) {
                          final cocktail = cocktails[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailPage(
                                  name: cocktail.name,
                                  image: cocktail.thumb,
                                );
                              }));
                            },
                            child: Container(
                                width: 180,
                                decoration:
                                    const BoxDecoration(color: Colors.amber),
                                // AMBIL WIDGET DRINK
                                // UNTUK TAMPILKAN DRINK
                                child: WidgetDrink(
                                  name: cocktail.name,
                                  thumb: cocktail.thumb,
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                );
                // return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
