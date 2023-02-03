import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/client_provider.dart';

Future<dynamic> CustomBottomSheet(BuildContext context) {
  final clientData =
      Provider.of<ClientProvider>(context, listen: false).get_client.client!;
  final client = Provider.of<ClientProvider>(context, listen: false);

  TextEditingController nameController =
      TextEditingController(text: clientData.name);
  TextEditingController surnameController =
      TextEditingController(text: clientData.surName);
  TextEditingController emailController =
      TextEditingController(text: clientData.eMail);
  TextEditingController passwordController = TextEditingController();
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
            width: double.infinity,
            height: 700.h,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 28,
                right: 20,
                top: 55,
              ).r,
              child: ListView(
                children: [
                  Column(
                    children: [
                      Text(
                        "Profil Düzenle",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                      Text(
                        "Sadece güncellemek istediğiniz ögeye tıklayınız",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 162.w,
                                height: 110.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/home/profile_picture.png"),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "Fotoğrafı Güncelle",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40).r,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "İsim",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 133.w,
                                  height: 30.h,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                    ).r,
                                    child: TextFormField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                          color:
                                              Colors.black.withOpacity(0.25)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Soyisim",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 133.w,
                                  height: 30.h,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                    ).r,
                                    child: TextFormField(
                                      controller: surnameController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                          color:
                                              Colors.black.withOpacity(0.25)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 21.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 36, right: 40).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "E-posta",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 320.w,
                              height: 30.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16).r,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.25)),
                                ),
                              ),
                            ),
                            SizedBox(height: 28.h),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Parola Sıfırlama",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Yeni Parola",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 320.w,
                              height: 30.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16).r,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "●●●●●●●●●●●●●●●",
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.25)),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.25)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Yeni Parola Tekrar Giriniz",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 320.w,
                              height: 30.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16).r,
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "●●●●●●●●●●●●●●●",
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.25)),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.25)),
                                ),
                              ),
                            ),
                            SizedBox(height: 46.h),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: Container(
                                    width: 54.w,
                                    height: 54.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffF7F7F7),
                                    ),
                                    child: Icon(
                                      Icons.chevron_left,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 23.h),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (() {
                                      client.updateClient(
                                        email: emailController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                        surname: surnameController.text,
                                      );

                                      Navigator.pop(context, "true");
                                    }),
                                    child: Container(
                                      height: 54.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff6B337F),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Güncelle",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
