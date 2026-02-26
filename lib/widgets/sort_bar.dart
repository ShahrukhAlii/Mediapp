
import 'package:flutter/material.dart';
import '../models.dart';
import '../constants.dart';

class SortBar extends StatelessWidget {
  final SortType activeSort;
  final Function(SortType) onSortChange;

  const SortBar({required this.activeSort, required this.onSortChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Center(child: Text('Sort By', style: TextStyle(color: kTextSecondary, fontSize: 12))),
          SizedBox(width: 8),
          _SortItem(type: SortType.az, label: 'A-Z', activeSort: activeSort, onTap: onSortChange),
          _SortItem(type: SortType.rating, icon: Icons.star, activeSort: activeSort, onTap: onSortChange),
          _SortItem(type: SortType.favorite, icon: Icons.favorite, activeSort: activeSort, onTap: onSortChange),
          _SortItem(type: SortType.female, icon: Icons.woman, activeSort: activeSort, onTap: onSortChange),
          _SortItem(type: SortType.male, icon: Icons.man, activeSort: activeSort, onTap: onSortChange),
        ],
      ),
    );
  }
}

class _SortItem extends StatelessWidget {
  final SortType type;
  final String? label;
  final IconData? icon;
  final SortType activeSort;
  final Function(SortType) onTap;

  const _SortItem({required this.type, this.label, this.icon, required this.activeSort, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isActive = activeSort == type;
    return GestureDetector(
      onTap: () => onTap(type),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? kPrimaryColor : kLightBlueColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: label != null
              ? Text(label!, style: TextStyle(color: isActive ? Colors.white : kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 12))
              : Icon(icon, size: 16, color: isActive ? Colors.white : kPrimaryColor),
        ),
      ),
    );
  }
}
