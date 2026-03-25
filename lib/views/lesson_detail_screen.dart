import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/lesson_model.dart';
import '../utils/constants.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;
  final bool ttsAvailable;

  const LessonDetailScreen({
    super.key, 
    required this.lesson,
    this.ttsAvailable = true,
  });

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String? _currentPlayingText;
  bool _isTtsAvailable = true;
  Set<int> _completedConversations = {};

  @override
  void initState() {
    super.initState();
    _isTtsAvailable = widget.ttsAvailable;
    _initTts();
  }

  Future<void> _initTts() async {
    if (!_isTtsAvailable) return;
    
    try {
      await _flutterTts.awaitSpeakCompletion(true);
      
      bool arabicSet = false;
      List<String> arabicCodes = ["ar-SA", "ar-EG", "ar", "ar-AE", "ar-LB"];
      
      for (String code in arabicCodes) {
        try {
          var result = await _flutterTts.setLanguage(code);
          if (result == 1 || result == true) {
            arabicSet = true;
            print('LessonDetail: Successfully set Arabic language to: $code');
            break;
          }
        } catch (e) {
          print('LessonDetail: Failed to set language $code: $e');
        }
      }
      
      if (!arabicSet) {
        setState(() {
          _isTtsAvailable = false;
        });
      }
      
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setVolume(1.0);
      
      _flutterTts.setCompletionHandler(() {
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingText = null;
            // Mark as completed after playing
            if (_currentPlayingText != null) {
              _completedConversations.add(_currentIndex);
            }
          });
        }
      });
      
      _flutterTts.setErrorHandler((msg) {
        print('LessonDetail TTS Error: $msg');
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingText = null;
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
            _currentPlayingText = null;
          });
        }
      });
      
    } catch (e) {
      print('LessonDetail TTS Initialization Error: $e');
      setState(() {
        _isTtsAvailable = false;
      });
    }
  }

  Future<void> _speakConversation(String text, String textId) async {
    if (!_isTtsAvailable) {
      _showInstallDialog();
      return;
    }
    
    if (_isSpeaking && _currentPlayingText == textId) {
      try {
        await _flutterTts.stop();
      } catch (e) {
        print('Stop error: $e');
      }
      if (mounted) {
        setState(() {
          _isSpeaking = false;
          _currentPlayingText = null;
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
          _currentPlayingText = textId;
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
        
        int result = await _flutterTts.speak(text);
        
        if (result != 1) {
          if (mounted) {
            setState(() {
              _isSpeaking = false;
              _currentPlayingText = null;
            });
          }
        }
      } catch (e) {
        print('Speak error: $e');
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingText = null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lesson.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lesson saved to favorites'),
                  backgroundColor: AppConstants.successColor,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Share feature coming soon'),
                  backgroundColor: AppConstants.primaryColor,
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppConstants.backgroundColor, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // TTS Status Banner
            if (!_isTtsAvailable)
              Container(
                margin: const EdgeInsets.all(16),
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
            
            // Progress Indicator
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lesson Progress',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${_currentIndex + 1}/${widget.lesson.conversations.length}',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF00A884),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentIndex + 1) / widget.lesson.conversations.length,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00A884)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
            ),
            
            // Page View for Conversations
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: widget.lesson.conversations.length,
                itemBuilder: (context, index) {
                  final conversation = widget.lesson.conversations[index];
                  final isPlaying = _isSpeaking && _currentPlayingText == conversation.arabic;
                  final isCompleted = _completedConversations.contains(index);
                  
                  return _buildConversationCard(conversation, index, isPlaying, isCompleted);
                },
              ),
            ),
            
            // Navigation Buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _currentIndex > 0
                          ? () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: const Color(0xFF00A884)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Previous'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _currentIndex < widget.lesson.conversations.length - 1
                          ? () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : () {
                              _showCompletionDialog();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A884),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        _currentIndex < widget.lesson.conversations.length - 1
                            ? 'Next'
                            : 'Complete Lesson',
                            style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConversationCard(ConversationLine conversation, int index, bool isPlaying, bool isCompleted) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Arabic Text Card with Voice Button
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF00A884),
                      const Color(0xFF00A884).withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00A884).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    conversation.arabic,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => _speakConversation(conversation.arabic, conversation.arabic),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                        ),
                      ],
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
                              isCompleted ? Icons.check_circle : Icons.play_arrow,
                              size: 24,
                              color: isCompleted ? Colors.green : const Color(0xFF00A884),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          
          // English Translation Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                conversation.english,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Repeat Button
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () => _speakConversation(conversation.arabic, conversation.arabic),
                  icon: const Icon(Icons.replay,color: Colors.white,),
                  label: const Text('Repeat Pronunciation',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A884),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap to hear Arabic pronunciation',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppConstants.successColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.celebration,
                    size: 50,
                    color: AppConstants.successColor,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.successColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You completed "${widget.lesson.title}"',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You practiced ${_completedConversations.length} conversations',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Keep practicing to improve your Arabic skills!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                         style: OutlinedButton.styleFrom(
                        side: BorderSide(color: const Color(0xFF00A884)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                        child: const Text('Back to Lessons',style: TextStyle(color: AppConstants.secondaryColor),),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A884),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Done',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _flutterTts.stop();
    // _flutterTts.dispose();
    super.dispose();
  }
}