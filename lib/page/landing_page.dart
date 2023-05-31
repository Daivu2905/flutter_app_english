import 'package:flutter/material.dart';
import 'package:flutter_app_new_demo/page/home_page.dart';
import 'package:flutter_app_new_demo/values/app_assets.dart';
import 'package:flutter_app_new_demo/values/app_colors.dart';
import 'package:flutter_app_new_demo/values/app_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcom to',
                  style: AppStyles.h3,
                ),
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'English',
                    style: AppStyles.h2.copyWith(
                        color: AppColors.blackGrey,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text('QQQQQ',
                        textAlign: TextAlign.right,
                        style: AppStyles.h5.copyWith(height: 0.5)),
                  ),
                ],
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 75),
                child: RawMaterialButton(
                    shape: const CircleBorder(),
                    fillColor: AppColors.lighBlue,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false);
                    },
                    child: Image.asset(AppAssets.rightArrow)),
              ))
            ],
          ),
        ));
  }
}
