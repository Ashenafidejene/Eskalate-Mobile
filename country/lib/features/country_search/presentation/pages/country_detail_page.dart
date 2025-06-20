import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/country.dart';
import '../widgets/detail_view.dart';

class CountryDetailPage extends StatelessWidget {
  final Country country;

  const CountryDetailPage({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child:
                  country.flag.contains('.svg')
                      ? SvgPicture.network(country.flag)
                      : Image.network(country.flag),
            ),
            DetailView(
              title: 'Area',
              value: '${country.area?.toStringAsFixed(0) ?? 'N/A'} sq km',
            ),
            DetailView(
              title: 'Population',
              value: '${country.population.toString()} million',
            ),
            DetailView(title: 'Region', value: country.region),
            DetailView(title: 'Sub Region', value: country.subregion ?? 'N/A'),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Timezone',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              spacing: 8,
              children:
                  country.timezones
                      ?.map((tz) => Chip(label: Text(tz)))
                      .toList() ??
                  [const Text('N/A')],
            ),
          ],
        ),
      ),
    );
  }
}
