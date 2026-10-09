// lib/features/track_complaint/presentation/pages/track_complaint_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/home/presentation/pages/home_view.dart';

class TrackComplaintPage extends StatefulWidget {
  const TrackComplaintPage({super.key});

  // سنقوم بتعريف الحالة أدناه
  @override
  State<TrackComplaintPage> createState() => _TrackComplaintPageState();
}

class _TrackComplaintPageState extends State<TrackComplaintPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  int? _searchResultType; // null: لا شيء, 0: خطأ, 1: نجاح (تحت المعالجة)

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim =
        Tween<Offset>(
          begin: const Offset(0, 0.2), // تبدأ من الأسفل قليلاً
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    FocusScope.of(context).unfocus(); // إخفاء لوحة المفاتيح
    setState(() {
      _isLoading = true;
      _searchResultType = null;
    });
    _animController.reset();

    // محاكاة طلب بحث وهمي بـ 1.5 ثانية مع مؤشر تحميل ذهبي فخم
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        // إذا كان الرقم المدخل هو الرقم المحدد في الفيجما، نعرض كرت النجاح، وإلا كرت الخطأ
        if (query == '20240101501') {
          _searchResultType = 1; // نجاح (تحت المعالجة)
        } else {
          _searchResultType = 0; // خطأ (لم يتم العثور)
        }
      });
      _animController.forward(); // تشغيل حركة الظهور الناعمة
    });
  }

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;
    const Color primaryColor = Color(0xFF0C655E);
    const Color goldColor = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 70 * scale,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            Text(
              'متابعة شكاوي',
              style: GoogleFonts.tajawal(
                fontSize: 18 * scale,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                // نفترض أن اسم صفحة الرئيسية لديكِ HomePage أو HomeView
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ), // استبدلي HomeView باسم صفحتك الرئيسية إن أمكن
                  (route) => false, // يمسح كل الصفحات السابقة لكي لا يبقى تراكُم في الذاكرة
                );
              },
              child: Row(
                children: [
                  Text(
                    'رجوع',
                    style: GoogleFonts.tajawal(
                      fontSize: 15 * scale,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4 * scale),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 20 * scale,
          vertical: 24 * scale,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // حقل البحث مع أيقونة العدسة
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                style: GoogleFonts.tajawal(
                  fontSize: 14 * scale,
                  color: const Color(0xFF1E1E1E),
                ),
                decoration: InputDecoration(
                  hintText: 'ادخل رقم الشكوى',
                  hintStyle: GoogleFonts.tajawal(
                    fontSize: 13 * scale,
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12 * scale),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey.shade400,
                      size: 22 * scale,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16 * scale,
                    vertical: 14 * scale,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16 * scale),

            // زر البحث أو مؤشر التحميل الدائري الذهبي الفخم
            SizedBox(
              width: double.infinity,
              height: 52 * scale,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _performSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  disabledBackgroundColor: primaryColor.withValues(alpha: 0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 24 * scale,
                        height: 24 * scale,
                        child: const CircularProgressIndicator(
                          color: goldColor,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(
                        'بحث',
                        style: GoogleFonts.tajawal(
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 14 * scale),

            // النص التوضيحي المطابق للفيجما تماماً
            Text(
              'يمكن العثور على رقم الشكوى في الإيصال المستلم او في الرسالة النصية المرسلة إليك .',
              textAlign: TextAlign.right,
              style: GoogleFonts.tajawal(
                fontSize: 12.5 * scale,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
            SizedBox(height: 30 * scale),

            // منطقة ظهور كرت النتيجة بحركة Slide & Fade ناعمة
            if (_searchResultType != null)
              FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: _searchResultType == 0
                      ? _buildErrorCard(scale) // كرت الخطأ (الصورة الأولى)
                      : _buildSuccessCard(
                          scale,
                        ), // كرت النجاح تحت المعالجة (الصورة الثانية)
                ),
              ),
          ],
        ),
      ),
    );
  }

  // كرت الخطأ (عند عدم العثور على شكوى)
  Widget _buildErrorCard(double scale) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 40 * scale,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'لم يتم العثور على أي شكوى بهذا الرقم .',
            style: GoogleFonts.tajawal(
              fontSize: 16 * scale,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'الرجاء التأكد من رقم الشكوى والمحاولة مرة أخرى .',
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // كرت النجاح / تحت المعالجة (الصورة الثانية)
  Widget _buildSuccessCard(double scale) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12 * scale,
                vertical: 6 * scale,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFA000), // برتقالي حالة تحت المعالجة
                borderRadius: BorderRadius.circular(6 * scale),
              ),
              child: Text(
                'تحت المعالجة',
                style: GoogleFonts.tajawal(
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          _buildInfoRow('رقم الشكاوي :', '20240101501', scale),
          SizedBox(height: 10 * scale),
          _buildInfoRow('عنوان مختصر :', 'صيانة إنارة الطريق', scale),
          SizedBox(height: 10 * scale),
          _buildInfoRow(
            'اسم الجهة :',
            'بلدية حلب _ أمانة منطقة المرديان',
            scale,
          ),
          SizedBox(height: 10 * scale),
          _buildInfoRow('التصنيف :', 'صيانة طريق', scale),
          SizedBox(height: 10 * scale),
          _buildInfoRow('تاريخ التقدم :', '15 أكتوبر 2026', scale),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, double scale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: GoogleFonts.tajawal(
            fontSize: 13.5 * scale,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E1E1E),
          ),
        ),
        SizedBox(width: 8 * scale),
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 13.5 * scale,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ],
    );
  }
}
