import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../controllers/lesson_controller.dart';
import '../models/lesson_model.dart';
import 'lesson_detail_screen.dart';
import '../utils/constants.dart';

class LessonListScreen extends StatefulWidget {
  const LessonListScreen({super.key});

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  final LessonController _controller = LessonController();
  final TextEditingController _searchController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  List<Lesson> _filteredLessons = [];
  String _selectedCategory = 'All';
  bool _isSpeaking = false;
  String? _currentPlayingTitle;
  bool _isTtsAvailable = true;

  final List<String> _categories = [
    'All',
    'Greetings',
    'Conversations',
    'Travel',
    'Daily Life',
  ];

  @override
  void initState() {
    super.initState();
    _filteredLessons = _controller.lessons;
    _initTts();
  }

  Future<void> _initTts() async {
    try {
      await _flutterTts.awaitSpeakCompletion(true);
      
      bool arabicSet = false;
      List<String> arabicCodes = ["ar-SA", "ar-EG", "ar", "ar-AE", "ar-LB"];
      
      for (String code in arabicCodes) {
        try {
          var result = await _flutterTts.setLanguage(code);
          if (result == 1 || result == true) {
            arabicSet = true;
            print('LessonList: Successfully set Arabic language to: $code');
            break;
          }
        } catch (e) {
          print('LessonList: Failed to set language $code: $e');
        }
      }
      
      if (!arabicSet) {
        setState(() {
          _isTtsAvailable = false;
        });
      } else {
        setState(() {
          _isTtsAvailable = true;
        });
      }
      
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setVolume(1.0);
      
      _flutterTts.setCompletionHandler(() {
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingTitle = null;
          });
        }
      });
      
      _flutterTts.setErrorHandler((msg) {
        print('LessonList TTS Error: $msg');
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingTitle = null;
          });
        }
      });
      
      _flutterTts.setStartHandler(() {
        if (mounted) {
          setState(() {
            _isSpeaking = true;
          });
        }
      });
      
      _flutterTts.setCancelHandler(() {
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingTitle = null;
          });
        }
      });
      
    } catch (e) {
      print('LessonList TTS Initialization Error: $e');
      setState(() {
        _isTtsAvailable = false;
      });
    }
  }

  Future<void> _speakTitle(String title, String lessonId) async {
    if (!_isTtsAvailable) {
      _showInstallDialog();
      return;
    }
    
    if (_isSpeaking && _currentPlayingTitle == lessonId) {
      try {
        await _flutterTts.stop();
      } catch (e) {
        print('Stop error: $e');
      }
      if (mounted) {
        setState(() {
          _isSpeaking = false;
          _currentPlayingTitle = null;
        });
      }
    } else {
      if (_isSpeaking) {
        try {
          await _flutterTts.stop();
        } catch (e) {
          print('Stop error: $e');
        }
      }
      
      if (mounted) {
        setState(() {
          _isSpeaking = true;
          _currentPlayingTitle = lessonId;
        });
      }
      
      try {
        List<String> arabicCodes = ["ar-SA", "ar", "ar-EG"];
        for (String code in arabicCodes) {
          try {
            var result = await _flutterTts.setLanguage(code);
            if (result == 1 || result == true) {
              break;
            }
          } catch (e) {
            print('Language set error: $e');
          }
        }
        
        int result = await _flutterTts.speak(title);
        
        if (result != 1) {
          if (mounted) {
            setState(() {
              _isSpeaking = false;
              _currentPlayingTitle = null;
            });
          }
          _showSnackBar('Could not play audio.');
        }
      } catch (e) {
        print('Speak error: $e');
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingTitle = null;
          });
        }
      }
    }
  }

  void _showInstallDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Install Arabic Voice'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'To hear Arabic pronunciation, you need to install Arabic voice pack.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                const Text(
                  '📱 Installation Steps:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('1. Open device Settings'),
                const Text('2. Go to System → Languages & input'),
                const Text('3. Tap on Text-to-speech output'),
                const Text('4. Select Google Text-to-Speech engine'),
                const Text('5. Tap Settings icon next to Google Text-to-Speech'),
                const Text('6. Tap on Install voice data'),
                const Text('7. Select Arabic (العربية) and download'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '💡 Tip: You can also install Google Text-to-Speech from Play Store if not available.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Later'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                try {
                  await _flutterTts.setLanguage("ar-SA");
                } catch (e) {
                  print('Error opening settings: $e');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A884),
              ),
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConstants.errorColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Practice Daily Arabic Conversations',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF00A884),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              !_isTtsAvailable ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: _showInstallDialog,
            tooltip: 'Voice Settings',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              // TTS Status Banner
              if (!_isTtsAvailable)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.amber.shade700),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.amber.shade700, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Arabic voice not installed. Tap to install.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.amber.shade800,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _showInstallDialog,
                          child: Text(
                            'Install',
                            style: TextStyle(color: const Color(0xFF00A884)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search lessons...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF00A884)),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: Colors.grey[400]),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _filteredLessons = _controller.lessons;
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    onChanged: (query) {
                      setState(() {
                        _filteredLessons = _controller.searchLessons(query);
                      });
                    },
                  ),
                ),
              ),
              // Categories
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                            _filterLessonsByCategory();
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: const Color(0xFF00A884).withOpacity(0.2),
                        checkmarkColor: const Color(0xFF00A884),
                        labelStyle: TextStyle(
                          color: isSelected ? const Color(0xFF00A884) : Colors.grey[600],
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppConstants.backgroundColor, Colors.white],
          ),
        ),
        child: _filteredLessons.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                itemCount: _filteredLessons.length,
                itemBuilder: (context, index) {
                  final lesson = _filteredLessons[index];
                  return _buildLessonCard(lesson, index);
                },
              ),
      ),
    );
  }

  void _filterLessonsByCategory() {
    if (_selectedCategory == 'All') {
      _filteredLessons = _controller.searchLessons(_searchController.text);
    } else {
      _filteredLessons = _controller.lessons
          .where((lesson) => lesson.topic == _selectedCategory)
          .toList();
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            _searchController.text.isEmpty
                ? 'No lessons available'
                : 'No lessons found for "${_searchController.text}"',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(Lesson lesson, int index) {
    final isPlaying = _isSpeaking && _currentPlayingTitle == lesson.id;
    
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 50)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonDetailScreen(
                    lesson: lesson,
                    ttsAvailable: _isTtsAvailable,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Lesson Number Circle
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF00A884),
                          const Color(0xFF00A884).withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        lesson.id,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Lesson Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00A884),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lesson.topic,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00A884).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.message,
                                size: 12,
                                color: Color(0xFF00A884),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${lesson.conversations.length} conversations',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: const Color(0xFF00A884),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Voice Button
                  GestureDetector(
                    onTap: () => _speakTitle(lesson.title, lesson.id),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isPlaying
                            ? const Color(0xFF00A884).withOpacity(0.2)
                            : AppConstants.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isPlaying
                              ? const Color(0xFF00A884)
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isPlaying
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFF00A884),
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.volume_up,
                                size: 20,
                                color: Colors.grey[600],
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppConstants.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Color(0xFF00A884),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _flutterTts.stop();
    // _flutterTts.dispose();
    super.dispose();
  }
}