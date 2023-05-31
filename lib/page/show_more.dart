import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new_demo/models/English_today.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class AllwordsPagee extends StatelessWidget {
  final List<EnglishToday> words;
  const AllwordsPagee({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.seCondColor,
      appBar: AppBar(
        backgroundColor: AppColors.seCondColor,
        elevation: 0,
        title: Text(
          'English today',
          style: AppStyles.h4.copyWith(
            color: AppColors.textColor,
            fontSize: 36,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: (index % 2) == 0
                    ? AppColors.primaryColor
                    : AppColors.seCondColor,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                words[index].noun!,
                style: (index % 2) == 0
                    ? AppStyles.h4
                    : AppStyles.h4.copyWith(color: AppColors.textColor),
              ),
              subtitle: Text(words[index].quote ??
                  'Think of all the beauty still left around you and be happy'),
              leading: Icon(
                Icons.favorite,
                color: words[index].isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
