// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget SuccesSnackbar(BuildContext context) {
  return Stack(
    children: [
      Container(
        width: 438.w,
        height: 132.h,
        decoration: BoxDecoration(
          color: const Color(0xff6B337F),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 30, bottom: 35).r,
          child: Row(
            children: [
              Image.asset("assets/snackbar/succes.png"),
              SizedBox(width: 30.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Başarılı!",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 28.h),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "İşlem başarılı bir şekilde gerçekleşti.",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 12.h),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      Positioned(
        top: 25.h,
        right: 25.w,
        child: GestureDetector(
          onTap: (() {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
          child: Image.asset(
            "assets/snackbar/Union.png",
          ),
        ),
      ),
    ],
  );
}

Widget AlertSnackbar(BuildContext context) {
  return Stack(
    children: [
      Container(
        width: 438.w,
        height: 132.h,
        decoration: BoxDecoration(
          color: const Color(0xff6B337F),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 60, top: 25, bottom: 27).r,
          child: Row(
            children: [
              Image.asset("assets/snackbar/alert.png"),
              SizedBox(width: 30.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Uyarı!",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 28.h),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 240.w,
                    child: Text(
                      "Sistem bir uyarı ile karşılaştı. Çözülmeye çalışılıyor.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12.h),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      Positioned(
        top: 25.h,
        right: 25.w,
        child: GestureDetector(
          onTap: (() {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
          child: Image.asset(
            "assets/snackbar/Union.png",
          ),
        ),
      ),
    ],
  );
}

Widget ErrorSnackbar(BuildContext context) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: 132.h,
        decoration: BoxDecoration(
          color: const Color(0xff6B337F),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 35, top: 25, bottom: 27).r,
          child: Row(
            children: [
              Image.asset("assets/snackbar/error.png"),
              SizedBox(width: 30.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hata!",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 28.sp),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 240.w,
                    child: Text(
                      "Girdiğiniz email veya şifre hatalı.\nLütfen kontrol ediniz.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12.sp),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      Positioned(
        top: 25.w,
        right: 25.w,
        child: GestureDetector(
          onTap: (() {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
          child: Image.asset(
            "assets/snackbar/Union.png",
          ),
        ),
      ),
    ],
  );
}

Widget QuestionSnackbar(BuildContext context) {
  return Stack(
    children: [
      Container(
        width: 438.w,
        height: 132.h,
        decoration: BoxDecoration(
          color: const Color(0xff6B337F),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 25, bottom: 27).r,
          child: Row(
            children: [
              Image.asset("assets/snackbar/question.png"),
              SizedBox(width: 15.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lorem Ipsum!",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 28.h),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 240.w,
                    child: Text(
                      "Yardıma mı ihtiyacın var?\nHemen bize ulaş.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12.h),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      Positioned(
        top: 25.h,
        right: 25.w,
        child: GestureDetector(
          onTap: (() {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
          child: Image.asset(
            "assets/snackbar/Union.png",
          ),
        ),
      ),
    ],
  );
}
