import '../models/word_model.dart';
import '../models/vocabulary_model.dart';
import '../models/lesson_model.dart';

class AppData {
  // ==================== EXTENSIVE DICTIONARY DATA ====================
  static List<Word> dictionaryWords = [
    // Greetings & Basic Phrases
    Word(arabicWord: 'مرحبا', englishMeaning: 'Hello', exampleSentence: 'مرحبا بك - Welcome'),
    Word(arabicWord: 'السلام عليكم', englishMeaning: 'Peace be upon you', exampleSentence: 'السلام عليكم ورحمة الله - Peace be upon you and God\'s mercy'),
    Word(arabicWord: 'وعليكم السلام', englishMeaning: 'And upon you be peace', exampleSentence: 'وعليكم السلام ورحمة الله - And upon you be peace and God\'s mercy'),
    Word(arabicWord: 'صباح الخير', englishMeaning: 'Good morning', exampleSentence: 'صباح الخير يا صديقي - Good morning my friend'),
    Word(arabicWord: 'مساء الخير', englishMeaning: 'Good evening', exampleSentence: 'مساء الخير كيف حالك - Good evening, how are you'),
    Word(arabicWord: 'تصبح على خير', englishMeaning: 'Good night', exampleSentence: 'تصبح على خير أحلام سعيدة - Good night, sweet dreams'),
    Word(arabicWord: 'مع السلامة', englishMeaning: 'Goodbye', exampleSentence: 'مع السلامة أراك غدا - Goodbye, see you tomorrow'),
    Word(arabicWord: 'أهلاً وسهلاً', englishMeaning: 'Welcome', exampleSentence: 'أهلاً وسهلاً بكم - Welcome everyone'),
    Word(arabicWord: 'شكرا', englishMeaning: 'Thank you', exampleSentence: 'شكرا جزيلا على مساعدتك - Thank you very much for your help'),
    Word(arabicWord: 'عفوا', englishMeaning: 'You\'re welcome', exampleSentence: 'عفوا هذا واجبي - You\'re welcome, it\'s my duty'),
    Word(arabicWord: 'نعم', englishMeaning: 'Yes', exampleSentence: 'نعم أنا موافق - Yes, I agree'),
    Word(arabicWord: 'لا', englishMeaning: 'No', exampleSentence: 'لا شكرا - No, thank you'),
    Word(arabicWord: 'من فضلك', englishMeaning: 'Please', exampleSentence: 'من فضلك أعطني كوب ماء - Please give me a glass of water'),
    Word(arabicWord: 'آسف', englishMeaning: 'Sorry', exampleSentence: 'آسف على التأخير - Sorry for the delay'),
    
    // Numbers
    Word(arabicWord: 'واحد', englishMeaning: 'One', exampleSentence: 'عندي كتاب واحد - I have one book'),
    Word(arabicWord: 'اثنان', englishMeaning: 'Two', exampleSentence: 'عندي اثنان قلم - I have two pens'),
    Word(arabicWord: 'ثلاثة', englishMeaning: 'Three', exampleSentence: 'ثلاثة تفاحات - Three apples'),
    Word(arabicWord: 'أربعة', englishMeaning: 'Four', exampleSentence: 'أربعة أيام - Four days'),
    Word(arabicWord: 'خمسة', englishMeaning: 'Five', exampleSentence: 'خمسة دروس - Five lessons'),
    Word(arabicWord: 'ستة', englishMeaning: 'Six', exampleSentence: 'ستة طلاب - Six students'),
    Word(arabicWord: 'سبعة', englishMeaning: 'Seven', exampleSentence: 'سبعة أيام في الأسبوع - Seven days in a week'),
    Word(arabicWord: 'ثمانية', englishMeaning: 'Eight', exampleSentence: 'ثمانية ساعات - Eight hours'),
    Word(arabicWord: 'تسعة', englishMeaning: 'Nine', exampleSentence: 'تسعة أشهر - Nine months'),
    Word(arabicWord: 'عشرة', englishMeaning: 'Ten', exampleSentence: 'عشرة دراهم - Ten dirhams'),
    
    // Common Objects
    Word(arabicWord: 'كتاب', englishMeaning: 'Book', exampleSentence: 'أقرأ كتابا ممتعا - I read an interesting book'),
    Word(arabicWord: 'قلم', englishMeaning: 'Pen', exampleSentence: 'أكتب بقلم أزرق - I write with a blue pen'),
    Word(arabicWord: 'ماء', englishMeaning: 'Water', exampleSentence: 'أشرب ماء بارد - I drink cold water'),
    Word(arabicWord: 'بيت', englishMeaning: 'House', exampleSentence: 'بيتي كبير وجميل - My house is big and beautiful'),
    Word(arabicWord: 'سيارة', englishMeaning: 'Car', exampleSentence: 'سيارتي جديدة - My car is new'),
    Word(arabicWord: 'طعام', englishMeaning: 'Food', exampleSentence: 'الطعام لذيذ - The food is delicious'),
    Word(arabicWord: 'شاي', englishMeaning: 'Tea', exampleSentence: 'أشرب الشاي صباحا - I drink tea in the morning'),
    Word(arabicWord: 'قهوة', englishMeaning: 'Coffee', exampleSentence: 'أحب القهوة العربية - I love Arabic coffee'),
    Word(arabicWord: 'تفاحة', englishMeaning: 'Apple', exampleSentence: 'آكل تفاحة حمراء - I eat a red apple'),
    Word(arabicWord: 'موز', englishMeaning: 'Banana', exampleSentence: 'الموز فاكهة صحية - Banana is a healthy fruit'),
    Word(arabicWord: 'برتقال', englishMeaning: 'Orange', exampleSentence: 'عصير البرتقال مفيد - Orange juice is beneficial'),
    Word(arabicWord: 'خبز', englishMeaning: 'Bread', exampleSentence: 'آكل خبزا طازجا - I eat fresh bread'),
    Word(arabicWord: 'حليب', englishMeaning: 'Milk', exampleSentence: 'أشرب حليب كل صباح - I drink milk every morning'),
    Word(arabicWord: 'كرسي', englishMeaning: 'Chair', exampleSentence: 'أجلس على كرسي مريح - I sit on a comfortable chair'),
    Word(arabicWord: 'طاولة', englishMeaning: 'Table', exampleSentence: 'الطعام على الطاولة - The food is on the table'),
    Word(arabicWord: 'باب', englishMeaning: 'Door', exampleSentence: 'الباب مفتوح - The door is open'),
    Word(arabicWord: 'نافذة', englishMeaning: 'Window', exampleSentence: 'افتح النافذة - Open the window'),
    Word(arabicWord: 'هاتف', englishMeaning: 'Phone', exampleSentence: 'هاتفي جديد - My phone is new'),
    Word(arabicWord: 'كمبيوتر', englishMeaning: 'Computer', exampleSentence: 'أعمل على الكمبيوتر - I work on the computer'),
    
    // Family
    Word(arabicWord: 'أب', englishMeaning: 'Father', exampleSentence: 'أبي مهندس - My father is an engineer'),
    Word(arabicWord: 'أم', englishMeaning: 'Mother', exampleSentence: 'أمي طبيبة - My mother is a doctor'),
    Word(arabicWord: 'أخ', englishMeaning: 'Brother', exampleSentence: 'لدي أخ واحد - I have one brother'),
    Word(arabicWord: 'أخت', englishMeaning: 'Sister', exampleSentence: 'أختي صغيرة - My sister is young'),
    Word(arabicWord: 'جد', englishMeaning: 'Grandfather', exampleSentence: 'جدي كبير في السن - My grandfather is old'),
    Word(arabicWord: 'جدة', englishMeaning: 'Grandmother', exampleSentence: 'جدة تطبخ طعاما لذيذا - Grandmother cooks delicious food'),
    Word(arabicWord: 'ابن', englishMeaning: 'Son', exampleSentence: 'لدي ابن واحد - I have one son'),
    Word(arabicWord: 'بنت', englishMeaning: 'Daughter', exampleSentence: 'بنتي تدرس في المدرسة - My daughter studies at school'),
    Word(arabicWord: 'زوج', englishMeaning: 'Husband', exampleSentence: 'زوجي يعمل في البنك - My husband works at the bank'),
    Word(arabicWord: 'زوجة', englishMeaning: 'Wife', exampleSentence: 'زوجتي معلمة - My wife is a teacher'),
    
    // Days & Time
    Word(arabicWord: 'السبت', englishMeaning: 'Saturday', exampleSentence: 'السبت أول يوم العطلة - Saturday is the first day of the weekend'),
    Word(arabicWord: 'الأحد', englishMeaning: 'Sunday', exampleSentence: 'نذهب إلى المسجد يوم الأحد - We go to the mosque on Sunday'),
    Word(arabicWord: 'الاثنين', englishMeaning: 'Monday', exampleSentence: 'يوم الاثنين بداية الأسبوع - Monday is the start of the week'),
    Word(arabicWord: 'الثلاثاء', englishMeaning: 'Tuesday', exampleSentence: 'لدي اجتماع يوم الثلاثاء - I have a meeting on Tuesday'),
    Word(arabicWord: 'الأربعاء', englishMeaning: 'Wednesday', exampleSentence: 'نتسوق يوم الأربعاء - We shop on Wednesday'),
    Word(arabicWord: 'الخميس', englishMeaning: 'Thursday', exampleSentence: 'الخميس آخر يوم عمل - Thursday is the last work day'),
    Word(arabicWord: 'الجمعة', englishMeaning: 'Friday', exampleSentence: 'الجمعة يوم مبارك - Friday is a blessed day'),
    Word(arabicWord: 'اليوم', englishMeaning: 'Today', exampleSentence: 'اليوم يوم جميل - Today is a beautiful day'),
    Word(arabicWord: 'غدا', englishMeaning: 'Tomorrow', exampleSentence: 'سأسافر غدا - I will travel tomorrow'),
    Word(arabicWord: 'أمس', englishMeaning: 'Yesterday', exampleSentence: 'ذهبت إلى السوق أمس - I went to the market yesterday'),
    Word(arabicWord: 'ساعة', englishMeaning: 'Hour', exampleSentence: 'سأعود بعد ساعة - I will return after an hour'),
    Word(arabicWord: 'دقيقة', englishMeaning: 'Minute', exampleSentence: 'انتظر دقيقة من فضلك - Wait a minute please'),
    Word(arabicWord: 'ثانية', englishMeaning: 'Second', exampleSentence: 'انتظر ثانية واحدة - Wait one second'),
    
    // Colors
    Word(arabicWord: 'أحمر', englishMeaning: 'Red', exampleSentence: 'الورد أحمر - The rose is red'),
    Word(arabicWord: 'أزرق', englishMeaning: 'Blue', exampleSentence: 'السماء زرقاء - The sky is blue'),
    Word(arabicWord: 'أصفر', englishMeaning: 'Yellow', exampleSentence: 'الشمس صفراء - The sun is yellow'),
    Word(arabicWord: 'أخضر', englishMeaning: 'Green', exampleSentence: 'العشب أخضر - The grass is green'),
    Word(arabicWord: 'أسود', englishMeaning: 'Black', exampleSentence: 'الليل أسود - The night is black'),
    Word(arabicWord: 'أبيض', englishMeaning: 'White', exampleSentence: 'الثلج أبيض - Snow is white'),
    Word(arabicWord: 'بني', englishMeaning: 'Brown', exampleSentence: 'الأرض بنية - The earth is brown'),
    Word(arabicWord: 'برتقالي', englishMeaning: 'Orange', exampleSentence: 'البرتقال برتقالي اللون - Oranges are orange in color'),
    Word(arabicWord: 'وردي', englishMeaning: 'Pink', exampleSentence: 'الزهور وردية - The flowers are pink'),
    Word(arabicWord: 'رمادي', englishMeaning: 'Gray', exampleSentence: 'السماء رمادية - The sky is gray'),
    
    // Adjectives
    Word(arabicWord: 'كبير', englishMeaning: 'Big', exampleSentence: 'هذا منزل كبير - This is a big house'),
    Word(arabicWord: 'صغير', englishMeaning: 'Small', exampleSentence: 'لدي سيارة صغيرة - I have a small car'),
    Word(arabicWord: 'طويل', englishMeaning: 'Tall', exampleSentence: 'أخي طويل - My brother is tall'),
    Word(arabicWord: 'قصير', englishMeaning: 'Short', exampleSentence: 'أختي قصيرة - My sister is short'),
    Word(arabicWord: 'جميل', englishMeaning: 'Beautiful', exampleSentence: 'الحديقة جميلة - The garden is beautiful'),
    Word(arabicWord: 'قبيح', englishMeaning: 'Ugly', exampleSentence: 'هذا المبنى قبيح - This building is ugly'),
    Word(arabicWord: 'جيد', englishMeaning: 'Good', exampleSentence: 'هذا طعام جيد - This is good food'),
    Word(arabicWord: 'سيء', englishMeaning: 'Bad', exampleSentence: 'الطقس سيء اليوم - The weather is bad today'),
    Word(arabicWord: 'سريع', englishMeaning: 'Fast', exampleSentence: 'القطار سريع - The train is fast'),
    Word(arabicWord: 'بطيء', englishMeaning: 'Slow', exampleSentence: 'السلحفاة بطيئة - The turtle is slow'),
    Word(arabicWord: 'سهل', englishMeaning: 'Easy', exampleSentence: 'الدرس سهل - The lesson is easy'),
    Word(arabicWord: 'صعب', englishMeaning: 'Difficult', exampleSentence: 'الامتحان صعب - The exam is difficult'),
    Word(arabicWord: 'جديد', englishMeaning: 'New', exampleSentence: 'اشتريت هاتفا جديدا - I bought a new phone'),
    Word(arabicWord: 'قديم', englishMeaning: 'Old', exampleSentence: 'هذا بيت قديم - This is an old house'),
    Word(arabicWord: 'غالي', englishMeaning: 'Expensive', exampleSentence: 'هذه السيارة غالية - This car is expensive'),
    Word(arabicWord: 'رخيص', englishMeaning: 'Cheap', exampleSentence: 'هذا المنتج رخيص - This product is cheap'),
    
    // Verbs
    Word(arabicWord: 'أكل', englishMeaning: 'Eat', exampleSentence: 'آكل التفاح - I eat apples'),
    Word(arabicWord: 'شرب', englishMeaning: 'Drink', exampleSentence: 'أشرب الماء - I drink water'),
    Word(arabicWord: 'نام', englishMeaning: 'Sleep', exampleSentence: 'أنام مبكرا - I sleep early'),
    Word(arabicWord: 'استيقظ', englishMeaning: 'Wake up', exampleSentence: 'أستيقظ في السادسة - I wake up at six'),
    Word(arabicWord: 'ذهب', englishMeaning: 'Go', exampleSentence: 'أذهب إلى العمل - I go to work'),
    Word(arabicWord: 'جاء', englishMeaning: 'Come', exampleSentence: 'جاء صديقي - My friend came'),
    Word(arabicWord: 'قرأ', englishMeaning: 'Read', exampleSentence: 'أقرأ كتابا - I read a book'),
    Word(arabicWord: 'كتب', englishMeaning: 'Write', exampleSentence: 'أكتب رسالة - I write a letter'),
    Word(arabicWord: 'تكلم', englishMeaning: 'Speak', exampleSentence: 'أتحدث العربية - I speak Arabic'),
    Word(arabicWord: 'فهم', englishMeaning: 'Understand', exampleSentence: 'أفهم الدرس - I understand the lesson'),
    Word(arabicWord: 'درس', englishMeaning: 'Study', exampleSentence: 'أدرس اللغة العربية - I study Arabic language'),
    Word(arabicWord: 'عمل', englishMeaning: 'Work', exampleSentence: 'أعمل في شركة - I work in a company'),
    Word(arabicWord: 'لعب', englishMeaning: 'Play', exampleSentence: 'يلعب الأطفال - The children play'),
    Word(arabicWord: 'سبح', englishMeaning: 'Swim', exampleSentence: 'أسبح في البحر - I swim in the sea'),
    Word(arabicWord: 'ركض', englishMeaning: 'Run', exampleSentence: 'أركض في الحديقة - I run in the park'),
    Word(arabicWord: 'جلس', englishMeaning: 'Sit', exampleSentence: 'أجلس على الكرسي - I sit on the chair'),
    Word(arabicWord: 'وقف', englishMeaning: 'Stand', exampleSentence: 'أقف أمام الباب - I stand in front of the door'),
    
    // Places
    Word(arabicWord: 'مدرسة', englishMeaning: 'School', exampleSentence: 'أذهب إلى المدرسة - I go to school'),
    Word(arabicWord: 'جامعة', englishMeaning: 'University', exampleSentence: 'أدرس في الجامعة - I study at university'),
    Word(arabicWord: 'مستشفى', englishMeaning: 'Hospital', exampleSentence: 'أعمل في المستشفى - I work at the hospital'),
    Word(arabicWord: 'مسجد', englishMeaning: 'Mosque', exampleSentence: 'نصلي في المسجد - We pray at the mosque'),
    Word(arabicWord: 'سوق', englishMeaning: 'Market', exampleSentence: 'أشتري من السوق - I buy from the market'),
    Word(arabicWord: 'مطعم', englishMeaning: 'Restaurant', exampleSentence: 'آكل في المطعم - I eat at the restaurant'),
    Word(arabicWord: 'فندق', englishMeaning: 'Hotel', exampleSentence: 'أسكن في فندق - I stay in a hotel'),
    Word(arabicWord: 'مطار', englishMeaning: 'Airport', exampleSentence: 'أذهب إلى المطار - I go to the airport'),
    Word(arabicWord: 'حديقة', englishMeaning: 'Park', exampleSentence: 'أمشي في الحديقة - I walk in the park'),
    Word(arabicWord: 'شاطئ', englishMeaning: 'Beach', exampleSentence: 'أسبح على الشاطئ - I swim at the beach'),
    
    // Emotions
    Word(arabicWord: 'سعيد', englishMeaning: 'Happy', exampleSentence: 'أنا سعيد اليوم - I am happy today'),
    Word(arabicWord: 'حزين', englishMeaning: 'Sad', exampleSentence: 'هو حزين - He is sad'),
    Word(arabicWord: 'غاضب', englishMeaning: 'Angry', exampleSentence: 'هي غاضبة - She is angry'),
    Word(arabicWord: 'خائف', englishMeaning: 'Afraid', exampleSentence: 'أنا خائف من الظلام - I am afraid of the dark'),
    Word(arabicWord: 'متعب', englishMeaning: 'Tired', exampleSentence: 'أنا متعب بعد العمل - I am tired after work'),
    Word(arabicWord: 'جائع', englishMeaning: 'Hungry', exampleSentence: 'أنا جائع أريد الطعام - I am hungry, I want food'),
    Word(arabicWord: 'عطشان', englishMeaning: 'Thirsty', exampleSentence: 'أنا عطشان أريد الماء - I am thirsty, I want water'),
  ];

