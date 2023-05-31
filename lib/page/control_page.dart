// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new_demo/values/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/app_assets.dart';
import '../values/app_styles.dart';
import '../values/share_keys.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late SharedPreferences prefs;
  @override
  void initState() {
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.counter) ?? 5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.seCondColor,
      appBar: AppBar(
        backgroundColor: AppColors.seCondColor,
        elevation: 0,
        title: Text(
          'Your control',
          style: AppStyles.h4.copyWith(
            color: AppColors.textColor,
            fontSize: 36,
          ),
        ),
        leading: InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt(ShareKeys.counter, sliderValue.toInt());
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(children: [
          Spacer(),
          Text(
            'How much a number word at once',
            style:
                AppStyles.h4.copyWith(color: AppColors.lightgrey, fontSize: 18),
          ),
          Spacer(),
          Text(
            '${sliderValue.toInt()}',
            style: AppStyles.h1.copyWith(
                color: AppColors.primaryColor,
                fontSize: 150,
                fontWeight: FontWeight.bold),
          ),
          Slider(
              value: sliderValue,
              min: 5,
              max: 100,
              divisions: 100,
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.primaryColor,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              }),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            alignment: Alignment.centerLeft,
            child: Text(
              'slide to set',
              style: AppStyles.h5.copyWith(color: AppColors.textColor),
            ),
          ),
          Spacer(),
          Spacer(),
          Spacer(),
        ]),
      ),
    );
  }
}
