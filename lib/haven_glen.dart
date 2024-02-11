import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:haven_glen/features/authentications/user_auth/auth_check.dart';
import 'package:haven_glen/utils/helpers/general_binding.dart';
import 'package:haven_glen/utils/theme/theme.dart';
import 'package:month_year_picker/month_year_picker.dart';

class HavenGlen extends StatelessWidget {
  const HavenGlen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haven Glen',
      themeMode: ThemeMode.system,
      theme: ZAppTheme.lightTheme,
      darkTheme: ZAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: const AuthCheck(),
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}
