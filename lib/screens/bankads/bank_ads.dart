import 'dart:io';
import 'package:auto_route/annotations.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/screens/bankads/AdModel.dart';
import 'package:sislimoda_admin_dashboard/screens/bankads/widgets/Adservices.dart';


@RoutePage()
class BankAdsScreen extends StatefulWidget {
  const BankAdsScreen({super.key});

  @override
  State<BankAdsScreen> createState() => _BankAdsScreenState();
}

class _BankAdsScreenState extends State<BankAdsScreen> {
  List<AdModel> ads = [];
  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;
  ValueItem? selectedCountry;
  bool get isArabic => context.locale.languageCode == 'ar';

List<ValueItem> get countries => [
  ValueItem(label: isArabic ? 'مصر' : 'Egypt', value:isArabic ? 'مصر' : 'Egypt'),
  ValueItem(label: isArabic ? 'الكويت' : 'Kuwait', value: isArabic ? 'الكويت' : 'Kuwait'),
  ValueItem(label: isArabic ? 'السعودية' : 'Saudi Arabia', value:isArabic ? 'السعودية' : 'Saudi Arabia'),
  ValueItem(label: isArabic ? 'الإمارات' : 'United Arab Emirates', value: 'AE'),
  ValueItem(label: isArabic ? 'الأردن' : 'Jordan', value: isArabic ? 'الأردن' : 'Jordan'),
  ValueItem(label: isArabic ? 'البحرين' : 'Bahrain', value: isArabic ? 'البحرين' : 'Bahrain'),
  ValueItem(label: isArabic ? 'قطر' : 'Qatar', value: isArabic ? 'قطر' : 'Qatar'),
  ValueItem(label: isArabic ? 'عمان' : 'Oman', value: isArabic ? 'عمان' : 'Oman'),
];
Uint8List? imageBytes;





  @override
  void initState() {
    super.initState();
    fetchBankAds();
  }

  Future<void> fetchBankAds() async {
    try {
      final data = await AdServices.fetchAds();
      setState(() {
        ads = data;
      });
    } catch (e) {
      showErrorMessage(message: isArabic ? "فشل في تحميل الإعلانات" : "Failed to load ads");
    }
  }

  Future<void> addBankAd() async {
    if (pickedImage != null && selectedCountry != null) {
      try {
        await AdServices.addAd(image: pickedImage!, country: selectedCountry!);
        Navigator.pop(context);
        fetchBankAds();
        showSuccessMessage(message: isArabic ? "تمت الإضافة بنجاح" : "Ad added successfully");
      } catch (e) {
        showErrorMessage(message: isArabic ? "فشل في رفع الإعلان" : "Failed to upload ad");
      }
    } else {
      showErrorMessage(
        message: isArabic ? "يرجى اختيار صورة ودولة" : "Please select image and country",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        ctx: context,
        // search: (value) {
        // },
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: ElevatedButton(
                onPressed: () {
  pickedImage = null;
  selectedCountry = null;
  imageBytes = null;

 showDialog(
  context: context,
  builder: (context) => Dialog(
    child: StatefulBuilder(
      builder: (context, setStateDialog) => Container(
        padding: const EdgeInsets.all(16),
        width: 400, // حدد عرض مناسب حسب تصميمك
        height: 400, // ارتفاع ثابت علشان الـDropDown تشتغل صح
        child: Column(
          children: [
            Text(isArabic ? "إضافة إعلان" : "Add Bank Ad", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  final bytes = await image.readAsBytes();
                  setStateDialog(() {
                    pickedImage = image;
                    imageBytes = bytes;
                  });
                }
              },
              child: Text(isArabic ? "اختيار صورة" : "Pick Image"),
            ),
            const SizedBox(height: 10),
            if (imageBytes != null)
              Image.memory(imageBytes!, height: 100, fit: BoxFit.cover),
            const SizedBox(height: 10),

            SizedBox(
              height: 60,
              child: MultiSelectDropDown(
                options: countries,
                selectedOptions: selectedCountry != null ? [selectedCountry!] : [],
                onOptionSelected: (options) {
                  if (options.isNotEmpty) {
                    setStateDialog(() {
                      selectedCountry = options.first;
                    });
                  }
                },
                hint: isArabic ? "اختر الدولة" : "Select Country",
                maxItems: 1,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(tr("إلغاء")),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    if (pickedImage != null && selectedCountry != null) {
                      try {
                        await AdServices.addAd(image: pickedImage!, country: selectedCountry!);
                        Navigator.pop(context);
                        fetchBankAds();
                        showSuccessMessage(message: isArabic ? "تمت الإضافة بنجاح" : "Ad added successfully");
                      } catch (e) {
                        showErrorMessage(message: isArabic ? "فشل في رفع الإعلان" : "Failed to upload ad");
                      }
                    } else {
                      showErrorMessage(message: isArabic ? "يرجى اختيار صورة ودولة" : "Please select image and country");
                    }
                  },
                  child: Text(tr("إضافة")),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  ),
);


},


                child: Text(tr("إضافة إعلان")),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: DataTable2(
                columnSpacing: 12,
                columns: [
                  DataColumn(label: Text(tr("الدولة"))),
                  DataColumn(label: Text(tr("الصورة"))),
                ],
                rows: ads
                    .map(
                      (ad) => DataRow(
                        cells: [
                          DataCell(Text(ad.country ?? '')),
                          DataCell(CustomNetworkImage(
                            link: ad.fullImageUrl,
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          )),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