  // ==================== EXTENSIVE VOCABULARY DATA ====================
  static List<VocabularyItem> dailyVocabulary = [
    // Week 1: Basic Essentials
    VocabularyItem(arabicWord: 'سلام', englishMeaning: 'Peace/Greeting', exampleSentence: 'السلام عليكم - Peace be upon you'),
    VocabularyItem(arabicWord: 'شكراً', englishMeaning: 'Thank you', exampleSentence: 'شكراً جزيلاً - Thank you very much'),
    VocabularyItem(arabicWord: 'عفواً', englishMeaning: 'You\'re welcome', exampleSentence: 'عفواً هذا واجبي - You\'re welcome, it\'s my duty'),
    VocabularyItem(arabicWord: 'من فضلك', englishMeaning: 'Please', exampleSentence: 'من فضلك ساعدني - Please help me'),
    VocabularyItem(arabicWord: 'آسف', englishMeaning: 'Sorry', exampleSentence: 'آسف على الخطأ - Sorry for the mistake'),
    VocabularyItem(arabicWord: 'صباح', englishMeaning: 'Morning', exampleSentence: 'صباح الخير - Good morning'),
    VocabularyItem(arabicWord: 'مساء', englishMeaning: 'Evening', exampleSentence: 'مساء النور - Good evening (response)'),
    VocabularyItem(arabicWord: 'ليل', englishMeaning: 'Night', exampleSentence: 'تصبح على خير - Good night'),
    VocabularyItem(arabicWord: 'نعم', englishMeaning: 'Yes', exampleSentence: 'نعم أحب ذلك - Yes, I like that'),
    VocabularyItem(arabicWord: 'لا', englishMeaning: 'No', exampleSentence: 'لا أريد ذلك - I don\'t want that'),
    
    // Week 2: Family & People
    VocabularyItem(arabicWord: 'عائلة', englishMeaning: 'Family', exampleSentence: 'عائلتي كبيرة - My family is big'),
    VocabularyItem(arabicWord: 'أب', englishMeaning: 'Father', exampleSentence: 'أبي يعمل طبيباً - My father works as a doctor'),
    VocabularyItem(arabicWord: 'أم', englishMeaning: 'Mother', exampleSentence: 'أمي تطبخ الطعام - My mother cooks food'),
    VocabularyItem(arabicWord: 'أخ', englishMeaning: 'Brother', exampleSentence: 'أخي يلعب كرة القدم - My brother plays football'),
    VocabularyItem(arabicWord: 'أخت', englishMeaning: 'Sister', exampleSentence: 'أختي تدرس في الجامعة - My sister studies at university'),
    VocabularyItem(arabicWord: 'جد', englishMeaning: 'Grandfather', exampleSentence: 'جدي يحكي القصص - My grandfather tells stories'),
    VocabularyItem(arabicWord: 'جدة', englishMeaning: 'Grandmother', exampleSentence: 'جدتي تصنع الحلويات - My grandmother makes sweets'),
    VocabularyItem(arabicWord: 'صديق', englishMeaning: 'Friend', exampleSentence: 'صديقي يساعدني دائماً - My friend always helps me'),
    VocabularyItem(arabicWord: 'جار', englishMeaning: 'Neighbor', exampleSentence: 'جاري شخص لطيف - My neighbor is a nice person'),
    VocabularyItem(arabicWord: 'طفل', englishMeaning: 'Child', exampleSentence: 'الطفل يلعب في الحديقة - The child plays in the garden'),
    
    // Week 3: Food & Drinks
    VocabularyItem(arabicWord: 'فطور', englishMeaning: 'Breakfast', exampleSentence: 'أتناول الفطور صباحاً - I have breakfast in the morning'),
    VocabularyItem(arabicWord: 'غداء', englishMeaning: 'Lunch', exampleSentence: 'الغداء في الساعة الواحدة - Lunch at one o\'clock'),
    VocabularyItem(arabicWord: 'عشاء', englishMeaning: 'Dinner', exampleSentence: 'العشاء خفيف - Dinner is light'),
    VocabularyItem(arabicWord: 'خبز', englishMeaning: 'Bread', exampleSentence: 'الخبز طازج - The bread is fresh'),
    VocabularyItem(arabicWord: 'أرز', englishMeaning: 'Rice', exampleSentence: 'الأرز بالدجاج لذيذ - Rice with chicken is delicious'),
    VocabularyItem(arabicWord: 'لحم', englishMeaning: 'Meat', exampleSentence: 'آكل اللحم المشوي - I eat grilled meat'),
    VocabularyItem(arabicWord: 'دجاج', englishMeaning: 'Chicken', exampleSentence: 'الدجاج مقلي - The chicken is fried'),
    VocabularyItem(arabicWord: 'سمك', englishMeaning: 'Fish', exampleSentence: 'السمك طازج اليوم - The fish is fresh today'),
    VocabularyItem(arabicWord: 'فواكه', englishMeaning: 'Fruits', exampleSentence: 'الفواكه مفيدة للصحة - Fruits are healthy'),
    VocabularyItem(arabicWord: 'خضروات', englishMeaning: 'Vegetables', exampleSentence: 'آكل الخضروات يومياً - I eat vegetables daily'),
    
    // Week 4: Home & Furniture
    VocabularyItem(arabicWord: 'منزل', englishMeaning: 'Home', exampleSentence: 'منزلي مريح - My home is comfortable'),
    VocabularyItem(arabicWord: 'غرفة', englishMeaning: 'Room', exampleSentence: 'لدي ثلاث غرف - I have three rooms'),
    VocabularyItem(arabicWord: 'مطبخ', englishMeaning: 'Kitchen', exampleSentence: 'المطبخ نظيف - The kitchen is clean'),
    VocabularyItem(arabicWord: 'حمام', englishMeaning: 'Bathroom', exampleSentence: 'الحمام صغير - The bathroom is small'),
    VocabularyItem(arabicWord: 'غرفة نوم', englishMeaning: 'Bedroom', exampleSentence: 'غرفة نومي مريحة - My bedroom is comfortable'),
    VocabularyItem(arabicWord: 'سرير', englishMeaning: 'Bed', exampleSentence: 'السرير مريح - The bed is comfortable'),
    VocabularyItem(arabicWord: 'خزانة', englishMeaning: 'Wardrobe', exampleSentence: 'الخزانة مليئة بالملابس - The wardrobe is full of clothes'),
    VocabularyItem(arabicWord: 'ثلاجة', englishMeaning: 'Refrigerator', exampleSentence: 'الثلاجة تحتوي على طعام - The refrigerator contains food'),
    VocabularyItem(arabicWord: 'فرن', englishMeaning: 'Oven', exampleSentence: 'الفرن ساخن - The oven is hot'),
    VocabularyItem(arabicWord: 'غسالة', englishMeaning: 'Washing machine', exampleSentence: 'الغسالة جديدة - The washing machine is new'),
    
    // Week 5: School & Education
    VocabularyItem(arabicWord: 'مدرسة', englishMeaning: 'School', exampleSentence: 'المدرسة قريبة من البيت - The school is near the house'),
    VocabularyItem(arabicWord: 'طالب', englishMeaning: 'Student (male)', exampleSentence: 'الطالب مجتهد - The student is hardworking'),
    VocabularyItem(arabicWord: 'طالبة', englishMeaning: 'Student (female)', exampleSentence: 'الطالبة ذكية - The student is smart'),
    VocabularyItem(arabicWord: 'معلم', englishMeaning: 'Teacher (male)', exampleSentence: 'المعلم يشرح الدرس - The teacher explains the lesson'),
    VocabularyItem(arabicWord: 'معلمة', englishMeaning: 'Teacher (female)', exampleSentence: 'المعلمة تساعد الطلاب - The teacher helps students'),
    VocabularyItem(arabicWord: 'درس', englishMeaning: 'Lesson', exampleSentence: 'الدرس سهل - The lesson is easy'),
    VocabularyItem(arabicWord: 'واجب', englishMeaning: 'Homework', exampleSentence: 'أعمل الواجب الآن - I do homework now'),
    VocabularyItem(arabicWord: 'امتحان', englishMeaning: 'Exam', exampleSentence: 'الامتحان الأسبوع القادم - The exam is next week'),
    VocabularyItem(arabicWord: 'كتاب', englishMeaning: 'Book', exampleSentence: 'أقرأ كتاباً مفيداً - I read a useful book'),
    VocabularyItem(arabicWord: 'قلم', englishMeaning: 'Pen', exampleSentence: 'أكتب بقلم أزرق - I write with a blue pen'),
    
    // Week 6: Transportation
    VocabularyItem(arabicWord: 'سيارة', englishMeaning: 'Car', exampleSentence: 'سيارتي حمراء - My car is red'),
    VocabularyItem(arabicWord: 'باص', englishMeaning: 'Bus', exampleSentence: 'أركب الباص للعمل - I take the bus to work'),
    VocabularyItem(arabicWord: 'قطار', englishMeaning: 'Train', exampleSentence: 'القطار سريع - The train is fast'),
    VocabularyItem(arabicWord: 'طائرة', englishMeaning: 'Airplane', exampleSentence: 'أسافر بالطائرة - I travel by plane'),
    VocabularyItem(arabicWord: 'دراجة', englishMeaning: 'Bicycle', exampleSentence: 'أركب الدراجة في الحديقة - I ride the bicycle in the park'),
    VocabularyItem(arabicWord: 'دراجة نارية', englishMeaning: 'Motorcycle', exampleSentence: 'الدراجة النارية سريعة - The motorcycle is fast'),
    VocabularyItem(arabicWord: 'تاكسي', englishMeaning: 'Taxi', exampleSentence: 'آخذ تاكسي إلى المطار - I take a taxi to the airport'),
    VocabularyItem(arabicWord: 'محطة', englishMeaning: 'Station', exampleSentence: 'المحطة مزدحمة - The station is crowded'),
    VocabularyItem(arabicWord: 'مطار', englishMeaning: 'Airport', exampleSentence: 'المطار كبير - The airport is big'),
    VocabularyItem(arabicWord: 'ميناء', englishMeaning: 'Port', exampleSentence: 'السفن في الميناء - Ships in the port'),
    
    // Week 7: Shopping
    VocabularyItem(arabicWord: 'سوق', englishMeaning: 'Market', exampleSentence: 'أذهب إلى السوق يوم الجمعة - I go to the market on Friday'),
    VocabularyItem(arabicWord: 'متجر', englishMeaning: 'Shop', exampleSentence: 'المتجر مفتوح - The shop is open'),
    VocabularyItem(arabicWord: 'شراء', englishMeaning: 'Buy', exampleSentence: 'أشتري الخبز - I buy bread'),
    VocabularyItem(arabicWord: 'بيع', englishMeaning: 'Sell', exampleSentence: 'هو يبيع الفواكه - He sells fruits'),
    VocabularyItem(arabicWord: 'سعر', englishMeaning: 'Price', exampleSentence: 'السعر مناسب - The price is reasonable'),
    VocabularyItem(arabicWord: 'مال', englishMeaning: 'Money', exampleSentence: 'ليس لدي مال كاف - I don\'t have enough money'),
    VocabularyItem(arabicWord: 'بطاقة', englishMeaning: 'Card', exampleSentence: 'أدفع بالبطاقة - I pay by card'),
    VocabularyItem(arabicWord: 'نقود', englishMeaning: 'Cash', exampleSentence: 'أحتاج نقوداً - I need cash'),
    VocabularyItem(arabicWord: 'خصم', englishMeaning: 'Discount', exampleSentence: 'هل هناك خصم؟ - Is there a discount?'),
    VocabularyItem(arabicWord: 'مقاس', englishMeaning: 'Size', exampleSentence: 'ما المقاس المناسب؟ - What is the appropriate size?'),
    
    // Week 8: Weather & Nature
    VocabularyItem(arabicWord: 'طقس', englishMeaning: 'Weather', exampleSentence: 'الطقس جميل اليوم - The weather is beautiful today'),
    VocabularyItem(arabicWord: 'شمس', englishMeaning: 'Sun', exampleSentence: 'الشمس مشرقة - The sun is shining'),
    VocabularyItem(arabicWord: 'قمر', englishMeaning: 'Moon', exampleSentence: 'القمر جميل الليلة - The moon is beautiful tonight'),
    VocabularyItem(arabicWord: 'نجم', englishMeaning: 'Star', exampleSentence: 'النجوم تلمع - The stars are shining'),
    VocabularyItem(arabicWord: 'مطر', englishMeaning: 'Rain', exampleSentence: 'المطر يهطل الآن - Rain is falling now'),
    VocabularyItem(arabicWord: 'ريح', englishMeaning: 'Wind', exampleSentence: 'الريح قوية - The wind is strong'),
    VocabularyItem(arabicWord: 'ثلج', englishMeaning: 'Snow', exampleSentence: 'الثلج أبيض - Snow is white'),
    VocabularyItem(arabicWord: 'حر', englishMeaning: 'Heat', exampleSentence: 'الجو حار اليوم - The weather is hot today'),
    VocabularyItem(arabicWord: 'برد', englishMeaning: 'Cold', exampleSentence: 'الجو بارد في الشتاء - The weather is cold in winter'),
    VocabularyItem(arabicWord: 'غيم', englishMeaning: 'Cloud', exampleSentence: 'الغيم في السماء - Clouds in the sky'),
  ];

