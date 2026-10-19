// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa_app/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:shakwa_app/features/complaints/data/repositories/complaints_repository_impl.dart';
import 'package:shakwa_app/features/complaints/domain/usecases/add_complaint_usecase.dart';
import 'package:shakwa_app/features/complaints/domain/usecases/get_complaints_usecase.dart';
import 'package:shakwa_app/features/complaints/presentation/cubit/complaints_cubit.dart';
import 'package:shakwa_app/features/profile/presentation/pages/profile_view.dart';

import 'features/splash/presentation/pages/splash_view.dart';
import 'features/splash/presentation/pages/splash_loading_view.dart';
import 'features/auth/presentation/pages/login_view.dart';

import 'features/auth/presentation/pages/signup_view.dart';

import 'package:shakwa_app/features/home/presentation/pages/home_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ComplaintsCubit>(
          create: (context) => ComplaintsCubit(
            getComplaintsUseCase: GetComplaintsUseCase(
              ComplaintsRepositoryImpl(ComplaintsRemoteDataSourceImpl(Dio())),
            ),
            addComplaintUseCase: AddComplaintUseCase(
              ComplaintsRepositoryImpl(ComplaintsRemoteDataSourceImpl(Dio())),
            ),
          )..fetchComplaints(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shakwa App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.tajawal().fontFamily,
        ),

        // الشاشة الأولى التي سيبدأ منها التطبيق
        initialRoute: '/',

        // جدول المسارات والتنقلات
        routes: {
          '/': (context) => const SplashView(), // 1. الشاشة الأولى
          '/splash-loading': (context) =>
              const SplashLoadingView(), // 2. شاشة التحميل
          '/login': (context) => const LoginView(), // 3. شاشة تسجيل الدخول

          '/signup': (context) => const SignUpView(),
          '/home': (context) => HomeView(), // 4. شاشة الصفحة الرئيسية
        },
      ),
    );
  }
}
