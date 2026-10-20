import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// استدعاء ملفات الـ Clean Architecture الخاصة بكِ
import '../../data/datasources/track_remote_data_source.dart';
import '../../data/repositories/track_repository_impl.dart';
import '../../domain/usecases/track_complaint_usecase.dart';
import '../cubit/track_cubit.dart';
import '../cubit/track_state.dart';
import '../widgets/complaint_error_card.dart';
import '../widgets/complaint_success_card.dart';

// 1. الكلاس الرئيسي: وظيفته تزويد الصفحة بالـ Cubit
class TrackComplaintPage extends StatelessWidget {
  const TrackComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dio = Dio();
        final dataSource = TrackRemoteDataSourceImpl(dio);
        final repository = TrackRepositoryImpl(dataSource);
        final useCase = TrackComplaintUseCase(repository);
        return TrackCubit(trackComplaintUseCase: useCase);
      },
      child: const TrackComplaintView(),
    );
  }
}

// 2. كلاس الواجهة والتصميم
class TrackComplaintView extends StatefulWidget {
  const TrackComplaintView({super.key});

  @override
  State<TrackComplaintView> createState() => _TrackComplaintViewState();
}

class _TrackComplaintViewState extends State<TrackComplaintView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

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

    // استدعاء الـ Cubit للبحث عبر الـ API
    context.read<TrackCubit>().trackComplaint(query);
    _animController.reset();
    _animController.forward();
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 44 * scale,
                  width: 80 * scale,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.shield,
                    color: goldColor,
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
              onTap: () => Navigator.pop(context),
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
            // حقل البحث
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

            // زر البحث الموصول بالـ Cubit
            BlocBuilder<TrackCubit, TrackState>(
              builder: (context, state) {
                final isLoading = state is TrackLoading;
                return SizedBox(
                  width: double.infinity,
                  height: 52 * scale,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _performSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      disabledBackgroundColor:
                          primaryColor.withValues(alpha: 0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
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
                );
              },
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

            // عرض نتيجة البحث من الـ Cubit
            BlocBuilder<TrackCubit, TrackState>(
              builder: (context, state) {
                if (state is TrackLoaded) {
                  return FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: ComplaintSuccessCard(complaint: state.complaint),
                    ),
                  );
                } else if (state is TrackError) {
                  return FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: const ComplaintErrorCard(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}