import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:logos/screens/profile/profile_page.dart';
import 'package:provider/provider.dart';

import '../../providers/client_provider.dart';

class EditProfile extends StatelessWidget {
  static const routeName = "/edit_profile";
  const EditProfile({super.key});
// isim soyisim il ilçe email meslek
  @override
  Widget build(BuildContext context) {
    TextEditingController? nameController = TextEditingController();
    TextEditingController? surnameController = TextEditingController();
    TextEditingController? ilController = TextEditingController();
    TextEditingController? ilceController = TextEditingController();
    TextEditingController? mailController = TextEditingController();
    TextEditingController? meslekController = TextEditingController();
    TextEditingController? sifreController = TextEditingController();

    final client = Provider.of<ClientProvider>(context).get_client.client!;
    final update = Provider.of<ClientProvider>(context);

    return Scaffold(
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: 926.h,
          child: Padding(
            padding: const EdgeInsets.only(left: 27, right: 27, top: 75).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppbar(
                  appBarTitle: 'Profilim',
                ),
                SizedBox(height: 35.h),
                EditProfileFormField(
                  formFieldTitle: 'İsim',
                  clientHint: client.name!,
                  formController: nameController,
                ),
                EditProfileFormField(
                  formFieldTitle: 'Soyisim',
                  clientHint: client.surName!,
                  formController: surnameController,
                ),
                EditProfileFormField(
                  formFieldTitle: 'İl',
                  clientHint: client.city!,
                  formController: ilController,
                ),
                EditProfileFormField(
                  formFieldTitle: 'İlçe',
                  clientHint: client.county!,
                  formController: ilceController,
                ),
                EditProfileFormField(
                  formFieldTitle: 'E-mail',
                  clientHint: client.eMail!,
                  formController: mailController,
                ),
                EditProfileFormField(
                  formFieldTitle: 'Meslek',
                  clientHint: client.job!,
                  formController: meslekController,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 3).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Şifre",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.75),
                              fontWeight: FontWeight.w300,
                              fontSize: 13.sp,
                            ),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                              color: const Color(0xffF0735A),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 325.w,
                        height: 46.h,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.25)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          obscureText: true,
                          controller: sifreController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black.withOpacity(0.25)),
                            hintText: "*************",
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.only(left: 20, bottom: 13).r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 65,
                    left: 10,
                  ).r,
                  child: GestureDetector(
                    onTap: () {
                      update.updateClient(
                        name: nameController.text,
                        surname: surnameController.text,
                        il: ilController.text,
                        ilce: ilceController.text,
                        email: mailController.text,
                        meslek: meslekController.text,
                        password: sifreController.text,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 350.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff6B337F),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Text(
                        "Değişiklikleri Kaydet",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditProfileFormField extends StatelessWidget {
  const EditProfileFormField({
    Key? key,
    required this.formController,
    required this.clientHint,
    required this.formFieldTitle,
  }) : super(key: key);

  final TextEditingController? formController;
  final String clientHint;
  final String formFieldTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                formFieldTitle,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.75),
                  fontWeight: FontWeight.w300,
                  fontSize: 13.sp,
                ),
              ),
              Text(
                " *",
                style: TextStyle(
                  color: const Color(0xffF0735A),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          Container(
            width: 325.w,
            height: 46.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.25)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: formController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 14.sp, color: Colors.black.withOpacity(0.25)),
                hintText: clientHint,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 20, bottom: 13).r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
