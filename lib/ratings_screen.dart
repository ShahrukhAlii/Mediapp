import 'package:flutter/material.dart';
import '../models.dart';
import '../constants.dart';
import '../widgets/doctor_card.dart';
import '../widgets/sort_bar.dart';
import 'doctor_info_screen.dart';
import 'favorites_screen.dart';
import 'gender_filter_screen.dart';

class RatingsScreen extends StatefulWidget {
  final SortType activeSort;

  const RatingsScreen({
    super.key,
    this.activeSort = SortType.rating,
  });

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  void _handleSortChange(SortType type) {
    // Accessing activeSort via widget.activeSort to ensure correct scoping in the State class
    if (type == widget.activeSort) return;

    if (type == SortType.az) {
      // Pop back to the initial list screen
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (type == SortType.favorite) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => FavoritesScreen(activeSort: type)),
      );
    } else if (type == SortType.female) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => GenderFilterScreen(gender: Gender.female, activeSort: type)),
      );
    } else if (type == SortType.male) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => GenderFilterScreen(gender: Gender.male, activeSort: type)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort doctors by rating in descending order for this specific view
    final ratedDoctors = List<Doctor>.from(kDoctors);
    ratedDoctors.sort((a, b) => b.rating.compareTo(a.rating));

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: kPrimaryColor, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Top Rated',
          style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 24
          ),
        ),
      ),
      body: Column(
        children: [
          SortBar(
            activeSort: widget.activeSort,
            onSortChange: _handleSortChange,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Excellence in Care',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          Text(
                            'Based on patient reviews',
                            style: TextStyle(color: Colors.white70, fontSize: 10),
                          ),
                        ],
                      ),
                      Icon(Icons.star, color: Colors.white, size: 28),
                    ],
                  ),
                ),
                ...ratedDoctors.map((doctor) => DoctorCard(
                  key: ValueKey(doctor.id),
                  doctor: doctor,
                  showRating: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DoctorInfoScreen(doctor: doctor)),
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
