import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../controllers/dictionary_controller.dart';
import '../models/word_model.dart';
import '../utils/constants.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final DictionaryController _controller = DictionaryController();
  final TextEditingController _searchController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSearching = false;
  bool _isSpeaking = false;
  bool _isTtsAvailable = true;
  String? _currentPlayingWord;
  String currentLanguage = "en-US"; // Default language

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    try {
      // Initialize TTS
      await _flutterTts.awaitSpeakCompletion(true);
      
      // Get available languages
      List<dynamic>? languages = await _flutterTts.getLanguages;
      print('Available languages: $languages');
      
      // Try to find and set Arabic language
      bool arabicSet = false;
      
      // List of Arabic language codes to try
      List<String> arabicCodes = [
        "ar-SA",  // Saudi Arabia
        "ar-EG",  // Egypt
        "ar",     // Generic Arabic
        "ar-AE",  // UAE
        "ar-LB",  // Lebanon
        "ar-SY",  // Syria
        "ar-JO",  // Jordan
      ];
      
      for (String code in arabicCodes) {
        try {
          var result = await _flutterTts.setLanguage(code);
          print('Trying language $code: result = $result');
          
          // Check if language was set successfully
          if (result == 1 || result == true) {
            currentLanguage = code;
            arabicSet = true;
            print('Successfully set Arabic language to: $code');
            break;
          }
        } catch (e) {
          print('Failed to set language $code: $e');
        }
      }
      
      if (!arabicSet) {
        print('No Arabic language found, using default language');
        setState(() {
          _isTtsAvailable = false;
        });
        _showSnackBar('Arabic TTS not installed. Please install Arabic voice pack.');
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
        print('TTS Error: $msg');
        if (mounted) {
          setState(() {
            _isSpeaking = false;
            _currentPlayingWord = null;
          });
          _showSnackBar('Error playing audio: $msg');
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
      print('TTS Initialization Error: $e');
      if (mounted) {
        setState(() {
          _isTtsAvailable = false;
        });
        _showSnackBar('Text-to-speech initialization failed.');
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
        bool languageSet = false;
        List<String> arabicCodes = ["ar-SA", "ar", "ar-EG"];
        
        for (String code in arabicCodes) {
          try {
            var result = await _flutterTts.setLanguage(code);
            if (result == 1 || result == true) {
              languageSet = true;
              print('Language set to $code for speaking');
              break;
            }
          } catch (e) {
            print('Language set error: $e');
          }
        }
        
        if (!languageSet) {
          print('Could not set Arabic language, using default');
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
                const Text(
                  'After installation, restart the app.',
                  style: TextStyle(color: Colors.green),
                ),
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
                backgroundColor: AppConstants.primaryColor,
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
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Install',
          onPressed: _showInstallDialog,
          textColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Arabic Words',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppConstants.primaryColor,
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
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Search Arabic or English...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: AppConstants.primaryColor),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey[400]),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _controller.searchWords('');
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
                    _isSearching = query.isNotEmpty;
                    _controller.searchWords(query);
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
                        style: TextStyle(color: AppConstants.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            
            // Stats Bar
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_controller.searchResults.length} words found',
                    style: TextStyle(
                      fontSize: AppConstants.smallSize,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (_isSearching)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Search Results',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppConstants.accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Results List
            Expanded(
              child: _controller.searchResults.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(AppConstants.defaultPadding),
                      itemCount: _controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final word = _controller.searchResults[index];
                        return _buildWordCard(word, index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            _searchController.text.isEmpty
                ? 'Start typing to search Arabic words'
                : 'No words found for "${_searchController.text}"',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          if (_searchController.text.isNotEmpty)
            TextButton(
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _controller.searchWords('');
                });
              },
              child: const Text('Clear search'),
            ),
        ],
      ),
    );
  }

  Widget _buildWordCard(Word word, int index) {
    final isPlaying = _isSpeaking && _currentPlayingWord == word.arabicWord;
    
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
          elevation: 2,
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              _showWordDetails(word);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppConstants.primaryColor,
                              AppConstants.secondaryColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.translate,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              word.arabicWord,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              word.englishMeaning,
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
                        onTap: () => _speakWord(word.arabicWord, word.arabicWord),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isPlaying
                                ? AppConstants.accentColor.withOpacity(0.2)
                                : AppConstants.backgroundColor,
                            borderRadius: BorderRadius.circular(10),
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
                  if (word.exampleSentence != null) ...[
                    const Divider(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppConstants.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.format_quote,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              word.exampleSentence!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showWordDetails(Word word) {
    final isPlaying = _isSpeaking && _currentPlayingWord == word.arabicWord;
    
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
                          word.arabicWord,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Voice Button in Modal
                        GestureDetector(
                          onTap: () async {
                            await _speakWord(word.arabicWord, word.arabicWord);
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
                              child: isPlaying && _currentPlayingWord == word.arabicWord
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
                                      color: AppConstants.primaryColor,
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
                      word.englishMeaning,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (word.exampleSentence != null) ...[
                    const Divider(),
                    const SizedBox(height: 10),
                    const Text(
                      'Example Sentence:',
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
                        word.exampleSentence!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _speakWord(word.arabicWord, word.arabicWord);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppConstants.primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Repeat',
                            style: TextStyle(fontSize: 16),
                          ),
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
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Close',
                            style: TextStyle(fontSize: 16,color: Colors.white),
                          ),
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