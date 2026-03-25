import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../controllers/vocabulary_controller.dart';
import '../models/vocabulary_model.dart';
import '../utils/constants.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  final VocabularyController _controller = VocabularyController();
  final TextEditingController _searchController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  List<VocabularyItem> _filteredItems = [];
  bool _isSpeaking = false;
  String? _currentPlayingWord;
  bool _isTtsAvailable = true;
  Set<String> _favoriteWords = {};

  @override
  void initState() {
    super.initState();
    _filteredItems = _controller.getTodaysVocabulary();
    _initTts();
  }

  Future<void> _initTts() async {
    try {
      // Initialize TTS
      await _flutterTts.awaitSpeakCompletion(true);
      
      // Try to find and set Arabic language
      bool arabicSet = false;
      List<String> arabicCodes = [
        "ar-SA",  // Saudi Arabia
        "ar-EG",  // Egypt
        "ar",     // Generic Arabic
        "ar-AE",  // UAE
        "ar-LB",  // Lebanon
      ];
      
      for (String code in arabicCodes) {
        try {
          var result = await _flutterTts.setLanguage(code);
          if (result == 1 || result == true) {
            arabicSet = true;
            print('Vocabulary: Successfully set Arabic language to: $code');
            break;
          }
        } catch (e) {
          print('Vocabulary: Failed to set language $code: $e');
        }
      }
      
      if (!arabicSet) {
        print('Vocabulary: No Arabic language found');
        setState(() {
          _isTtsAvailable = false;
        });
      } else {
        setState(() {
          _isTtsAvailable = true;
        });
      }
      
      // Set speech properties
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setVolume(1.0);
      
      // Set completion handler
      _flutterTts.setCompletionHandler(() {
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingWord = null;
          });
        }
      });
      
      // Set error handler
      _flutterTts.setErrorHandler((msg) {
        print('Vocabulary TTS Error: $msg');
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingWord = null;
          });
        }
      });
      
      // Set start handler
      _flutterTts.setStartHandler(() {
        if (mounted) {
          setState(() {
            _isSpeaking = true;
          });
        }
      });
      
      // Set cancel handler
      _flutterTts.setCancelHandler(() {
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingWord = null;
          });
        }
      });
      
    } catch (e) {
      print('Vocabulary TTS Initialization Error: $e');
      if (mounted) {
        setState(() {
          _isTtsAvailable = false;
        });
      }
    }
  }

  Future<void> _speakWord(String word, String wordId) async {
    if (!_isTtsAvailable) {
      _showInstallDialog();
      return;
    }
    
    if (_isSpeaking && _currentPlayingWord == wordId) {
      // Stop if currently speaking the same word
      try {
        await _flutterTts.stop();
      } catch (e) {
        print('Stop error: $e');
      }
      if (mounted) {
        setState(() {
          _isSpeaking = false;
          _currentPlayingWord = null;
        });
      }
    } else {
      // Stop any ongoing speech
      if (_isSpeaking) {
        try {
          await _flutterTts.stop();
        } catch (e) {
          print('Stop error: $e');
        }
      }
      
      // Start new speech
      if (mounted) {
        setState(() {
          _isSpeaking = true;
          _currentPlayingWord = wordId;
        });
      }
      
      try {
        // Try to set Arabic language before speaking
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
        
        // Speak the word
        int result = await _flutterTts.speak(word);
        
        if (result != 1) {
          if (mounted) {
            setState(() {
              _isSpeaking = false;
              _currentPlayingWord = null;
            });
          }
          _showSnackBar('Could not play audio. Please check text-to-speech settings.');
        }
      } catch (e) {
        print('Speak error: $e');
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingWord = null;
          });
        }
        _showSnackBar('Error: $e');
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
                // Try to open TTS settings
                try {
                  await _flutterTts.setLanguage("ar-SA");
                } catch (e) {
                  print('Error opening settings: $e');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.secondaryColor,
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

  void _toggleFavorite(String word) {
    setState(() {
      if (_favoriteWords.contains(word)) {
        _favoriteWords.remove(word);
        _showSnackBar('Removed from favorites');
      } else {
        _favoriteWords.add(word);
        _showSnackBar('Added to favorites');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learn Arabic Vocabulary',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppConstants.secondaryColor,
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
          preferredSize: const Size.fromHeight(70),
          child: Padding(
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
                  hintText: 'Search vocabulary...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: AppConstants.secondaryColor),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey[400]),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _filteredItems = _controller.getTodaysVocabulary();
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
                    if (query.isEmpty) {
                      _filteredItems = _controller.getTodaysVocabulary();
                    } else {
                      _filteredItems = _controller.vocabularyItems
                          .where((item) =>
                              item.arabicWord.contains(query) ||
                              item.englishMeaning
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                          .toList();
                    }
                  });
                },
              ),
            ),
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
                        style: TextStyle(color: AppConstants.secondaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            
            // Daily Progress Header
            _buildProgressHeader(),
            
            // Vocabulary List
            Expanded(
              child: _filteredItems.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(AppConstants.defaultPadding),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return _buildVocabularyCard(_filteredItems[index], index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    int totalItems = _controller.getTodaysVocabulary().length;
    int learnedItems = _favoriteWords.length;
    
    return Container(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppConstants.secondaryColor, AppConstants.primaryColor],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppConstants.secondaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '📚 Vocabulary',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$totalItems',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Total Words',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$learnedItems',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Learned',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalItems > 0 ? '${((learnedItems / totalItems) * 100).toInt()}%' : '0%',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Completion',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: totalItems > 0 ? learnedItems / totalItems : 0,
            backgroundColor: Colors.white30,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_online,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            _searchController.text.isEmpty
                ? 'No vocabulary available'
                : 'No words found for "${_searchController.text}"',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVocabularyCard(VocabularyItem item, int index) {
    final isPlaying = _isSpeaking && _currentPlayingWord == item.arabicWord;
    final isFavorite = _favoriteWords.contains(item.arabicWord);
    
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
              _showVocabularyDetails(item);
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppConstants.secondaryColor,
                                  AppConstants.primaryColor,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.arabicWord,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppConstants.secondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.englishMeaning,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Voice Button
                          GestureDetector(
                            onTap: () => _speakWord(item.arabicWord, item.arabicWord),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isPlaying
                                    ? AppConstants.accentColor.withOpacity(0.2)
                                    : AppConstants.backgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isPlaying
                                      ? AppConstants.accentColor
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
                                            AppConstants.accentColor,
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
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppConstants.backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppConstants.secondaryColor.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.format_quote,
                              size: 16,
                              color: AppConstants.secondaryColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item.exampleSentence,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppConstants.backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            _showVocabularyDetails(item);
                          },
                          child: const Text(
                            'Learn More',
                            style: TextStyle(
                              color: AppConstants.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.grey[300],
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            _toggleFavorite(item.arabicWord);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                size: 16,
                                color: isFavorite ? Colors.red : AppConstants.secondaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isFavorite ? 'Saved' : 'Save',
                                style: TextStyle(
                                  color: isFavorite ? Colors.red : AppConstants.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showVocabularyDetails(VocabularyItem item) {
    final isPlaying = _isSpeaking && _currentPlayingWord == item.arabicWord;
    final isFavorite = _favoriteWords.contains(item.arabicWord);
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateBottomSheet) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.arabicWord,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.secondaryColor,
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Voice Button in Modal
                        GestureDetector(
                          onTap: () async {
                            await _speakWord(item.arabicWord, item.arabicWord);
                            setStateBottomSheet(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isPlaying
                                  ? AppConstants.accentColor.withOpacity(0.2)
                                  : AppConstants.backgroundColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isPlaying
                                    ? AppConstants.accentColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: isPlaying && _currentPlayingWord == item.arabicWord
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          AppConstants.accentColor,
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      Icons.play_arrow,
                                      size: 28,
                                      color: AppConstants.secondaryColor,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      item.englishMeaning,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    'Example in Context:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppConstants.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item.exampleSentence,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _toggleFavorite(item.arabicWord);
                            setStateBottomSheet(() {});
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isFavorite ? Colors.red : AppConstants.secondaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                size: 16,
                                color: isFavorite ? Colors.red : AppConstants.secondaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isFavorite ? 'Saved' : 'Save',
                                style: TextStyle(
                                  color: isFavorite ? Colors.red : AppConstants.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _speakWord(item.arabicWord, item.arabicWord);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Repeat',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Close',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
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