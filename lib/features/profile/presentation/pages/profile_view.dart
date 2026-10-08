// lib/features/profile/presentation/pages/profile_view.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

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
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 4 * scale),
                    Text(
                      'رجوع',
                      style: GoogleFonts.tajawal(
                        fontSize: 15 * scale,
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
                onTap: () {},
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
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    padding: EdgeInsets.all(4 * scale),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: goldColor.withValues(alpha: 0.6),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50 * scale,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? Icon(
                              Icons.person,
                              size: 60 * scale,
                              color: Colors.grey.shade400,
                            )
                          : null,
                    ),
                  ),
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      padding: EdgeInsets.all(8 * scale),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18 * scale,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16 * scale),
              Text(
                "Bayan Alissa",
                style: GoogleFonts.tajawal(
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              SizedBox(height: 30 * scale),

              // كرت المعلومات الشخصية (المنسدل) - الأيقونة يمين، السهم يسار
              Container(
                margin: EdgeInsets.only(bottom: 14 * scale),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isPersonalInfoExpanded = !_isPersonalInfoExpanded;
                        });
                      },
                      borderRadius: BorderRadius.circular(16 * scale),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16 * scale,
                          vertical: 14 * scale,
                        ),
                        child: Row(
                          children: [
                            // 1. الأيقونة الملونة في أقصى اليمين
                            Container(
                              padding: EdgeInsets.all(8 * scale),
                              decoration: BoxDecoration(
                                color: primaryColor.withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person_outline_rounded,
                                color: primaryColor,
                                size: 20 * scale,
                              ),
                            ),
                            SizedBox(width: 12 * scale),
                            // 2. العنوان بجانب الأيقونة
                            Expanded(
                              child: Text(
                                'المعلومات الشخصية',
                                style: GoogleFonts.tajawal(
                                  fontSize: 15 * scale,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // 3. السهم في أقصى اليسار
                            Icon(
                              _isPersonalInfoExpanded
                                  ? Icons.keyboard_arrow_down_rounded
                                  : Icons.arrow_back_ios_rounded,
                              color: Colors.grey.shade400,
                              size: 18 * scale,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isPersonalInfoExpanded)
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          16 * scale,
                          0,
                          16 * scale,
                          16 * scale,
                        ),
                        child: Column(
                          children: [
                            _buildInfoRow('رقم الهاتف:', '0933232322', scale),
                            _buildInfoRow(
                              'البريد الإلكتروني:',
                              'bayan.alissa111@gmail.com',
                              scale,
                            ),
                            _buildInfoRow('العنوان:', 'حلب المرديان', scale),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // بقية الكروت العادية - الأيقونة يمين والسهم يسار حصراً
              _buildSimpleItem(
                'إحصائيات الشكاوي',
                Icons.bar_chart_rounded,
                scale,
                primaryColor,
                () {},
              ),
              _buildSimpleItem(
                'تواصل معنا',
                Icons.phone_in_talk_outlined,
                scale,
                primaryColor,
                () {},
              ),
              _buildSimpleItem(
                'الإعدادات',
                Icons.settings_outlined,
                scale,
                primaryColor,
                () {},
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

  Widget _buildSimpleItem(
    String title,
    IconData icon,
    double scale,
    Color primaryColor,
    VoidCallback onTap,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 14 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16 * scale),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * scale,
            vertical: 14 * scale,
          ),
          child: Row(
            children: [
              // الأيقونة الملونة في أقصى اليمين
              Container(
                padding: EdgeInsets.all(8 * scale),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: primaryColor, size: 20 * scale),
              ),
              SizedBox(width: 12 * scale),
              // العنوان بجانب الأيقونة
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // السهم في أقصى اليسار
              Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.grey.shade400,
                size: 16 * scale,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, double scale) {
    return Padding(
      padding: EdgeInsets.only(top: 8 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value,
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(width: 8 * scale),
          Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
