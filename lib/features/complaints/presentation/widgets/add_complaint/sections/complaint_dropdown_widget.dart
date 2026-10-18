import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; // استيراد البكج الجاهزة

class ComplaintDropdownWidget extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double scale;

  const ComplaintDropdownWidget({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // تحديد درجات ألوان متناسقة وفخمة
    final primaryColor = Colors.deepPurple.shade600;
    final borderColor = Colors.deepPurple.shade200;
    final backgroundColor = Colors.grey.shade50;

    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            hint,
            style: GoogleFonts.tajawal(
              color: Colors.grey.shade500,
              fontSize: 13 * scale,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  item,
                  style: GoogleFonts.tajawal(
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,

          // 1️⃣ تخصيص الحاوية الأساسية (الزر الخارجي) - أخذ 90% من عرض الشاشة
          buttonStyleData: ButtonStyleData(
            width: screenWidth * 0.9,
            height: 54 * scale,
            padding: EdgeInsets.symmetric(horizontal: 14 * scale),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: borderColor, width: 1.5),
            ),
          ),

          // تخصيص الأيقونة وشكلها
          iconStyleData: IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: primaryColor),
            iconSize: 24 * scale,
          ),

          // 2️⃣ تخصيص قائمة العناصر عند الفتح - تأخذ 50% فقط من عرض الشاشة مع تأثيرات بصرية
          dropdownStyleData: DropdownStyleData(
            width:
                screenWidth * 0.5, // إجبار القائمة المنسدلة على أخذ نصف الشاشة
            direction: DropdownDirection.left,
            maxHeight: 250 * scale,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(
                color: primaryColor.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(
                    0,
                    5,
                  ), // إعطاء عمق وتأثير احترافي خلف القائمة
                ),
              ],
            ),
            elevation:
                0, // إلغاء الظل الافتراضي المزعج واستبداله بـ BoxShadow مخصص
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all(5),
              thumbColor: WidgetStateProperty.all(
                primaryColor.withOpacity(0.3),
              ),
            ),
          ),

          // تخصيص المسافات وتأثيرات العناصر الداخلية
          menuItemStyleData: MenuItemStyleData(
            height: 45 * scale,
            padding: EdgeInsets.symmetric(horizontal: 14 * scale),
          ),
        ),
      ),
    );
  }
}
