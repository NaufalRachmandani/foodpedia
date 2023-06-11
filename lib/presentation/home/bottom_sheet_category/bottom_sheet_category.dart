import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodpedia/common/constant.dart';
import 'package:foodpedia/presentation/home/bloc/homepage/homepage_bloc.dart';
import 'package:foodpedia/presentation/home/bottom_sheet_category/bloc/bts_category_bloc.dart';

class BottomSheetCategory extends StatefulWidget {
  final BuildContext homepageContext;

  const BottomSheetCategory({Key? key, required this.homepageContext}) : super(key: key);

  @override
  State<BottomSheetCategory> createState() => _BottomSheetCategoryState();
}

class _BottomSheetCategoryState extends State<BottomSheetCategory> {
  TextEditingController textEditingController = TextEditingController();

  TextStyle textStyle = TextStyle(
    color: neutral30,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    letterSpacing: 0.5,
  );

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        ),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Container(
              width: 30.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: neutral20,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: content(textEditingController),
            ),
          ],
        ),
      ),
    );
  }

  Widget content(TextEditingController textEditingController) {
    return Column(
      children: [
        searchSection(textEditingController),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: BlocBuilder<BtsCategoryBloc, BtsCategoryState>(
            builder: (context, state) {
              if (state is BtsCategoryNotFoundState) {
                return btsNotFound("Food category not found");
              } else if (state is BtsCategoryLoadedState) {
                return buildList(state.filteredListCategory);
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: blue4,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget searchSection(TextEditingController textEditingController) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: neutral10, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: TextFormField(
        autofocus: true,
        style: textStyle.copyWith(color: neutral80),
        controller: textEditingController,
        decoration: styleWithSearchPrefix("Search Category"),
        onChanged: (value) {
          BlocProvider.of<BtsCategoryBloc>(context)
              .add(BtsSearchCategoryEvent(query: value));
        },
      ),
    );
  }

  Widget buildList(List<String> listCategory) {
    return ListView.builder(
      itemCount: listCategory.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<HomepageBloc>(widget.homepageContext)
                .add(UpdateCategoryEvent(category: listCategory[index]));
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              listCategory[index],
              style: textStyle.copyWith(color: neutral60),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
