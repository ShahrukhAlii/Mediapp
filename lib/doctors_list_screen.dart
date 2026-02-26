import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models.dart';
import '../constants.dart';
import '../widgets/doctor_card.dart';
import '../widgets/sort_bar.dart';
import 'doctor_info_screen.dart';
import 'favorites_screen.dart';
import 'ratings_screen.dart';
import 'gender_filter_screen.dart';

class DoctorsListScreen extends StatefulWidget {
  @override
  _DoctorsListScreenState createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  SortType _activeSort = SortType.az;
  int selectedBottomIndex = 0;

  void _handleSortChange(SortType type) {
    if (type == _activeSort) return;

    if (type == SortType.favorite) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesScreen(activeSort: type)));
    } else if (type == SortType.rating) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => RatingsScreen(activeSort: type)));
    } else if (type == SortType.female) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => GenderFilterScreen(gender: Gender.female, activeSort: type)));
    } else if (type == SortType.male) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => GenderFilterScreen(gender: Gender.male, activeSort: type)));
    } else {
      setState(() => _activeSort = type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: kPrimaryColor, size: 32),
          onPressed: () {
            // Returns specifically to the Home Screen
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
            'Doctors',
            style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 24
            )
        ),
        actions: [
          _AppAction(icon: Icons.search),
          _AppAction(icon: Icons.tune),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          SortBar(activeSort: _activeSort, onSortChange: _handleSortChange),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: kDoctors.length,
              itemBuilder: (context, index) => DoctorCard(
                doctor: kDoctors[index],
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DoctorInfoScreen(doctor: kDoctors[index]))
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 65,
      decoration: BoxDecoration(
        color: const Color(0xff2260FF),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItemSvg('../images/home.svg', 0),
          _navItemSvg('../images/msg.svg', 1),
          _navItemSvg('../images/profile.svg', 2),
          _navItemSvg('../images/caln.svg', 3),
        ],
      ),
    );
  }

  Widget _navItemSvg(String svgPath, int index) {
    final isSelected = selectedBottomIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => selectedBottomIndex = index);
        if (index == 0) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SvgPicture.asset(
          svgPath,
          height: 28,
          width: 28,
          color: isSelected ? Colors.white : Colors.white70,
        ),
      ),
    );
  }
}

class _AppAction extends StatelessWidget {
  final IconData icon;
  const _AppAction({required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: kLightBlueColor, shape: BoxShape.circle),
      child: Icon(icon, size: 20, color: kPrimaryColor),
    );
  }
}
