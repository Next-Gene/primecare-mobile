import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/layout/cubit/cubit.dart';
import 'package:nexgen/layout/cubit/states.dart';
import 'package:nexgen/Component/card_category_screen.dart';

class Category_page extends StatefulWidget {
  const Category_page({super.key});

  @override
  State<Category_page> createState() => _Category_pageState();
}

class _Category_pageState extends State<Category_page> with SingleTickerProviderStateMixin {
  List<bool> _visibleList = [];

  @override
  void initState() {
    super.initState();

    // استدعاء تحميل البيانات عند بداية الشاشة
    AppCubit.get(context).getCategoryScreen();
  }

  void _playAnimation() async {
    for (int i = 0; i < _visibleList.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100)); // تأخير بين ظهور كل عنصر
      if (mounted) {
        setState(() {
          _visibleList[i] = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetCategorySuccessfully) {
          // بعد جلب البيانات نبدأ تفعيل ظهور العناصر تدريجيًا
          _visibleList = List.generate(AppCubit.get(context).category.length, (index) => false);
          _playAnimation();
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return SafeArea(
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE7F6FF),
                    Color(0xFF90D3FD),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      "Category",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // حالة اللودينج
                  if (state is GetCategoryLoading)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (state is GetCategoryError)
                    Expanded(
                      child: Center(
                        child: Text('Error: ${state.error}'),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.category.length,
                        itemBuilder: (context, index) {
                          final categoryItem = cubit.category[index];
                          return AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: _visibleList.length > index && _visibleList[index] ? 1 : 0,
                            child: AnimatedSlide(
                              duration: const Duration(milliseconds: 500),
                              offset: _visibleList.length > index && _visibleList[index] ? Offset.zero : const Offset(0, 0.3),
                              child: Build_Card_Category_Screen(
                                title: categoryItem["name"] ?? "No title",
                                imagePath: categoryItem["photoUrl"] ?? "",
                                description: categoryItem["description"] ?? "No description",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
