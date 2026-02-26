
import 'package:flutter/material.dart';



// --- Models ---
enum AppointmentStatus { complete, upcoming, cancelled }

class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final String imageUrl;
  final bool isFavorite;

  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

class Appointment {
  final String id;
  final Doctor doctor;
  final AppointmentStatus status;
  final String date;
  final String time;

  Appointment({
    required this.id,
    required this.doctor,
    required this.status,
    required this.date,
    required this.time,
  });
}

// --- Mock Data ---
final List<Doctor> doctors = [
  Doctor(
    name: 'Dr. Olivia Turner, M.D.',
    specialty: 'Dermato-Endocrinology',
    rating: 5.0,
    imageUrl: 'https://i.pravatar.cc/150?u=olivia',
    isFavorite: true,
  ),
  Doctor(
    name: 'Dr. Alexander Bennett, Ph.D.',
    specialty: 'Dermato-Genetics',
    rating: 4.0,
    imageUrl: 'https://i.pravatar.cc/150?u=alex',
  ),
  Doctor(
    name: 'Dr. Sophia Martinez, Ph.D.',
    specialty: 'Cosmetic Bioengineering',
    rating: 5.0,
    imageUrl: 'https://i.pravatar.cc/150?u=sophia',
  ),
];

final List<Appointment> initialAppointments = [
  Appointment(
    id: 'a1',
    doctor: doctors[0],
    status: AppointmentStatus.complete,
    date: 'Sunday, 12 June',
    time: '9:30 AM - 10:00 AM',
  ),
  Appointment(
    id: 'a2',
    doctor: doctors[1],
    status: AppointmentStatus.upcoming,
    date: 'Friday, 20 June',
    time: '2:30 PM - 3:00 PM',
  ),
  Appointment(
    id: 'a3',
    doctor: doctors[2],
    status: AppointmentStatus.cancelled,
    date: 'Tuesday, 15 June',
    time: '9:30 AM - 10:00 AM',
  ),
  Appointment(
    id: 'a4',
    doctor: doctors[0],
    status: AppointmentStatus.upcoming,
    date: 'Sunday, 12 June',
    time: '9:30 AM - 10:00 AM',
  ),
];

// --- Screens ---

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  AppointmentStatus activeTab = AppointmentStatus.complete;
  List<Appointment> appointments = initialAppointments;

  @override
  Widget build(BuildContext context) {
    final filtered = appointments.where((a) => a.status == activeTab).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'All Appointment',
          style: TextStyle(
            color: Color(0xFF0056D2),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTab('Complete', AppointmentStatus.complete),
                  const SizedBox(width: 8),
                  _buildTab('Upcoming', AppointmentStatus.upcoming),
                  const SizedBox(width: 8),
                  _buildTab('Cancelled', AppointmentStatus.cancelled),
                ],
              ),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
              child: Text(
                'No ${activeTab.name} appointments',
                style: const TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filtered.length,
              itemBuilder: (context, index) =>
                  _buildDoctorCard(filtered[index]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[100]!, width: 1)),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 28), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today, size: 24), label: 'Appointment'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 28), label: 'Profile'),
          ],
          currentIndex: 1,
          selectedItemColor: const Color(0xFF0056D2),
          unselectedItemColor: Colors.grey[300],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          unselectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
      ),
    );
  }

  Widget _buildTab(String label, AppointmentStatus status) {
    final isSelected = activeTab == status;
    return GestureDetector(
      onTap: () => setState(() => activeTab = status),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0056D2) : const Color(0xFFE9F0FF),
          borderRadius: BorderRadius.circular(30),
          boxShadow: isSelected
              ? [
            BoxShadow(
                color: const Color(0xFF0056D2).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF5D9BFF),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(Appointment appointment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD9E6FF),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05), blurRadius: 10)
                  ],
                ),
                child: CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage(appointment.doctor.imageUrl),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctor.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003D99),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      appointment.doctor.specialty,
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    if (appointment.status != AppointmentStatus.cancelled) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 14, color: Color(0xFF0056D2)),
                                const SizedBox(width: 4),
                                Text(
                                  appointment.doctor.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0056D2),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.favorite,
                                size: 16, color: Color(0xFF0056D2)),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (appointment.status == AppointmentStatus.upcoming) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoChip(Icons.calendar_today, appointment.date),
                const SizedBox(width: 8),
                _buildInfoChip(Icons.access_time, appointment.time),
              ],
            ),
          ],
          const SizedBox(height: 20),
          Row(
            children: _buildActions(appointment),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: const Color(0xFF0056D2)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF0056D2),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions(Appointment app) {
    if (app.status == AppointmentStatus.complete) {
      return [
        Expanded(
          child: _buildButton('Re-Book', Colors.white, const Color(0xFF0056D2)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildButton('Add Review', const Color(0xFF0056D2), Colors.white,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ReviewScreen(doctor: app.doctor)));
              }),
        ),
      ];
    } else if (app.status == AppointmentStatus.upcoming) {
      return [
        Expanded(
          flex: 2,
          child: _buildButton('Details', const Color(0xFF0056D2), Colors.white),
        ),
        const SizedBox(width: 10),
        _buildCircleAction(Icons.check),
        const SizedBox(width: 10),
        _buildCircleAction(Icons.close, onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CancelScreen()));
        }),
      ];
    } else {
      return [
        Expanded(
          child: _buildButton('Add Review', const Color(0xFF0056D2), Colors.white,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ReviewScreen(doctor: app.doctor)));
              }),
        ),
      ];
    }
  }

  Widget _buildButton(String text, Color bg, Color textCol,
      {VoidCallback? onTap}) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: textCol,
          elevation: 0,
          shape: const StadiumBorder(),
          padding: EdgeInsets.zero,
        ),
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }

  Widget _buildCircleAction(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration:
        const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon, color: const Color(0xFF0056D2), size: 22),
      ),
    );
  }
}

