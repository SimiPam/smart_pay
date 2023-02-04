import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_pay/shared/utils/assets.dart';
import 'package:smart_pay/shared/widgets/custom_button.dart';
import 'package:smart_pay/shared/widgets/space.dart';

import '../utils/color.dart';
import '../utils/styles.dart';

//call this method to show a modal (success/failed)
showCustomModal(
    {required BuildContext ctx,
    String? headerText,
    required bool isSuccess,
    required String message,
    required String buttonText,
    String? buttonTextTwo,
    required VoidCallback callback}) {
  showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      builder: (ctx) => ActionBottomSheet(children: [
            HSpace(50.h),
            HSpace(30.h),
            !isSuccess
                ? Center(
                    child: SizedBox(
                      height: 150.h,
                      child: Lottie.asset(LottieAssets.warning),
                    ),
                  )
                : Center(
                    child: SizedBox(
                      height: 150.h,
                      child: Lottie.asset(LottieAssets.success),
                    ),
                  ),
            HSpace(24.h),
            Center(
              child: Styles.bold(headerText ?? 'Success!',
                  color: !isSuccess
                      ? AppColors.warningColor
                      : AppColors.primaryColor,
                  fontSize: 27.sp,
                  align: TextAlign.center),
            ),
            HSpace(16.h),
            Center(
              child: Styles.regular(message,
                  fontSize: 17.sp,
                  align: TextAlign.center,
                  color: AppColors.black),
            ),
            HSpace(50.h),
            HSpace(20.h),
            CustomButton(
                margin: 0.w,
                title: buttonText,
                isActive: true,
                txtColor: AppColors.white,
                txtSize: 17.sp,
                fontWeight: FontWeight.normal,
                onPress: callback),
            HSpace(20.h),
            !isSuccess
                ? CustomButton(
                    margin: 0.w,
                    btnColor: Colors.transparent,
                    title: buttonTextTwo!,
                    isActive: true,
                    txtColor: AppColors.primaryColor,
                    txtSize: 17.sp,
                    fontWeight: FontWeight.normal,
                    onPress: callback)
                : const SizedBox.shrink(),
            !isSuccess ? HSpace(20.h) : const SizedBox.shrink()
          ]));
}

//modal widget structure
class ActionBottomSheet extends StatelessWidget {
  const ActionBottomSheet(
      {Key? key,
      this.title,
      this.description,
      this.descriptionAction,
      this.warning,
      this.action1,
      this.action2,
      this.onTapAction1,
      this.onTapAction2,
      this.widget,
      this.children})
      : super(key: key);
  final String? title;
  final String? description;
  final String? descriptionAction;
  final String? warning;
  final String? action1;
  final String? action2;
  final Function()? onTapAction1;
  final Function()? onTapAction2;
  final Widget? widget;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children!),
      ),
      onClosing: () => Navigator.pop(context),
    );
  }
}

//call this method to show a bottom modal to display content
// class ContentModal {
//   static modal(
//       {required BuildContext ctx,
//       required List<Widget> children,
//       BuildContext? context}) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       elevation: 5,
//       context: ctx,
//       isDismissible: false,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
//       ),
//       builder: (ctx) => BottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r)),
//         ),
//         builder: (context) => Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 20.w),
//           child: CountryListPick(
//             theme: CountryTheme(
//               isShowFlag: true,
//               isShowTitle: true,
//               isShowCode: true,
//               isDownIcon: true,
//               showEnglishName: true,
//               labelColor: Colors.blueAccent,
//             ),
//             // to show or hide flag
//             // isShowFlag: true,
//             // // true to show  title country
//             // isShowTitle: true,
//             // // true to show code phone country
//             // isShowCode: true,
//             // // to show or hide down icon
//             // isDownIcon: true,
//             // to initial code number countrey
//             initialSelection: '+62',
//             // to get feedback data from picker
//             onChanged: (CountryCode code) {
//               // name of country
//               print(code.name);
//               // code of country
//               print(code.code);
//               // code phone of country
//               print(code.dialCode);
//               // path flag of country
//               print(code.flagUri);
//             },
//           ),
//         ),
//         onClosing: () => Navigator.pop(context!),
//       ),
//     );
//   }
// }

//modal widget structure
// class ActionBottomSheet extends StatelessWidget {
//   const ActionBottomSheet(
//       {Key? key,
//         this.title,
//         this.description,
//         this.descriptionAction,
//         this.warning,
//         this.action1,
//         this.action2,
//         this.onTapAction1,
//         this.onTapAction2,
//         this.widget,
//         this.children})
//       : super(key: key);
//   final String? title;
//   final String? description;
//   final String? descriptionAction;
//   final String? warning;
//   final String? action1;
//   final String? action2;
//   final Function()? onTapAction1;
//   final Function()? onTapAction2;
//   final Widget? widget;
//   final List<Widget>? children;
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomSheet(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r)),
//       ),
//       builder: (context) => Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 20.w),
//         child: Column(
//             mainAxisSize: MainAxisSize.min,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: children!),
//       ),
//       onClosing: () => Navigator.pop(context),
//     );
//   }
// }
