// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- استيراد ملفات الـ Auth ---
import 'package:shakwa_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:shakwa_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shakwa_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:shakwa_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:shakwa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:shakwa_app/features/auth/presentation/pages/register_view.dart';
import 'package:shakwa_app/features/auth/presentation/pages/login_view.dart';

// --- استيراد باقي الشاشات والـ Cubits ---
import 'package:shakwa_app/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:shakwa_app/features/complaints/data/repositories/complaints_repository_impl.dart';
import 'package:shakwa_app/features/complaints/domain/usecases/add_complaint_usecase.dart';
import 'package:shakwa_app/features/complaints/domain/usecases/get_complaints_usecase.dart';
import 'package:shakwa_app/features/complaints/presentation/cubit/complaints_cubit.dart';
import 'package:shakwa_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:shakwa_app/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:shakwa_app/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:shakwa_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:shakwa_app/features/profile/presentation/pages/profile_view.dart';
import 'package:shakwa_app/features/home/presentation/pages/home_view.dart';

import 'features/splash/presentation/pages/splash_view.dart';
import 'features/splash/presentation/pages/splash_loading_view.dart';

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
        // 1. توفير الـ AuthCubit لشاشات الـ Auth (Login & Register)
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
            updateProfileUseCase: UpdateProfileUseCase(
              ProfileRepoImpl(
                remoteDataSource: ProfileRemoteDataSourceImpl(dio: Dio()),
              ),
            ),
          ),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            loginUseCase: LoginUseCase(
              AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(dio: Dio()),
              ),
            ),
            registerUseCase: RegisterUseCase(
              AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(dio: Dio()),
              ),
            ),
          ),
        ),

        // 2. توفير الـ ComplaintsCubit لشاشات الشكاوى
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
          '/': (context) => const SplashView(),
          '/splash-loading': (context) => const SplashLoadingView(),
          '/login': (context) => const LoginView(),
          '/signup': (context) => const RegisterView(),
          '/home': (context) => HomeView(),
        },
      ),
    );
  }
}
