import 'package:flutter/material.dart';
import 'dictionary_screen.dart';
import 'vocabulary_screen.dart';
import 'lesson_list_screen.dart';
import 'settings_screen.dart';
import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.appName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppConstants.backgroundColor, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                children: [
                  // App Logo & Welcome Message
                  _buildWelcomeHeader(),
                  const SizedBox(height: 30),
                  
                  // Search Arabic Words Button
                  _buildHomeButton(
                    context,
                    'Search Arabic Words',
                    Icons.search,
                    'Find meanings of Arabic words',
                    AppConstants.primaryColor,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DictionaryScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  
                  // Learn Arabic Vocabulary Button
                  _buildHomeButton(
                    context,
                    'Learn Arabic Vocabulary',
                    Icons.school,
                    'Daily vocabulary with examples',
                    AppConstants.secondaryColor,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VocabularyScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  
                  // Practice Daily Arabic Conversations Button
                  _buildHomeButton(
                    context,
                    'Practice Daily Arabic Conversations',
                    Icons.chat_bubble_outline,
                    'Real-life conversation lessons',
                    const Color(0xFF00A884),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LessonListScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  
                  // Settings Button
                  _buildHomeButton(
                    context,
                    'Settings',
                    Icons.settings,
                    'App settings, about, and support',
                    AppConstants.primaryColor,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Motivational Quote
                  _buildQuoteCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.menu_book,
              size: 45,
              color: AppConstants.primaryColor,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Welcome to',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          const Text(
            'Learn Arabic in English',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Your Journey to Arabic Begins Here',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeButton(
    BuildContext context,
    String title,
    IconData icon,
    String subtitle,
    Color color,
    VoidCallback onPressed,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 30, color: Colors.white),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteCard() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.format_quote,
            size: 40,
            color: AppConstants.accentColor,
          ),
          const SizedBox(height: 10),
          const Text(
            'Language is the road map of a culture. It tells you where its people come from and where they are going.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: AppConstants.lightTextColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '- Rita Mae Brown',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}