import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddComplaintView extends StatefulWidget {
  const AddComplaintView({super.key});

  @override
  State<AddComplaintView> createState() => _AddComplaintViewState();
}

class _AddComplaintViewState extends State<AddComplaintView> {
  String? _selectedCategory;
  String? _selectedGovernment;
  String _selectedPriority = 'منخفضة';

  final List<String> _categories = [
    'خدمات عامة',
    'كهرباء ومياه',
    'طرق ومواصلات',
    'صحة',
  ];
  final List<String> _governments = [
    'وزارة الأشغال',
    'البلدية',
    'وزارة الكهرباء',
    'وزارة الصحة',
  ];

  // قائمة أسماء الصور التي أضفتها في pubspec.yaml
  final List<String> _complaintImages = [
    'assets/images/trash_complaint.png',
    'assets/images/drought_complaint.png',
    'assets/images/pollution_complaint.png',
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        // --- AppBar المطابق للفيغما ---
        appBar: AppBar(
          backgroundColor: const Color(0xFF0C655E),
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // اليمين: زر رجوع والسهم
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20 * scale,
                        ),
                        SizedBox(width: 4 * scale),
                        Text(
                          'رجوع',
                          style: GoogleFonts.tajawal(
                            fontSize: 16 * scale,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // الوسط: عنوان الشاشة
                  Text(
                    'تقديم شكوى جديدة',
                    style: GoogleFonts.tajawal(
                      fontSize: 17 * scale,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // اليسار: الشعار والنسر مع كلمة شكوى
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 42 * scale,
                        width: 83 * scale,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.shield,
                          color: const Color(0xFFD4AF37),
                          size: 37 * scale,
                        ),
                      ),
                      SizedBox(height: 3 * scale),
                      Text(
                        'شكوى',
                        style: GoogleFonts.tajawal(
                          fontSize: 10 * scale,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // --- محتوى الشاشة ---
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 18 * scale,
              vertical: 16 * scale,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. عنوان الشكوى
                _buildSectionLabel('عنوان الشكوي', scale),
                SizedBox(height: 8 * scale),
                TextField(
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(fontSize: 13 * scale),
                  decoration: _buildInputDecoration(
                    'اكتب عنوان الشكوى........',
                    scale,
                  ),
                ),

                SizedBox(height: 16 * scale),

                // 2. وصف الشكوى
                _buildSectionLabel('وصف الشكوى', scale),
                SizedBox(height: 8 * scale),
                TextField(
                  maxLines: 4,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(fontSize: 13 * scale),
                  decoration: _buildInputDecoration(
                    'اكتب تفاصيل المشكلة هنا بشكل مفصل...............',
                    scale,
                  ),
                ),

                SizedBox(height: 16 * scale),

                // 3. تصنيف الشكوى
                _buildSectionLabel('تصنيف الشكوى', scale),
                SizedBox(height: 8 * scale),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale),
                  decoration: _buildBoxDecoration(),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'اختر التصنيف المناسب........',
                          style: GoogleFonts.tajawal(
                            color: Colors.grey.shade400,
                            fontSize: 13 * scale,
                          ),
                        ),
                      ),
                      value: _selectedCategory,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      items: _categories.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              cat,
                              style: GoogleFonts.tajawal(fontSize: 13 * scale),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => _selectedCategory = val),
                    ),
                  ),
                ),

                SizedBox(height: 12 * scale),

                // 4. اختيار الجهة الحكومية (جهة اليمين)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale),
                  decoration: _buildBoxDecoration(),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.account_balance_outlined,
                            color: Colors.black87,
                            size: 22,
                          ),
                          SizedBox(width: 8 * scale),
                          Text(
                            'اختيار الجهة الحكومية',
                            style: GoogleFonts.tajawal(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.5 * scale,
                            ),
                          ),
                        ],
                      ),
                      value: _selectedGovernment,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      items: _governments.map((gov) {
                        return DropdownMenuItem(
                          value: gov,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              gov,
                              style: GoogleFonts.tajawal(fontSize: 13 * scale),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => _selectedGovernment = val),
                    ),
                  ),
                ),

                SizedBox(height: 18 * scale),

                // 5. درجة الأولوية
                _buildSectionLabel('درجة الأولوية', scale),
                SizedBox(height: 8 * scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPriorityChip(
                      'منخفضة',
                      const Color(0xFF00B27A),
                      scale,
                    ),
                    _buildPriorityChip(
                      'متوسطة',
                      const Color(0xFFFFB800),
                      scale,
                    ),
                    _buildPriorityChip('عالية', const Color(0xFFFF4D4D), scale),
                  ],
                ),

                SizedBox(height: 18 * scale),

                // 6. الموقع
                _buildSectionLabel('الموقع', scale),
                SizedBox(height: 8 * scale),
                Container(
                  height: 65 * scale,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12 * scale),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12 * scale),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/map_bg.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: Colors.grey.shade200),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * scale),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color(0xFF0C655E),
                                    size: 28,
                                  ),
                                  SizedBox(width: 8 * scale),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15 * scale,
                                    child: const Icon(
                                      Icons.navigation,
                                      color: Color(0xFF0C655E),
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 18 * scale),

                // 7. المرفقات (زر إضافة صورة + عرض الصور المضافة من الأصول)
                _buildSectionLabel('المرفقات', scale),
                SizedBox(height: 10 * scale),
                SizedBox(
                  height: 75 * scale,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // زر إضافة صورة
                      Container(
                        width: 80 * scale,
                        height: 75 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(10 * scale),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 24 * scale,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 2 * scale),
                            Text(
                              'اضافة صورة',
                              style: GoogleFonts.tajawal(
                                fontSize: 10.5 * scale,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 8 * scale),

                      // عرض قائمة الصور من مجلد Assets
                      ..._complaintImages.map((imgPath) {
                        return Padding(
                          padding: EdgeInsets.only(left: 8 * scale),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10 * scale),
                            child: Image.asset(
                              imgPath,
                              width: 80 * scale,
                              height: 75 * scale,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 80 * scale,
                                    height: 75 * scale,
                                    color: Colors.grey.shade300,
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                SizedBox(height: 25 * scale),

                // 8. زر إرسال الشكوى
                SizedBox(
                  width: double.infinity,
                  height: 48 * scale,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C655E),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8 * scale),
                      ),
                    ),
                    child: Text(
                      'إرسال الشكوى',
                      style: GoogleFonts.tajawal(
                        fontSize: 17 * scale,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String title, double scale) {
    return Text(
      title,
      style: GoogleFonts.tajawal(
        fontSize: 14.5 * scale,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, double scale) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.tajawal(
        color: Colors.grey.shade400,
        fontSize: 12 * scale,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12 * scale,
        vertical: 10 * scale,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10 * scale),
        borderSide: const BorderSide(color: Color(0xFF707070)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10 * scale),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade400),
    );
  }

  Widget _buildPriorityChip(String title, Color color, double scale) {
    final bool isSelected = _selectedPriority == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedPriority = title),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14 * scale,
          vertical: 5 * scale,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(20 * scale),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 10 * scale,
              height: 10 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : color,
              ),
            ),
            SizedBox(width: 5 * scale),
            Text(
              title,
              style: GoogleFonts.tajawal(
                fontSize: 12.5 * scale,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