  // ==================== EXTENSIVE LESSONS DATA ====================
  static List<Lesson> lessons = [
    // Lesson 1: Basic Greetings
    Lesson(
      id: '1',
      title: 'Basic Greetings',
      topic: 'Essential Greetings',
      conversations: [
        ConversationLine(arabic: 'السلام عليكم', english: 'Peace be upon you (Hello)'),
        ConversationLine(arabic: 'وعليكم السلام', english: 'And upon you be peace'),
        ConversationLine(arabic: 'كيف حالك؟', english: 'How are you?'),
        ConversationLine(arabic: 'أنا بخير، الحمد لله', english: 'I am fine, praise be to God'),
        ConversationLine(arabic: 'وأنت؟', english: 'And you?'),
        ConversationLine(arabic: 'أنا أيضاً بخير', english: 'I am also fine'),
        ConversationLine(arabic: 'ما أخبارك؟', english: 'What\'s new with you?'),
        ConversationLine(arabic: 'كل شيء على ما يرام', english: 'Everything is fine'),
        ConversationLine(arabic: 'أهلاً وسهلاً', english: 'Welcome'),
        ConversationLine(arabic: 'الله يرحب بك', english: 'God welcomes you'),
      ],
    ),
    
    // Lesson 2: Introducing Yourself
    Lesson(
      id: '2',
      title: 'Introducing Yourself',
      topic: 'Self Introduction',
      conversations: [
        ConversationLine(arabic: 'مرحباً! اسمي أحمد', english: 'Hello! My name is Ahmed'),
        ConversationLine(arabic: 'تشرفت بمعرفتك', english: 'Nice to meet you'),
        ConversationLine(arabic: 'أنا من مصر', english: 'I am from Egypt'),
        ConversationLine(arabic: 'أين أنت من؟', english: 'Where are you from?'),
        ConversationLine(arabic: 'أنا من أمريكا', english: 'I am from America'),
        ConversationLine(arabic: 'كم عمرك؟', english: 'How old are you?'),
        ConversationLine(arabic: 'عمري ٢٥ سنة', english: 'I am 25 years old'),
        ConversationLine(arabic: 'ماذا تعمل؟', english: 'What do you do?'),
        ConversationLine(arabic: 'أنا مهندس', english: 'I am an engineer'),
        ConversationLine(arabic: 'أنا طالب', english: 'I am a student'),
      ],
    ),
    
    // Lesson 3: Family Conversation
    Lesson(
      id: '3',
      title: 'Family Conversation',
      topic: 'Talking about Family',
      conversations: [
        ConversationLine(arabic: 'هل أنت متزوج؟', english: 'Are you married?'),
        ConversationLine(arabic: 'نعم أنا متزوج', english: 'Yes, I am married'),
        ConversationLine(arabic: 'كم عدد أفراد عائلتك؟', english: 'How many members in your family?'),
        ConversationLine(arabic: 'عائلتي تتكون من ٤ أفراد', english: 'My family consists of 4 members'),
        ConversationLine(arabic: 'هل لديك أطفال؟', english: 'Do you have children?'),
        ConversationLine(arabic: 'نعم لدي طفلان', english: 'Yes, I have two children'),
        ConversationLine(arabic: 'ما اسم ابنك؟', english: 'What is your son\'s name?'),
        ConversationLine(arabic: 'اسمه عمر', english: 'His name is Omar'),
        ConversationLine(arabic: 'هل تعيش مع عائلتك؟', english: 'Do you live with your family?'),
        ConversationLine(arabic: 'نعم أعيش مع عائلتي', english: 'Yes, I live with my family'),
      ],
    ),
    
    // Lesson 4: At the Restaurant
    Lesson(
      id: '4',
      title: 'At the Restaurant',
      topic: 'Ordering Food',
      conversations: [
        ConversationLine(arabic: 'مرحباً! طاولة لشخصين من فضلك', english: 'Hello! A table for two please'),
        ConversationLine(arabic: 'تفضلوا اجلسوا', english: 'Please, have a seat'),
        ConversationLine(arabic: 'هل لديكم قائمة الطعام؟', english: 'Do you have the menu?'),
        ConversationLine(arabic: 'تفضل هذه قائمة الطعام', english: 'Here is the menu'),
        ConversationLine(arabic: 'ماذا توصي؟', english: 'What do you recommend?'),
        ConversationLine(arabic: 'أوصي بالدجاج المشوي', english: 'I recommend the grilled chicken'),
        ConversationLine(arabic: 'أريد طبق دجاج مع أرز', english: 'I want a chicken dish with rice'),
        ConversationLine(arabic: 'هل تريد مشروباً؟', english: 'Do you want a drink?'),
        ConversationLine(arabic: 'نعم عصير برتقال من فضلك', english: 'Yes, orange juice please'),
        ConversationLine(arabic: 'الفاتورة من فضلك', english: 'The bill please'),
      ],
    ),
    
    // Lesson 5: Shopping
    Lesson(
      id: '5',
      title: 'Shopping',
      topic: 'At the Store',
      conversations: [
        ConversationLine(arabic: 'صباح الخير! كيف يمكنني مساعدتك؟', english: 'Good morning! How can I help you?'),
        ConversationLine(arabic: 'أبحث عن قميص', english: 'I am looking for a shirt'),
        ConversationLine(arabic: 'ما المقاس الذي تريد؟', english: 'What size do you want?'),
        ConversationLine(arabic: 'مقاس Medium', english: 'Medium size'),
        ConversationLine(arabic: 'ما هو لونك المفضل؟', english: 'What is your favorite color?'),
        ConversationLine(arabic: 'أحب اللون الأزرق', english: 'I like blue color'),
        ConversationLine(arabic: 'كم سعر هذا القميص؟', english: 'How much is this shirt?'),
        ConversationLine(arabic: 'سعره ٥٠ درهماً', english: 'It costs 50 dirhams'),
        ConversationLine(arabic: 'هل يمكنني تجربته؟', english: 'Can I try it on?'),
        ConversationLine(arabic: 'نعم غرفة القياس هناك', english: 'Yes, the fitting room is there'),
      ],
    ),
    
    // Lesson 6: Asking for Directions
    Lesson(
      id: '6',
      title: 'Asking for Directions',
      topic: 'Finding Your Way',
      conversations: [
        ConversationLine(arabic: 'عفواً، هل يمكنك مساعدتي؟', english: 'Excuse me, can you help me?'),
        ConversationLine(arabic: 'نعم بالتأكيد', english: 'Yes, of course'),
        ConversationLine(arabic: 'أين محطة القطار؟', english: 'Where is the train station?'),
        ConversationLine(arabic: 'امشِ straight ثم انعطف يساراً', english: 'Walk straight then turn left'),
        ConversationLine(arabic: 'هل هي بعيدة؟', english: 'Is it far?'),
        ConversationLine(arabic: 'لا إنها قريبة', english: 'No, it\'s near'),
        ConversationLine(arabic: 'كم دقيقة تحتاج؟', english: 'How many minutes does it take?'),
        ConversationLine(arabic: 'حوالي ١٠ دقائق', english: 'About 10 minutes'),
        ConversationLine(arabic: 'شكراً جزيلاً', english: 'Thank you very much'),
        ConversationLine(arabic: 'عفواً', english: 'You\'re welcome'),
      ],
    ),
    
    // Lesson 7: At the Hospital
    Lesson(
      id: '7',
      title: 'At the Hospital',
      topic: 'Health & Medical',
      conversations: [
        ConversationLine(arabic: 'أشعر بالتعب', english: 'I feel tired'),
        ConversationLine(arabic: 'ما هي الأعراض؟', english: 'What are the symptoms?'),
        ConversationLine(arabic: 'لدي صداع وحرارة', english: 'I have a headache and fever'),
        ConversationLine(arabic: 'منذ متى وأنت تشعر بذلك؟', english: 'How long have you been feeling this?'),
        ConversationLine(arabic: 'منذ يومين', english: 'For two days'),
        ConversationLine(arabic: 'سأقيس حرارتك', english: 'I will measure your temperature'),
        ConversationLine(arabic: 'هل أنت متعب؟', english: 'Are you tired?'),
        ConversationLine(arabic: 'نعم أشعر بالتعب الشديد', english: 'Yes, I feel very tired'),
        ConversationLine(arabic: 'ستحتاج للراحة', english: 'You will need rest'),
        ConversationLine(arabic: 'خذ هذا الدواء', english: 'Take this medicine'),
      ],
    ),
    
    // Lesson 8: At Work
    Lesson(
      id: '8',
      title: 'At Work',
      topic: 'Office Conversation',
      conversations: [
        ConversationLine(arabic: 'صباح الخير زملائي', english: 'Good morning colleagues'),
        ConversationLine(arabic: 'صباح النور', english: 'Good morning'),
        ConversationLine(arabic: 'هل انتهيت من التقرير؟', english: 'Did you finish the report?'),
        ConversationLine(arabic: 'نعم سأرسله الآن', english: 'Yes, I will send it now'),
        ConversationLine(arabic: 'متى الاجتماع؟', english: 'When is the meeting?'),
        ConversationLine(arabic: 'الساعة الثالثة', english: 'At three o\'clock'),
        ConversationLine(arabic: 'من سيحضر الاجتماع؟', english: 'Who will attend the meeting?'),
        ConversationLine(arabic: 'جميع الموظفين', english: 'All employees'),
        ConversationLine(arabic: 'هل لديك أسئلة؟', english: 'Do you have any questions?'),
        ConversationLine(arabic: 'لا كل شيء واضح', english: 'No, everything is clear'),
      ],
    ),
    
    // Lesson 9: Travel Conversation
    Lesson(
      id: '9',
      title: 'Travel Conversation',
      topic: 'At the Airport',
      conversations: [
        ConversationLine(arabic: 'أريد تذكرة إلى دبي', english: 'I want a ticket to Dubai'),
        ConversationLine(arabic: 'رحلة ذهاب فقط أم ذهاب وعودة؟', english: 'One way or round trip?'),
        ConversationLine(arabic: 'ذهاب وعودة', english: 'Round trip'),
        ConversationLine(arabic: 'ما هو جواز سفرك؟', english: 'What is your passport?'),
        ConversationLine(arabic: 'هذا جواز سفري', english: 'Here is my passport'),
        ConversationLine(arabic: 'كم وزن الحقيبة؟', english: 'How much does the bag weigh?'),
        ConversationLine(arabic: 'حوالي ٢٠ كيلو', english: 'About 20 kilos'),
        ConversationLine(arabic: 'ما هو وقت الرحلة؟', english: 'What is the flight time?'),
        ConversationLine(arabic: 'الساعة العاشرة صباحاً', english: 'At 10 AM'),
        ConversationLine(arabic: 'من أي بوابة؟', english: 'Which gate?'),
      ],
    ),
    
    // Lesson 10: Daily Routine
    Lesson(
      id: '10',
      title: 'Daily Routine',
      topic: 'Daily Activities',
      conversations: [
        ConversationLine(arabic: 'متى تستيقظ كل يوم؟', english: 'When do you wake up every day?'),
        ConversationLine(arabic: 'أستيقظ في الساعة السادسة', english: 'I wake up at 6 o\'clock'),
        ConversationLine(arabic: 'ماذا تفعل بعد الاستيقاظ؟', english: 'What do you do after waking up?'),
        ConversationLine(arabic: 'أصلي ثم أتناول الفطور', english: 'I pray then have breakfast'),
        ConversationLine(arabic: 'متى تذهب إلى العمل؟', english: 'When do you go to work?'),
        ConversationLine(arabic: 'أذهب إلى العمل في الثامنة', english: 'I go to work at 8 o\'clock'),
        ConversationLine(arabic: 'متى تعود إلى البيت؟', english: 'When do you return home?'),
        ConversationLine(arabic: 'أعود في السادسة مساءً', english: 'I return at 6 PM'),
        ConversationLine(arabic: 'ماذا تفعل في المساء؟', english: 'What do you do in the evening?'),
        ConversationLine(arabic: 'أشاهد التلفاز ثم أنام', english: 'I watch TV then sleep'),
      ],
    ),
    
    // Lesson 11: Weather
    Lesson(
      id: '11',
      title: 'Weather Conversation',
      topic: 'Talking about Weather',
      conversations: [
        ConversationLine(arabic: 'كيف الطقس اليوم؟', english: 'How is the weather today?'),
        ConversationLine(arabic: 'الجو مشمس وجميل', english: 'The weather is sunny and beautiful'),
        ConversationLine(arabic: 'هل تمطر غداً؟', english: 'Will it rain tomorrow?'),
        ConversationLine(arabic: 'نعم توقعوا مطراً', english: 'Yes, rain is expected'),
        ConversationLine(arabic: 'ما درجة الحرارة؟', english: 'What is the temperature?'),
        ConversationLine(arabic: 'درجة الحرارة ٢٥ درجة', english: 'The temperature is 25 degrees'),
        ConversationLine(arabic: 'الجو حار جداً', english: 'The weather is very hot'),
        ConversationLine(arabic: 'الجو بارد في الشتاء', english: 'The weather is cold in winter'),
        ConversationLine(arabic: 'هل تحب الشتاء أم الصيف؟', english: 'Do you like winter or summer?'),
        ConversationLine(arabic: 'أحب الربيع', english: 'I like spring'),
      ],
    ),
    
    // Lesson 12: Education
    Lesson(
      id: '12',
      title: 'Education',
      topic: 'School & University',
      conversations: [
        ConversationLine(arabic: 'أين تدرس؟', english: 'Where do you study?'),
        ConversationLine(arabic: 'أدرس في جامعة القاهرة', english: 'I study at Cairo University'),
        ConversationLine(arabic: 'ما هو تخصصك؟', english: 'What is your major?'),
        ConversationLine(arabic: 'أدرس اللغة العربية', english: 'I study Arabic language'),
        ConversationLine(arabic: 'كم سنة دراستك؟', english: 'How many years of study?'),
        ConversationLine(arabic: 'أربع سنوات', english: 'Four years'),
        ConversationLine(arabic: 'هل تحب الجامعة؟', english: 'Do you like the university?'),
        ConversationLine(arabic: 'نعم أحبها كثيراً', english: 'Yes, I like it very much'),
        ConversationLine(arabic: 'ما هي المواد المفضلة؟', english: 'What are your favorite subjects?'),
        ConversationLine(arabic: 'أحب الأدب', english: 'I like literature'),
      ],
    ),
    
    // Lesson 13: Hobbies
    Lesson(
      id: '13',
      title: 'Hobbies',
      topic: 'Free Time Activities',
      conversations: [
        ConversationLine(arabic: 'ما هي هواياتك؟', english: 'What are your hobbies?'),
        ConversationLine(arabic: 'أحب القراءة والسباحة', english: 'I like reading and swimming'),
        ConversationLine(arabic: 'هل تحب الرياضة؟', english: 'Do you like sports?'),
        ConversationLine(arabic: 'نعم أحب كرة القدم', english: 'Yes, I like football'),
        ConversationLine(arabic: 'كم مرة تمارس الرياضة؟', english: 'How often do you exercise?'),
        ConversationLine(arabic: 'ثلاث مرات في الأسبوع', english: 'Three times a week'),
        ConversationLine(arabic: 'ماذا تفعل في عطلة نهاية الأسبوع؟', english: 'What do you do on weekends?'),
        ConversationLine(arabic: 'أخرج مع الأصدقاء', english: 'I go out with friends'),
        ConversationLine(arabic: 'هل تحب السفر؟', english: 'Do you like traveling?'),
        ConversationLine(arabic: 'نعم السفر شغفي', english: 'Yes, traveling is my passion'),
      ],
    ),
    
    // Lesson 14: Phone Conversation
    Lesson(
      id: '14',
      title: 'Phone Conversation',
      topic: 'Talking on the Phone',
      conversations: [
        ConversationLine(arabic: 'ألو؟', english: 'Hello?'),
        ConversationLine(arabic: 'السلام عليكم', english: 'Hello'),
        ConversationLine(arabic: 'مع من أتحدث؟', english: 'Who am I speaking with?'),
        ConversationLine(arabic: 'مع أحمد', english: 'With Ahmed'),
        ConversationLine(arabic: 'هل يمكنني التحدث مع سارة؟', english: 'Can I speak with Sarah?'),
        ConversationLine(arabic: 'لحظة من فضلك', english: 'One moment please'),
        ConversationLine(arabic: 'سارة ليست هنا', english: 'Sarah is not here'),
        ConversationLine(arabic: 'هل تريد ترك رسالة؟', english: 'Do you want to leave a message?'),
        ConversationLine(arabic: 'نعم قل لها اتصل بي', english: 'Yes, tell her to call me'),
        ConversationLine(arabic: 'سأخبرها', english: 'I will tell her'),
      ],
    ),
    
    // Lesson 15: At the Hotel
    Lesson(
      id: '15',
      title: 'At the Hotel',
      topic: 'Hotel Check-in',
      conversations: [
        ConversationLine(arabic: 'مرحباً! لدي حجز', english: 'Hello! I have a reservation'),
        ConversationLine(arabic: 'ما هو اسمك؟', english: 'What is your name?'),
        ConversationLine(arabic: 'أحمد محمد', english: 'Ahmed Mohamed'),
        ConversationLine(arabic: 'نعم وجدت الحجز', english: 'Yes, I found the reservation'),
        ConversationLine(arabic: 'غرفة لشخص واحد', english: 'A single room'),
        ConversationLine(arabic: 'كم ليلة ستبقى؟', english: 'How many nights will you stay?'),
        ConversationLine(arabic: 'ثلاث ليالٍ', english: 'Three nights'),
        ConversationLine(arabic: 'هذا مفتاح غرفتك', english: 'This is your room key'),
        ConversationLine(arabic: 'أين المصعد؟', english: 'Where is the elevator?'),
        ConversationLine(arabic: 'المصعد هناك', english: 'The elevator is there'),
      ],
    ),
  ];
}