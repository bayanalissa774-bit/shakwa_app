// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shakwa_app/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:shakwa_app/features/complaints/data/repositories/complaints_repository_impl.dart';
import 'package:shakwa_app/features/complaints/domain/usecases/add_complaint_usecase.dart';
import 'package:shakwa_app/features/complaints/domain/usecases/get_complaints_usecase.dart';
import 'package:shakwa_app/features/complaints/presentation/cubit/complaints_cubit.dart';
import 'package:shakwa_app/features/complaints/presentation/cubit/complaints_state.dart';

import 'package:shakwa_app/features/complaints/presentation/pages/add_complaint_page.dart';
import 'package:shakwa_app/features/complaints/presentation/widgets/complaints_list/complaint_card.dart';
import 'package:shakwa_app/features/complaints/presentation/widgets/complaints_list/complaint_filter_chip.dart';
import 'package:shakwa_app/features/complaints/presentation/widgets/complaints_list/complaints_app_bar.dart';

// استيراد الـ Cubit والطبقات الخاصة بالـ API

class ComplaintsListPage extends StatefulWidget {
  const ComplaintsListPage({super.key});

  @override
  State<ComplaintsListPage> createState() => _ComplaintsListPageState();
}

class _ComplaintsListPageState extends State<ComplaintsListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedFilter = 'الكل';

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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => ComplaintsCubit(
          getComplaintsUseCase: GetComplaintsUseCase(
            ComplaintsRepositoryImpl(ComplaintsRemoteDataSourceImpl(Dio())),
          ),
          addComplaintUseCase: AddComplaintUseCase(
            ComplaintsRepositoryImpl(ComplaintsRemoteDataSourceImpl(Dio())),
          ),
        )..fetchComplaints(),
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          appBar: ComplaintsAppBar(scale: scale, primaryColor: primaryColor),
          body: Column(
            children: [
              // شريط الفلترة العلوي الذي صممتِيه تماماً
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
              // استعراض الشكاوى القادمة من السيرفر مع الحفاظ على الأنيميشن وتصميم البطاقات
              Expanded(
                child: BlocBuilder<ComplaintsCubit, ComplaintsState>(
                  builder: (context, state) {
                    if (state is ComplaintsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      );
                    } else if (state is ComplaintsLoaded) {
                      // تحويل بيانات الـ API إلى الشكل الذي تتوقعه البطاقات لدَيكِ
                      final complaints = state.complaints
                          .map(
                            (c) => {
                              'title': c.title,
                              'description': c.description,
                              'date': c.date,
                              'status': c.status,
                            },
                          )
                          .toList();

                      final filteredComplaints = _selectedFilter == 'الكل'
                          ? complaints
                          : complaints
                                .where((c) => c['status'] == _selectedFilter)
                                .toList();

                      if (filteredComplaints.isEmpty) {
                        return Center(
                          child: Text(
                            'لا توجد شكاوى مطابقة لهذا الفلتر',
                            style: TextStyle(
                              fontSize: 14 * scale,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.all(16 * scale),
                        itemCount: filteredComplaints.length,
                        itemBuilder: (context, index) {
                          final complaint = filteredComplaints[index];

                          return AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              final double delay = index * 0.15;
                              final double val =
                                  ((_animationController.value - delay) /
                                          (1.0 - delay))
                                      .clamp(0.0, 1.0);

                              return Transform.translate(
                                offset: Offset(0, 30 * (1 - val)),
                                child: Opacity(opacity: val, child: child),
                              );
                            },
                            child: ComplaintCard(
                              complaint: complaint,
                              scale: scale,
                            ),
                          );
                        },
                      );
                    } else if (state is ComplaintsError) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(20 * scale),
                          child: Text(
                            'خطأ في جلب البيانات: ${state.message}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14 * scale,
                            ),
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddComplaintPage(),
                ),
              );

              if (result == true) {
                context.read<ComplaintsCubit>().fetchComplaints();
              }
            },
            backgroundColor: primaryColor,
            elevation: 4,
            child: Icon(Icons.add, color: Colors.white, size: 28 * scale),
          ),
        ),
      ),
    );
  }
}
