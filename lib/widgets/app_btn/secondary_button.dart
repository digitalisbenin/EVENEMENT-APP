
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../responsive/size_config.dart';
import '../../../utils/constants/app_colors/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonTitle;

  const SecondaryButton({
    Key? key,
    required this.buttonTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return SizedBox(
      width: SizeConfigs.screenWidth! - 20,
      height: SizeConfigs.screenHeight! * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: kDeepPurpleColor, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(buttonTitle,
          style: GoogleFonts.workSans(color: kWhiteColor, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
    );
  }
}
