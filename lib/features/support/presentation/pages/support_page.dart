import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/support/presentation/widgets/support_app_bar.dart';
import 'package:shakwa_app/features/support/presentation/widgets/support_expandable_card.dart';
import 'package:shakwa_app/features/support/presentation/widgets/support_action_card.dart';
import 'package:shakwa_app/features/support/presentation/widgets/support_contact_dialog.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  void _showContactDialog(BuildContext context, double scale) {
    showDialog(
      context: context,
      builder: (context) => SupportContactDialog(scale: scale),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: SupportAppBar(scale: scale),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Column(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'كيف يمكننا مساعدتك ؟',
                        style: GoogleFonts.tajawal(
                          fontSize: 22 * scale,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                      SizedBox(height: 6 * scale),
                      Text(
                        'اختر الخيار الذي يناسبك',
                        style: GoogleFonts.tajawal(
                          fontSize: 14 * scale,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24 * scale),
            SupportExpandableCard(
              title: 'الأسئلة الشائعة',
              content: 'هنا يتم عرض كافة الإجابات الخاصة بالأسئلة المتكررة لخدمة المواطنين وتسهيل إنجاز المعاملات الحكومية.',
              icon: Icons.help_outline_rounded,
              scale: scale,
            ),
            SupportActionCard(
              title: 'إنشاء طلب دعم',
              icon: Icons.description_outlined,
              onTap: () {},
              scale: scale,
            ),
            SupportActionCard(
              title: 'تواصل معنا',
              icon: Icons.phone_in_talk_rounded,
              onTap: () => _showContactDialog(context, scale),
              scale: scale,
            ),
            SupportExpandableCard(
              title: 'كيفية حجز موعد في الدائرة الحكومية',
              content: 'يمكنك حجز موعد بكل سهولة عبر اختيار الدائرة الحكومية المطلوبة وتحديد الوقت المناسب من خلال النظام الإلكتروني.',
              icon: Icons.calendar_today_rounded,
              scale: scale,
            ),
          ],
        ),
      ),
    );
  }
}
