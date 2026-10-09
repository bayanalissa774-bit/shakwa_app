import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/home/presentation/pages/home_view.dart';

import '../../../../main.dart';
import '../widgets/complaint_success_card.dart'; // استدعاء كرت النجاح
import '../widgets/complaint_error_card.dart'; // استدعاء كرت الخطأ

class TrackComplaintPage extends StatefulWidget {
  const TrackComplaintPage({super.key});

  @override
  State<TrackComplaintPage> createState() => _TrackComplaintPageState();
}

class _TrackComplaintPageState extends State<TrackComplaintPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  int? _searchResultType; // null: لا شيء, 0: خطأ, 1: نجاح

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
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(
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

    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
      _searchResultType = null;
    });
    _animController.reset();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        if (query == '20240101501') {
          _searchResultType = 1; // نجاح
        } else {
          _searchResultType = 0; // خطأ
        }
      });
      _animController.forward();
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
                // العودة المباشرة للرئيسية ومسح الصفحات السابقة
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ), // استبدلي HomeView بالاسم الصحيح لدتيكِ
                  (route) => false,
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
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _performSearch(),
                onChanged: (value) => setState(() {}),
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
                  prefixIcon: InkWell(
                    onTap: _performSearch,
                    child: Padding(
                      padding: EdgeInsets.all(12 * scale),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey.shade400,
                        size: 22 * scale,
                      ),
                    ),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey.shade600,
                            size: 20 * scale,
                          ),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16 * scale,
                    vertical: 14 * scale,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16 * scale),
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

            // استدعاء الكروت المنفصلة مع الحركات الذكية
            if (_searchResultType != null)
              FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: _searchResultType == 0
                      ? const ComplaintErrorCard()
                      : const ComplaintSuccessCard(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
