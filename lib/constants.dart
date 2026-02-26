
import 'package:flutter/material.dart';
import 'models.dart';

const Color kPrimaryColor = Color(0xFF2B64F6);
const Color kLightBlueColor = Color(0xFFD1E0FF);
const Color kBackgroundColor = Color(0xFFF8FAFF);
const Color kTextSecondary = Color(0xFF64748B);

final List<Doctor> kDoctors = [
  Doctor(
    id: '1',
    name: 'Dr. Alexander Bennett, Ph.D.',
    specialty: 'Dermato-Genetics',
    gender: Gender.male,
    rating: 5.0,
    reviews: 40,
    experience: 15,
    focus: 'Hormonal imbalances on skin conditions.',
    schedule: 'Mon-Sat / 9:00AM - 5:00PM',
    profile: 'Dr. Bennett is a leading expert in the field of Dermato-Genetics.',
    careerPath: 'PhD at Johns Hopkins, researcher at ISRI.',
    highlights: 'Published over 30 peer-reviewed articles.',
    imageUrl: 'https://picsum.photos/id/64/300/300',
    isFavorite: true,
  ),
  Doctor(
    id: '2',
    name: 'Dr. Olivia Turner, M.D.',
    specialty: 'Dermato-Endocrinology',
    gender: Gender.female,
    rating: 5.0,
    reviews: 55,
    experience: 18,
    focus: 'Hormonal influences on skin health.',
    schedule: 'Mon-Thu / 8:00AM - 4:00PM',
    profile: 'Dr. Turner bridges the gap between endocrinology and dermatology.',
    careerPath: 'Former Head of Endocrinology at Metro General.',
    highlights: 'Global Excellence Award Recipient.',
    imageUrl: 'https://picsum.photos/id/177/300/300',
    isFavorite: true,
  ),
];

final List<Service> kServices = [
  Service(
    id: 's1',
    title: 'Dermato-Endocrinology',
    description: 'Specialized treatment for skin issues caused by hormonal changes.',
  ),
  Service(
    id: 's2',
    title: 'Cosmetic Bioengineering',
    description: 'Using advanced bio-materials to restore skin elasticity.',
  ),
];
