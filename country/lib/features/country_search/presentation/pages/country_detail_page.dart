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
      body: Column(
        children: [
          // Flag Image with back button overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                  child:
                      country.flag.contains('.svg')
                          ? SvgPicture.network(country.flag, fit: BoxFit.cover)
                          : Image.network(country.flag, fit: BoxFit.cover),
                ),
              ),

              // Optional gradient overlay for better contrast
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // Back button
              Positioned(
                top: 40,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          // Details section
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Country name
                    Text(
                      country.name,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),

                    // Details
                    DetailView(
                      title: 'Area',
                      value:
                          '${country.area?.toStringAsFixed(0) ?? 'N/A'} sq km',
                    ),
                    DetailView(
                      title: 'Population',
                      value: '${country.population} million',
                    ),
                    DetailView(title: 'Region', value: country.region),
                    DetailView(
                      title: 'Sub Region',
                      value: country.subregion ?? 'N/A',
                    ),

                    const SizedBox(height: 24),
                    Text(
                      'Timezone',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Timezone chips
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children:
                          country.timezones?.map((tz) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: Colors.grey.shade100,
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                              ),
                              onPressed: () {},
                              child: Text(tz),
                            );
                          }).toList() ??
                          [const Text('N/A')],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
