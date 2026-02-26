
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpCenterApp extends StatelessWidget {
  const HelpCenterApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Removed MaterialApp wrapper here.
    // This widget should now be used directly in Navigator.push from the ProfileScreen.
    return const HelpCenterScreen();
  }
}

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Popular Topic', 'General', 'Services'];

  final List<Map<String, String>> _faqs = [
    {
      'question': 'How do I create a new account?',
      'answer': 'To create an account, click the "Sign Up" button on the homepage. You\'ll need to provide your email address and create a password. Once submitted, verify your email via the link we send you.',
      'category': 'Popular Topic'
    },
    {
      'question': 'How can I track my order status?',
      'answer': 'You can track your order by visiting the "Orders" section in your profile. Alternatively, use the tracking number sent to your email on our Tracking page.',
      'category': 'Popular Topic'
    },
    {
      'question': 'What is your refund policy?',
      'answer': 'We offer a 30-day money-back guarantee for most services. Please contact our support team with your order ID to initiate a refund request.',
      'category': 'Services'
    },
    {
      'question': 'Can I change my subscription plan?',
      'answer': 'Yes, you can upgrade or downgrade your plan at any time from the "Subscription" tab in your account settings.',
      'category': 'Services'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          _buildTabSwitcher(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFaqContent(),
                _buildContactContent(),
              ],
            ),
          ),
          // Home Indicator
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 5,
            width: 134,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xFF4D69FF),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    // Standard pop to return to the previous screen (ProfileScreen)
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
                ),
              ),
              const Text(
                'Help Center',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 48), // Symmetry spacer
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'How Can We Help You?',
            style: TextStyle(
              color: Color(0xFFDDE3FF),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Color(0xFF4D69FF)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Container(
        height: 54,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F5FF),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: const Color(0xFF4D69FF),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4D69FF).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF4D69FF),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          tabs: const [
            Tab(text: 'FAQ'),
            Tab(text: 'Contact Us'),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqContent() {
    final filteredFaqs = _faqs.where((f) => f['category'] == _categories[_selectedCategoryIndex]).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategoryIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF4D69FF) : const Color(0xFFF2F5FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF4D69FF) : Colors.transparent,
                      ),
                    ),
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF4D69FF),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: filteredFaqs.length,
              itemBuilder: (context, index) {
                final faq = filteredFaqs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F5FF).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        iconColor: const Color(0xFF4D69FF),
                        collapsedIconColor: const Color(0xFF4D69FF).withOpacity(0.5),
                        shape: const RoundedRectangleBorder(side: BorderSide.none),
                        title: Text(
                          faq['question']!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Text(
                              faq['answer']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildContactContent() {
    final List<Map<String, dynamic>> contactOptions = [
      {'label': 'Customer Service', 'icon': Icons.headset_mic, 'sub': 'Live chat with our support'},
      {'label': 'Website', 'icon': Icons.language, 'sub': 'Visit our official portal'},
      {'label': 'WhatsApp', 'icon': FontAwesomeIcons.whatsapp, 'sub': 'Instant message support'},
      {'label': 'Facebook', 'icon': FontAwesomeIcons.facebook, 'sub': 'Follow us for updates'},
      {'label': 'Instagram', 'icon': FontAwesomeIcons.instagram, 'sub': 'Share your experience'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: contactOptions.length,
      itemBuilder: (context, index) {
        final option = contactOptions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2F5FF).withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  option['icon'] as IconData,
                  color: const Color(0xFF4D69FF),
                  size: 20,
                ),
              ),
              title: Text(
                option['label'] as String,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              subtitle: Text(
                option['sub'] as String,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Color(0xFF4D69FF),
              ),
              onTap: () {
                // Action for contact options
              },
            ),
          ),
        );
      },
    );
  }
}