// --- Cancellation Screen ---
class CancelScreen extends StatefulWidget {
  const CancelScreen({super.key});

  @override
  State<CancelScreen> createState() => _CancelScreenState();
}

class _CancelScreenState extends State<CancelScreen> {
  String selectedReason = 'Weather Conditions';

  @override
  Widget build(BuildContext context) {
    final reasons = [
      'Rescheduling',
      'Weather Conditions',
      'Unexpected Work',
      'Others'
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cancel Appointment',
            style: TextStyle(
                color: Color(0xFF0056D2),
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xFF0056D2), size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please select the reason for your cancellation. Your feedback helps us improve our scheduling process.',
                  style:
                  TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 32),
                ...reasons.map((r) => _buildRadioItem(r)),
                const SizedBox(height: 32),
                const Text(
                  'Any additional comments regarding your cancellation? This is optional but appreciated.',
                  style: TextStyle(
                      color: Color(0xFFA5C9FF), fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F6FF),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: const Color(0xFFE9F0FF)),
                    ),
                    child: const TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Reason Here...',
                        border: InputBorder.none,
                        hintStyle:
                        TextStyle(color: Color(0xFFA5C9FF), fontSize: 15),
                      ),
                      style: TextStyle(color: Color(0xFF0056D2), fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0056D2),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  elevation: 8,
                  shadowColor: const Color(0xFF0056D2).withOpacity(0.4),
                ),
                child: const Text('Cancel Appointment',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioItem(String label) {
    final isSelected = selectedReason == label;
    return GestureDetector(
      onTap: () => setState(() => selectedReason = label),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F6FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Radio<String>(
                value: label,
                groupValue: selectedReason,
                activeColor: const Color(0xFF0056D2),
                onChanged: (val) => setState(() => selectedReason = val!),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 17,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: const Color(0xFF003D99),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Review Screen ---
class ReviewScreen extends StatelessWidget {
  final Doctor doctor;
  const ReviewScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Review',
            style: TextStyle(
                color: Color(0xFF0056D2),
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xFF0056D2), size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  'How was your appointment experience? Your reviews help our doctors improve and help patients choose.',
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 5)
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(doctor.imageUrl),
                  ),
                ),
                const SizedBox(height: 24),
                Text(doctor.name,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0056D2))),
                const SizedBox(height: 4),
                Text(doctor.specialty,
                    style: const TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFFE9F0FF),
                      child:
                      Icon(Icons.favorite, color: Color(0xFF0056D2), size: 22),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F0FF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: List.generate(
                            5,
                                (i) => Icon(
                              Icons.star,
                              size: 24,
                              color: i < 4
                                  ? const Color(0xFF0056D2)
                                  : const Color(0xFFA5C9FF),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  height: 180,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F6FF),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: const Color(0xFFE9F0FF)),
                  ),
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Comment Here...',
                      border: InputBorder.none,
                      hintStyle:
                      TextStyle(color: Color(0xFFA5C9FF), fontSize: 15),
                    ),
                    style: TextStyle(color: Color(0xFF0056D2), fontSize: 15),
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0056D2),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  elevation: 8,
                  shadowColor: const Color(0xFF0056D2).withOpacity(0.4),
                ),
                child: const Text('Add Review',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

