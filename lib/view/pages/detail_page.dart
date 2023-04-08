import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_future_builder/data/detail.dart';

class DetailPage extends StatefulWidget {
  final String name;
  final String image;
  const DetailPage({super.key, required this.name, required this.image});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final String gelas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: FutureBuilder<List<Detail>>(
          // GA PERLU PAKAI INITSTATE
          // PAKAI FUTURE:
          future: Detail.fetchDetail(widget.name),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final details = snapshot.data!;
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.amber,
                  ),
                  Container(
                    height: 700,
                    color: Colors.red,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: details.length,
                      itemBuilder: (context, index) {
                        final detail = details[index];
                        return Column(
                          children: [
                            Image.network(widget.image),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.amber,
                              ),
                            ),
                            Text(detail.glass),
                          ],
                        );
                      },
                    ),
                  )
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
    );
  }
}
