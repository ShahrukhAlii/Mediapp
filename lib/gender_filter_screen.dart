import 'package:flutter/material.dart';
import '../models.dart';
import '../constants.dart';
import '../widgets/doctor_card.dart';
import 'doctor_info_screen.dart';

class GenderFilterScreen extends StatelessWidget {
  final Gender gender;
  final SortType activeSort;

  const GenderFilterScreen({
    Key? key,
    required this.gender,
    this.activeSort = SortType.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = kDoctors.where((d) => d.gender == gender).toList();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: kPrimaryColor, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          gender == Gender.female ? 'Female Specialist' : 'Male Specialist',
          style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: filteredDoctors.isEmpty
          ? const Center(
        child: Text('No specialists found.', style: TextStyle(color: kTextSecondary)),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: filteredDoctors.length,
        itemBuilder: (context, index) => DoctorCard(
          doctor: filteredDoctors[index],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DoctorInfoScreen(doctor: filteredDoctors[index]),
            ),
          ),
        ),
      ),
    );
  }
}
