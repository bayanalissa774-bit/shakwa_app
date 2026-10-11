// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:shakwa_app/features/complaints/presentation/pages/add_complaint_page.dart';
import 'package:shakwa_app/features/complaints/presentation/widgets/complaints_list/complaint_card.dart';
import 'package:shakwa_app/features/complaints/presentation/widgets/complaints_list/complaint_filter_chip.dart';
import 'package:shakwa_app/features/complaints/presentation/widgets/complaints_list/complaints_app_bar.dart';

class ComplaintsListPage extends StatefulWidget {
  const ComplaintsListPage({super.key});

  @override
  State<ComplaintsListPage> createState() => _ComplaintsListPageState();
}

class _ComplaintsListPageState extends State<ComplaintsListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedFilter = 'الكل';

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
    const Color primaryColor = Color(0xFF0C655E);

    final filteredComplaints = _selectedFilter == 'الكل'
        ? _complaints
        : _complaints.where((c) => c['status'] == _selectedFilter).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: ComplaintsAppBar(scale: scale, primaryColor: primaryColor),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                16 * scale,
                14 * scale,
                16 * scale,
                16 * scale,
              ),
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    ComplaintFilterChip(
                      label: 'الكل',
                      isSelected: _selectedFilter == 'الكل',
                      onTap: () => setState(() => _selectedFilter = 'الكل'),
                      scale: scale,
                      primaryColor: primaryColor,
                    ),
                    SizedBox(width: 8 * scale),
                    ComplaintFilterChip(
                      label: 'قيد المعالجة',
                      isSelected: _selectedFilter == 'قيد المعالجة',
                      onTap: () =>
                          setState(() => _selectedFilter = 'قيد المعالجة'),
                      scale: scale,
                      primaryColor: primaryColor,
                    ),
                    SizedBox(width: 8 * scale),
                    ComplaintFilterChip(
                      label: 'قيد التنفيذ',
                      isSelected: _selectedFilter == 'قيد التنفيذ',
                      onTap: () =>
                          setState(() => _selectedFilter = 'قيد التنفيذ'),
                      scale: scale,
                      primaryColor: primaryColor,
                    ),
                    SizedBox(width: 8 * scale),
                    ComplaintFilterChip(
                      label: 'مرفوضة',
                      isSelected: _selectedFilter == 'مرفوضة',
                      onTap: () => setState(() => _selectedFilter = 'مرفوضة'),
                      scale: scale,
                      primaryColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
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
                    child: ComplaintCard(complaint: complaint, scale: scale),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddComplaintPage()),
            );
          },
          backgroundColor: primaryColor,
          elevation: 4,
          child: Icon(Icons.add, color: Colors.white, size: 28 * scale),
        ),
      ),
    );
  }
}
