import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../cubit/complaints_cubit.dart';
import '../../../cubit/complaints_state.dart';

class SubmitComplaintButton extends StatelessWidget {
  final double scale;
  final VoidCallback onSubmit;

  const SubmitComplaintButton({
    super.key,
    required this.scale,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0C655E);

    return BlocBuilder<ComplaintsCubit, ComplaintsState>(
      builder: (context, state) {
        final isLoading = state is ComplaintsLoading;
        return SizedBox(
          width: double.infinity,
          height: 48 * scale,
          child: ElevatedButton(
            onPressed: isLoading ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8 * scale),
              ),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    'إرسال الشكوى',
                    style: GoogleFonts.tajawal(
                      fontSize: 17 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
