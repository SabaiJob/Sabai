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

  final List<String> _genderItemsInEng = ['male', 'female', 'others'];

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

  final List<String> _jobCategoriesInEng = [
    'Hotel 🏨',
    'Restaurant 🧑‍🍳',
    'Beauty 💋',
    'Teaching\t👩‍🏫',
  ];

  final List<String> _jobCategoriesInMm = [
    'ဟိုတယ်များ 🏨',
    'စားသောက်ဆိုင်များ 🧑‍🍳',
    'အလှပရေးရာ 💋',
    'သင်ကြားရေး\t👩‍🏫',
  ];

  

  String get fixedPinNumber => _fixedPinNumber;

  List<String> get provinceItemsInEng => _provinceItemsInEng;

  List<String> get provinceItemsInMm => _provinceItemsInMm;

  List<String> get genderItemsInEng => _genderItemsInEng;

  List<String> get genderItemsInMm => _genderItemsInMm;

  List<String> get durationItemsInEng => _durationItemsInEng;

  List<String> get durationItemsInMm => _durationItemsInMm;

  List<String> get languageLevelsInEng => _languageLevelsInEng;

  List<String> get languageLevelsInMm => _languageLevelsInMm;

  List<String> get jobCategoryInEng => _jobCategoriesInEng;

  List<String> get jobCategoryInMm => _jobCategoriesInMm;
}
