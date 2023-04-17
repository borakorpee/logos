import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/providers/all_psyc_provider.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:logos/screens/forgot_pass/forgotpassScreenView.dart';
import 'package:logos/screens/forgot_pass/newpassScreenView.dart';
import 'package:logos/screens/forgot_pass/otpScreenView.dart';
import 'package:logos/screens/forgot_pass/successScreenView.dart';
import 'package:logos/screens/home/favorites_page.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:logos/screens/login/loginScreenView.dart';
import 'package:logos/screens/onboard/onboardScreenView.dart';
import 'package:logos/screens/profile/edit_profile_page.dart';
import 'package:logos/screens/profile/profile_page.dart';
import 'package:logos/screens/psyc_profile/all_pyscs.dart';
import 'package:logos/screens/psyc_profile/psycs_profileScreenView.dart';
import 'package:logos/screens/psyc_profile/vide_call.dart';
import 'package:logos/screens/register/kvkkScreenView.dart';
import 'package:logos/screens/register/registerScreen2View.dart';
import 'package:logos/screens/register/registerScreenView.dart';
import 'package:logos/screens/register/registerSuccessScreenView.dart';
import 'package:logos/screens/reservation/calendar.dart';
import 'package:logos/screens/reservation/checkout.dart';
import 'package:logos/screens/reservation/my_reservation.dart';
import 'package:provider/provider.dart';
import 'screens/register/registerScreen3View.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  initializeDateFormatting().then((_) => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => ClientProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => All_Psychologists_Provider(),
        ),
      ], child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ((context, child) {
        return MaterialApp(
          theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
          debugShowCheckedModeBanner: false,
          home: const OnboardScreenView(),
          routes: {
            ProfilePage.routeName: (ctx) => const ProfilePage(),
            EditProfile.routeName: (ctx) => const EditProfile(),
            LoginScreenView.routeName: (ctx) => const LoginScreenView(),
            ForgotPassScreenView.routeName: (ctx) =>
                const ForgotPassScreenView(),
            OtpScreenView.routeName: (ctx) => const OtpScreenView(),
            NewPassScreen.routeName: (ctx) => const NewPassScreen(),
            SuccessScreenView.routeName: (ctx) => const SuccessScreenView(),
            RegisterScreenView.routeName: (ctx) => const RegisterScreenView(),
            RegisterScreen2.routeName: (ctx) => const RegisterScreen2(),
            RegisterScreen3.routeName: (ctx) => const RegisterScreen3(),
            RegisterSuccess.routeName: (ctx) => const RegisterSuccess(),
            KvkkScreen.routeName: (ctx) => const KvkkScreen(),
            PsycsScreenView.routeName: (ctx) => const PsycsScreenView(),
            VideCall.routeName: (ctx) => const VideCall(),
            ReservationCalendar.routeName: (ctx) => const ReservationCalendar(),
            NewHomePage.routeName: (ctx) => const NewHomePage(),
            FavoritesPage.routeName: (ctx) => const FavoritesPage(),
            PsycSearchScreen.routeName: (ctx) => const PsycSearchScreen(),
            CheckoutScreen.routeName: (ctx) => const CheckoutScreen(),
            MyReservationsPage.routeName: (ctx) => const MyReservationsPage(),
          },
        );
      }),
    );
  }
}
