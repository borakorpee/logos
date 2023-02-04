import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 75).r,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tercih Edilen Psikiyatri Doktorları",
                style: TextStyle(color: Colors.black, fontSize: 15.sp),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Herhangi bir psikolog kayıt etmediniz. Kendinize uygun bir psikolog seçip kaydederek psikoloğunuza dilediğiniz zaman kolay bir şekilde ulaşabilirsiniz.",
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
