import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color blueLinear1 = Color(0xff116CB7);
const Color blueLinear2 = Color(0xff27409C);

const Color neutralCaption = Color(0xff6D727F);
const Color neutral80 = Color(0xff333333);
const Color neutral60 = Color(0xff666666);
const Color neutral30 = Color(0xffB3B3B3);
const Color neutral20 = Color(0xffCCCCCC);
const Color neutral10 = Color(0xffE6E6E6);

const Color abu6 = Color(0xffC5C5C5);

const Color blue4 = Color(0xff248DDA);

LinearGradient splashGradient = const LinearGradient(
  colors: [blueLinear1, blueLinear2],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

InputDecoration styleWithSearchPrefix(String hint) {
  return InputDecoration(
    prefixIcon: Container(
      margin: EdgeInsets.only(left: 20.w, right: 12.w),
      child: Image.asset(
        'assets/search_active.png',
        width: 18.w,
        height: 15.w,
        color: abu6,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.r),
    ),
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 14.sp,
      color: neutral20,
      fontWeight: FontWeight.w400,
    ),
  );
}

InputDecoration styleBorderWithDropdown(String hint) {
  return InputDecoration(
    suffixIcon: Icon(
      Icons.arrow_drop_down,
      color: neutralCaption,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5.r),
    ),
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 14.sp,
      color: neutral20,
      fontWeight: FontWeight.w400,
    ),
  );
}

Widget btsNotFound(String text) {
  return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Image.asset(
            'assets/data_not_found.png',
            width: 198.w,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Ups, " + text,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Go check your keyword again or\ntry another keyword",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          )
        ],
      ));
}