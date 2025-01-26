class SabaiAppData {
  final String _fixedPinNumber = "000000";

  final List<String> _provinceItemsInEng = [
    'Samut Sakhon',
    'Ranong',
    'Tak',
    'Chiang Rai',
    'Pathum Thani',
    'Nonthaburi',
    'Chiang Mai',
    'Kanchanaburi',
    'Rayong',
    'Chumphon',
    'Surat Thani',
    'Bangkok',
    'Phuket',
    'Chon Buri',
    'Phetchabun',
  ];

  final List<String> _provinceItemsInMm = [
    'စမွတ်ဆာခွန်',
    'ရနောင်း',
    'တာ့ခ်',
    'ချင်းရိုင်',
    'ပထုမ်ဌာနီ',
    'နွန်သဘူရီ',
    'ချင်းမိုင်',
    'ကန်ချနာဘူရီ',
    'ရရောင်း',
    'ချွန်ပွန်',
    'ဆူရက်ဌာနီ',
    'ဘန်ကောက်',
    'ဖူးခက်',
    'ချောင်ဘူရီ',
    'ပက်ချဘွန်း',
  ];

  final List<String> _genderItemsInEng = ['Male', 'Female', 'Others'];

  final List<String> _genderItemsInMm = ['ကျား', 'မ', 'အခြား'];

  final List<String> _durationItemsInEng = ['Months', 'Years'];

  final List<String> _durationItemsInMm = ['လ', 'နှစ်'];

  final List<String> _languageLevelsInEng = [
    'Novice',
    'Basic',
    'Conversational',
    'Working Proficiency',
    'Fluenct'
  ];

  final List<String> _languageLevelsInMm = ['will add values later'];

  final List<Map<String, dynamic>> _jobCategoriesInEng = [
    {'name': 'Hotels', 'emoji': '🏨', 'selected': false},
    {'name': 'Restaurants', 'emoji': '👨‍🍳', 'selected': false},
    {'name': 'Beauty', 'emoji': '💋', 'selected': false},
    {'name': 'Teaching', 'emoji': '👩‍🏫', 'selected': false},
    {'name': 'Healthcare', 'emoji': '🏥', 'selected': false},
    {'name': 'Construction', 'emoji': '🏗️', 'selected': false},
    {'name': 'Technology', 'emoji': '💻', 'selected': false},
    {'name': 'Transportation', 'emoji': '🚛', 'selected': false},
    {'name': 'Finance', 'emoji': '💰', 'selected': false},
    {'name': 'Art & Design', 'emoji': '🎨', 'selected': false},
    {'name': 'Sports', 'emoji': '⚽', 'selected': false},
    {'name': 'Retail', 'emoji': '🛍️', 'selected': false},
    {'name': 'Media', 'emoji': '🎥', 'selected': false},
    {'name': 'Agriculture', 'emoji': '🌾', 'selected': false},
  ];

  final List<Map<String, dynamic>> _jobCategoriesInMm = [
    {'name': 'ဟိုတယ်များ', 'emoji': '🏨', 'selected': true},
    {'name': 'စားသောက်ဆိုင်များ', 'emoji': '👨‍🍳', 'selected': false},
    {'name': 'အလှပရေးရာ', 'emoji': '💋', 'selected': false},
    {'name': 'သင်ကြားရေး', 'emoji': '👩‍🏫', 'selected': false},
  ];

  final List<String> _jobType = ['Remote', 'Full Time', 'Hybrid', 'On Site'];

  String get fixedPinNumber => _fixedPinNumber;

  List<String> get provinceItemsInEng => _provinceItemsInEng;

  List<String> get provinceItemsInMm => _provinceItemsInMm;

  List<String> get genderItemsInEng => _genderItemsInEng;

  List<String> get genderItemsInMm => _genderItemsInMm;

  List<String> get durationItemsInEng => _durationItemsInEng;

  List<String> get durationItemsInMm => _durationItemsInMm;

  List<String> get languageLevelsInEng => _languageLevelsInEng;

  List<String> get languageLevelsInMm => _languageLevelsInMm;

  List<Map<String, dynamic>> get jobCategoryInEng => _jobCategoriesInEng;

  List<Map<String, dynamic>> get jobCategoryInMm => _jobCategoriesInMm;

  List<String> get jobTypes => _jobType;
}
