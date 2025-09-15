import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
       "profile":"My Profile",
      "followers":"Followers",
      "requests":"Requests",
      "property":"Property",
      "personal data":"Persoal Data",
      "name":"Name",
      "description":"Description",
      "percentage":"Percentage",
      "email":"Email",
      "number":"Number",
      "setting":"Setting",
      "edit":"Edite",
      "language":"Language",
      "subscription":"Subcription",
      "logout":"Logout",
      "save":"Save",
      "choose language":"Choose Language",
      "english":"English",
      "arabic":"Arabic",
      "check your connection":"Check Your Connection",
      "no followers":"No Followers",
      "add":"Add",
      "welcom home":"Welcom You Can Manage Your Propeties Easy Here",
      "no new  requsts":"No New  Requests",
      "apartment":"apartment",
      "accept":"accept",
      "delete":"delete",
      "location":"Location",
      "owner":"Owner",
      "phone":"Phone",
      "contract type":"Contract Type",
      "price":"Price",
      "space":"Space",
      "sale":"Sale",
      "rent":"Rent",
      "per month":"per month",
      "m":"m²",
      "residentail":"Residentail",
      "agricultural":"Agricultural",
      "commercial":"Commercial",
      "industrial":"Industrial",
      "no data":"No Data"
    },
    'ar': {
       "profile":"الملف الشخصي",
      "followers":"المتابعين",
      "requests":"الطلبات",
      "property":"العقارات",
      "personal data":"معلومات شخصية",
      "name":"الاسم",
      "description":"وصف",
      "percentage":"النسبة",
      "email":"البريد الالكتروني",
      "number":"الرقم",
      "setting":"الإعدادت",
      "edit":"تعديل",
      "language":"اللغة",
      "subscription":"الاشتراك",
      "logout":"تسجيل الخروج",
      "save":"حفظ",
      "choose language":"اختيار لغة",
      "english":"الانكليزية",
      "arabic":"العربية",
      "check your connection":"تحقق من  اتصالك  بالانترنت",
      "no followers":"لا يوجد متابعين",
      "add":"إضافة",
      "welcom home":"مرحباً , يمكنك الآن إدارة  عقاراتك  بشكل اسهل من هنا",
      "no new rquests":"لا يوجد طلبات  جديدة",
      "apartment":"شقة",
      "accept":"تأكيد",
      "delete":"حذف",
      "location":"الموقع",
      "owner":"المالك",
      "phone":"الهاتف",
      "contract type":"نوع العقد",
      "price":"السعر",
      "space":"المساحة",
      "sale":"بيع",
      "rent":"إيجار",
      "per month":"per month",
      "m":"م²",
      "residentail":"سكني",
      "agricultural":"زراعي",
      "commercial":"تجاري",
      "industrial":"صناعي",
      "no data":"لا يوجد بيانات"
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
