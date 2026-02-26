import 'package:flutter/material.dart';
import '../models.dart';
import '../constants.dart';
import '../widgets/doctor_card.dart';
import 'doctor_info_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final SortType activeSort;

  const FavoritesScreen({
    Key? key,
    this.activeSort = SortType.favorite,
  }) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isDoctorsTab = true;
  String? _expandedServiceId;

  @override
  Widget build(BuildContext context) {
    final favorites = kDoctors.where((d) => d.isFavorite).toList();

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
          'Favorite',
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: kPrimaryColor), onPressed: () {}),
          IconButton(icon: const Icon(Icons.tune, color: kPrimaryColor), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: kLightBlueColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  _TabButton(
                    label: 'Doctors',
                    isActive: _isDoctorsTab,
                    onTap: () => setState(() => _isDoctorsTab = true),
                  ),
                  _TabButton(
                    label: 'Services',
                    isActive: !_isDoctorsTab,
                    onTap: () => setState(() => _isDoctorsTab = false),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _isDoctorsTab ? _buildDoctorsList(favorites) : _buildServicesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsList(List<Doctor> doctors) {
    if (doctors.isEmpty) {
      return const Center(
        child: Text("No favorite doctors yet"),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: doctors.length,
      itemBuilder: (context, index) => DoctorCard(
        doctor: doctors[index],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorInfoScreen(doctor: doctors[index]),
          ),
        ),
      ),
    );
  }

  Widget _buildServicesList() {
    if (kServices.isEmpty) {
      return const Center(
        child: Text("No services available"),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: kServices.length,
      itemBuilder: (context, index) {
        final service = kServices[index];
        final isExpanded = _expandedServiceId == service.id;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: kLightBlueColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  service.title,
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                trailing: Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: kPrimaryColor,
                ),
                onTap: () => setState(() => _expandedServiceId = isExpanded ? null : service.id),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.description,
                        style: const TextStyle(color: kTextSecondary, fontSize: 12, height: 1.4),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'LEARN MORE',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? kPrimaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? Colors.white : kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
