
import 'package:flutter/material.dart';
import '../models.dart';
import '../constants.dart';

class DoctorInfoScreen extends StatelessWidget {
  final Doctor doctor;
  const DoctorInfoScreen({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.chevron_left, color: kPrimaryColor, size: 32), onPressed: () => Navigator.pop(context)),
        title: Text('Doctor Info', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: kLightBlueColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(radius: 60, backgroundImage: NetworkImage(doctor.imageUrl), backgroundColor: Colors.white),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(20)),
                              child: Text('${doctor.experience} years\nexperience', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(20)),
                              child: Text('Focus: ${doctor.focus}', style: TextStyle(color: Colors.white, fontSize: 10)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text(doctor.name, style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(doctor.specialty, style: TextStyle(color: kTextSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatBadge(icon: Icons.star, value: doctor.rating.toString()),
                      _StatBadge(icon: Icons.message, value: doctor.reviews.toString()),
                      _StatBadge(icon: Icons.access_time, value: doctor.schedule),
                    ],
                  ),
                ],
              ),
            ),
            _InfoSection(title: 'Profile', content: doctor.profile),
            _InfoSection(title: 'Career Path', content: doctor.careerPath),
            _InfoSection(title: 'Highlights', content: doctor.highlights),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  const _StatBadge({required this.icon, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(children: [Icon(icon, size: 12, color: kPrimaryColor), SizedBox(width: 4), Text(value, style: TextStyle(color: kPrimaryColor, fontSize: 10, fontWeight: FontWeight.bold))]),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final String content;
  const _InfoSection({required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 4),
        Text(content, style: TextStyle(color: kTextSecondary, fontSize: 14, height: 1.5)),
      ]),
    );
  }
}
