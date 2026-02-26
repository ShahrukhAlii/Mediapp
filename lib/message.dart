
import 'package:flutter/material.dart';



class MediConnectApp extends StatelessWidget {
  const MediConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediConnect Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          primary: const Color(0xFF2563EB),
        ),
        fontFamily: 'Inter',
      ),
      home: const NotificationScreen(),
    );
  }
}

enum NotificationType { appointment, change, notes, history }

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final String time;
  final String date;
  final bool isUnread;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    required this.date,
    required this.isUnread,
  });
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static final List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      type: NotificationType.appointment,
      title: 'Scheduled Appointment',
      description: 'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      time: '2 M',
      date: 'Today',
      isUnread: false,
    ),
    NotificationItem(
      id: '2',
      type: NotificationType.change,
      title: 'Scheduled Change',
      description: 'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      time: '2 H',
      date: 'Today',
      isUnread: true,
    ),
    NotificationItem(
      id: '3',
      type: NotificationType.notes,
      title: 'Medical Notes',
      description: 'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      time: '3 H',
      date: 'Today',
      isUnread: false,
    ),
    NotificationItem(
      id: '4',
      type: NotificationType.appointment,
      title: 'Scheduled Appointment',
      description: 'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      time: '1 D',
      date: 'Yesterday',
      isUnread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF2563EB), size: 32),
          onPressed: () {},
        ),
        title: const Text(
          'Notification',
          style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Text('News', style: TextStyle(color: Color(0xFF2563EB), fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF2563EB), shape: BoxShape.circle)),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text('Today', style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Mark all', style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) {
                if (index == 2) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Text('Yesterday', style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
              itemBuilder: (context, index) {
                final item = notifications[index];
                return InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
                  child: Container(
                    color: item.isUnread ? Colors.blue.shade50.withOpacity(0.5) : Colors.transparent,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIcon(item.type),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text(item.time, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.description,
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 14, height: 1.4),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(NotificationType type) {
    IconData iconData;
    switch (type) {
      case NotificationType.appointment:
      case NotificationType.change:
        iconData = Icons.calendar_today;
        break;
      case NotificationType.notes:
        iconData = Icons.description;
        break;
      case NotificationType.history:
        iconData = Icons.chat_bubble_outline;
        break;
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(color: const Color(0xFF2563EB).withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Icon(iconData, color: Colors.white, size: 20),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Dr. Olivia Turner',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          _buildAppBarAction(Icons.phone),
          const SizedBox(width: 12),
          _buildAppBarAction(Icons.videocam),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildMessageBubble(
                  "lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  isDoctor: true,
                  time: "09:00",
                ),
                _buildMessageBubble(
                  "lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  isDoctor: false,
                  time: "09:30",
                ),
                _buildVoiceBubble("02:50", "09:50"),
                _buildMessageBubble(
                  "lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  isDoctor: false,
                  time: "09:55",
                ),
              ],
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildAppBarAction(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon, color: const Color(0xFF2563EB), size: 20),
    );
  }

  Widget _buildMessageBubble(String text, {required bool isDoctor, required String time}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: isDoctor ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: isDoctor ? Colors.grey.shade50 : Colors.blue.shade50,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: isDoctor ? Radius.zero : const Radius.circular(20),
                bottomRight: isDoctor ? const Radius.circular(20) : Radius.zero,
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5, offset: const Offset(0, 2)),
              ],
            ),
            child: Text(text, style: const TextStyle(fontSize: 14, height: 1.4)),
          ),
          const SizedBox(height: 4),
          Text(time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildVoiceBubble(String duration, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/seed/doc/100/100'),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                const Icon(Icons.play_arrow, color: Color(0xFF2563EB)),
                const SizedBox(width: 8),
                Container(
                  width: 120,
                  height: 4,
                  decoration: BoxDecoration(color: const Color(0xFF2563EB), borderRadius: BorderRadius.circular(2)),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: 0,
                        top: -4,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(color: Color(0xFF2563EB), shape: BoxShape.circle, border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2))),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(duration, style: const TextStyle(color: Color(0xFF2563EB), fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blue.shade50,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.link, color: Color(0xFF2563EB)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Write Here...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.mic, color: Color(0xFF2563EB)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF2563EB),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Color(0xFF2563EB), blurRadius: 10, offset: Offset(0, 4))],
            ),
            child: const Icon(Icons.send, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
