// lib/features/complaints/presentation/pages/complaints_list_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/complaints/presentation/pages/add_complaint_view.dart';

class ComplaintsListPage extends StatefulWidget {
  const ComplaintsListPage({super.key});

  @override
  State<ComplaintsListPage> createState() => _ComplaintsListPageState();
}

class _ComplaintsListPageState extends State<ComplaintsListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // الفلتر المحدد حالياً لعرض الشكاوى
  String _selectedFilter = 'الكل';

  // قائمة الشكاوى مع الالتزام الحرفي بالنصوص والنقاط الواردة في التصميم
  final List<Map<String, String>> _complaints = [
    {
      'title': 'انقطاع متكرر في التيار الكهربائي',
      'description': 'انقطاع متكرر في الحي كل نصف ساعة بشكل يومي تقريبًا لمدة تتراوح بين 30 دقيقة إلى ساعة',
      'date': '22 مايو 2026',
      'status': 'قيد التنفيذ',
    },
    {
      'title': 'انقطاع متكرر في التيار الكهربائي',
      'description': 'انقطاع متكرر في الحي كل نصف ساعة بشكل يومي تقريبًا لمدة تتراوح بين 30 دقيقة إلى ساعة',
      'date': '22 مايو 2026',
      'status': 'مرفوضة',
    },
    {
      'title': 'انقطاع متكرر في التيار الكهربائي',
      'description': 'انقطاع متكرر في الحي كل نصف ساعة بشكل يومي تقريبًا لمدة تتراوح بين 30 دقيقة إلى ساعة',
      'date': '22 مايو 2026',
      'status': 'قيد المعالجة',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    const Color primaryColor = Color(0xFF0C655E); // الكحلي الداكن الرسمي للهوية
    const Color goldColor = Color(0xFFD4AF37); // الذهبي الفاخر

    // تصفية الشكاوى بناءً على الفلتر المختار
    final filteredComplaints = _selectedFilter == 'الكل'
        ? _complaints
        : _complaints.where((c) => c['status'] == _selectedFilter).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),

        // الـ AppBar النظيف والمخصص للعنوان والزر وشعار النسر
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75 * scale),
          child: AppBar(
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
                      "الشكاوى",
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
                          height: 44 * scale,
                          width: 80 * scale,
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
        ),

        body: Column(
          children: [
            // قسم البحث وأزرار الفلترة تحت الـ AppBar مباشرة
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                16 * scale,
                14 * scale,
                16 * scale,
                16 * scale,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  // صندوق البحث مع ضبط الحدود (Border) والظل بوضوح تام
                  Container(
                    height: 48 * scale,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12 * scale),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.2,
                      ), // حدود واضحة وبارزة
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      style: GoogleFonts.tajawal(fontSize: 14 * scale),
                      decoration: InputDecoration(
                        hintText: 'ابحث عن شكوى .....',
                        hintStyle: GoogleFonts.tajawal(
                          fontSize: 13 * scale,
                          color: Colors.grey.shade400,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade500,
                          size: 22 * scale,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12 * scale,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14 * scale),

                  // أزرار الفلترة الأفقية تحت البحث
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildFilterChip('الكل', scale, primaryColor),
                        SizedBox(width: 8 * scale),
                        _buildFilterChip('قيد المعالجة', scale, primaryColor),
                        SizedBox(width: 8 * scale),
                        _buildFilterChip('قيد التنفيذ', scale, primaryColor),
                        SizedBox(width: 8 * scale),
                        _buildFilterChip('مرفوضة', scale, primaryColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // قائمة الكروت مع حركة ظهور متسلسلة (Fade & Slide Animation)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16 * scale),
                itemCount: filteredComplaints.length,
                itemBuilder: (context, index) {
                  final complaint = filteredComplaints[index];

                  return AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final double delay = index * 0.15;
                      final double val =
                          ((_animationController.value - delay) / (1.0 - delay))
                              .clamp(0.0, 1.0);

                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - val)),
                        child: Opacity(opacity: val, child: child),
                      );
                    },
                    child: _buildComplaintCard(complaint, scale),
                  );
                },
              ),
            ),
          ],
        ),

        // زر الإضافة العائم (+) باللون الرسمي
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddComplaintView(), // استبدلي AddComplaintPage باسم صفحة تقديم شكوى جديدة لديكِ
              ),
            );
          },
          backgroundColor: primaryColor,
          elevation: 4,
          child: Icon(Icons.add, color: Colors.white, size: 28 * scale),
        ),
      ),
    );
  }

  // ودجت أزرار الفلترة بتصميم تفاعلي فاخر
  Widget _buildFilterChip(String label, double scale, Color primaryColor) {
    final bool isSelected = _selectedFilter == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      borderRadius: BorderRadius.circular(20 * scale),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 8 * scale,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20 * scale),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 13 * scale,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  // ودجت كرت الشكوى الواحد المطابق تماماً للفيجما
  Widget _buildComplaintCard(Map<String, String> complaint, double scale) {
    Color statusBgColor;

    // تلوين التاغات بدقة حسب الحالة المطلوبة
    if (complaint['status'] == 'مرفوضة') {
      statusBgColor = const Color(0xFFFF4D4D); // أحمر
    } else if (complaint['status'] == 'قيد التنفيذ') {
      statusBgColor = const Color(0xFF1E88E5); // أزرق
    } else {
      statusBgColor = const Color(0xFF00C853); // أخضر (قيد المعالجة)
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16 * scale),
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  complaint['title']!,
                  style: GoogleFonts.tajawal(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10 * scale,
                  vertical: 4 * scale,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                child: Text(
                  complaint['status']!,
                  style: GoogleFonts.tajawal(
                    fontSize: 11 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8 * scale),
          Text(
            complaint['description']!,
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          SizedBox(height: 12 * scale),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              complaint['date']!,
              style: GoogleFonts.tajawal(
                fontSize: 11 * scale,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
