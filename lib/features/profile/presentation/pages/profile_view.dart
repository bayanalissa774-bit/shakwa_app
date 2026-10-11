import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shakwa_app/features/home/presentation/pages/home_view.dart';
import 'package:shakwa_app/features/profile/presentation/pages/update_account_page.dart';
import 'package:shakwa_app/features/profile/presentation/widgets/profile_view/profile_header_widget.dart';
import 'package:shakwa_app/features/profile/presentation/widgets/profile_view/profile_info_card.dart';
import 'package:shakwa_app/features/profile/presentation/widgets/profile_view/profile_menu_item.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _profileImage;
  bool _isPersonalInfoExpanded = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;
    const Color primaryColor = Color(0xFF0C655E);
    const Color goldColor = Color(0xFFD4AF37);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 70 * scale,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                    (route) => false,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white, size: 20 * scale),
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
              Text(
                'حسابي',
                style: GoogleFonts.tajawal(
                  fontSize: 18 * scale,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateAccountPage(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'تعديل',
                      style: GoogleFonts.tajawal(
                        fontSize: 15 * scale,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4 * scale),
                    Icon(
                      Icons.edit_note_rounded,
                      color: Colors.white,
                      size: 22 * scale,
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
            children: [
              // استدعاء الهيدر الجديد للصورة والاسم
              ProfileHeaderWidget(
                profileImage: _profileImage,
                onPickImage: _pickImage,
                scale: scale,
                primaryColor: primaryColor,
                goldColor: goldColor,
              ),
              SizedBox(height: 30 * scale),

              // كرت المعلومات الشخصية
              ProfileInfoCard(
                isExpanded: _isPersonalInfoExpanded,
                onTap: () {
                  setState(() {
                    _isPersonalInfoExpanded = !_isPersonalInfoExpanded;
                  });
                },
                scale: scale,
                primaryColor: primaryColor,
              ),

              // كروت القائمة
              ProfileMenuItem(
                title: 'إحصائيات الشكاوي',
                icon: Icons.bar_chart_rounded,
                scale: scale,
                primaryColor: primaryColor,
                onTap: () {},
              ),
              ProfileMenuItem(
                title: 'تواصل معنا',
                icon: Icons.phone_in_talk_outlined,
                scale: scale,
                primaryColor: primaryColor,
                onTap: () {},
              ),
              ProfileMenuItem(
                title: 'الإعدادات',
                icon: Icons.settings_outlined,
                scale: scale,
                primaryColor: primaryColor,
                onTap: () {},
              ),

              SizedBox(height: 24 * scale),
              SizedBox(
                width: double.infinity,
                height: 52 * scale,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14 * scale),
                    ),
                  ),
                  child: Text(
                    'تسجيل خروج',
                    style: GoogleFonts.tajawal(
                      fontSize: 16 * scale,
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
    );
  }
}