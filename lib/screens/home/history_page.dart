import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 75).r,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Geçmiş Randevular",
                style: TextStyle(color: Colors.black, fontSize: 15.sp),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Herhangi bir randevu geçmişiniz bulunmamakta. Kendinize uygun bir psikolog seçerek randevu alabilirsiniz.",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp),
                    textAlign: TextAlign.center,
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
