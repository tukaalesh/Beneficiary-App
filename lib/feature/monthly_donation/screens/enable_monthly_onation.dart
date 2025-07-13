import 'dart:ui';

import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/auth/widgets/auth_custom_text_field.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/gift/widget/button_out_line.dart';
import 'package:charity_app/feature/monthly_donation/cubit/cancle_monthly_donation.dart';
import 'package:charity_app/feature/monthly_donation/cubit/cancle_monthly_states.dart';
import 'package:charity_app/feature/monthly_donation/cubit/monthly_donation_cubit.dart';
import 'package:charity_app/feature/monthly_donation/cubit/monthly_donation_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EnableMonthlyDonation extends StatefulWidget {
  const EnableMonthlyDonation({super.key});

  @override
  State<EnableMonthlyDonation> createState() => _EnableMonthlyOnationState();
}

class _EnableMonthlyOnationState extends State<EnableMonthlyDonation> {
  final TextEditingController moneyController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? selectedCategory;
  bool categoryError = false;

  final List<Map<String, dynamic>> categories = [
    {'label': 'غذائي', 'icon': Icons.fastfood},
    {'label': 'سكني', 'icon': Icons.home},
    {'label': 'صحي', 'icon': Icons.local_hospital},
    {'label': 'تعليمي', 'icon': Icons.menu_book},
    {'label': 'ديني', 'icon': Icons.volunteer_activism},
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocListener(
        listeners: [
          BlocListener<MonthlyDonationCubit, MonthlyDonationStates>(
            listener: (context, state) {
              if (state is MothlyDonationSuccess) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "تم تفعيل التبرع الشهري بنجاح، سيتم اقتطاع ${moneyController.text} من حسابك في بداية كل شهر، جزاك الله خيراً🙏🏻"),
                ));
                moneyController.clear();
              }
              if (state is MonthlyDonationUpdateFailed) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "إن هذه الميزة مفعلة لديك سابقاً، إذا كنت تريد تعديل المبلغ أو نوع التبرع، يمكنك إلغاء الميزة أولاً ثم إعادة تفعيلها من جديد"),
                ));
              }
              if (state is MothlyDonationFailure) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("هناك مشكلة ما ! يُرجى المحاولة لاحقاً"),
                ));
              }
            },
          ),
          BlocListener<CancleMonthlyDonationCubit, CancleMonthlyDonationState>(
            listener: (context, state) {
              if (state is success) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إلغاء التبرع الشهري بنجاح')),
                );
              } else if (state is alreadyCanceled) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("الميزة غير مفعلة حالياً")),
                );
              } else if (state is failure) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('هناك خطأ ما يُرجى المحاولة فيما بعد')),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<MonthlyDonationCubit, MonthlyDonationStates>(
          builder: (context, state) {
            return Stack(
              children: [
                Scaffold(
                  backgroundColor: colorScheme.surface,
                  appBar: const ConstAppBar(title: "تفعيل التبرع الشهري"),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          const SizedBox(height: 18),
                          const Text(
                            "يرجى تحديد المبلغ الذي ترغب بالتبرع به شهرياً",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 18),
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                ButtonOutlined(
                                  buttonText: r'100 $',
                                  onPressed: () {
                                    moneyController.text = "100";
                                  },
                                  borderColor: colorScheme.primary,
                                  textColor: colorScheme.primary,
                                ),
                                ButtonOutlined(
                                  buttonText: r'200 $',
                                  onPressed: () {
                                    moneyController.text = "200";
                                  },
                                  borderColor: colorScheme.primary,
                                  textColor: colorScheme.primary,
                                ),
                                ButtonOutlined(
                                  buttonText: r'300 $',
                                  onPressed: () {
                                    moneyController.text = "300";
                                  },
                                  borderColor: colorScheme.primary,
                                  textColor: colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          AuthCustomTextField(
                            hint: 'مبلغ التبرع',
                            icon: const Icon(Icons.attach_money),
                            inputType: TextInputType.number,
                            mycontroller: moneyController,
                            valid: (value) {
                              if (value!.isEmpty) return "مبلغ التبرع مطلوب";
                              if (value.startsWith("0") ||
                                  value.startsWith(".") ||
                                  value.startsWith(",") ||
                                  value.startsWith("-") ||
                                  value.endsWith(".") ||
                                  value.contains(",") ||
                                  value.contains("-")) {
                                return "يُرجى إدخال الرقم بطريقة صحيحة";
                              }
                              return null;
                            },
                            color: colorScheme.secondary,
                          ),
                          const SizedBox(height: 20),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "اختر المجال الذي تُحب أن يذهب خيرك إليه",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            alignment: WrapAlignment.spaceAround,
                            spacing: 20,
                            runSpacing: 12,
                            children: categories.map((category) {
                              final isSelected =
                                  selectedCategory == category['label'];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = category['label'];
                                    categoryError = false;
                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: isSelected
                                          ? colorScheme.secondary
                                          : Colors.grey[400],
                                      child: Icon(
                                        category['icon'],
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      category['label'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          if (categoryError)
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "الرجاء اختيار المجال المستهدف للتبرع",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 105, 95),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Authbutton(
                                buttonText: "تفعيل",
                                onPressed: () {
                                  setState(() {
                                    categoryError = selectedCategory == null;
                                  });
                                  if (formKey.currentState!.validate() &&
                                      !categoryError) {
                                    BlocProvider.of<MonthlyDonationCubit>(
                                            context)
                                        .enableMonthlyDonation(
                                      moneyController: moneyController,
                                      selectedCategory: selectedCategory,
                                    );
                                  }
                                },
                                color: colorScheme.secondary,
                              ),
                              const SizedBox(height: 12),
                              Authbutton(
                                buttonText: "إلغاء التفعيل",
                                onPressed: () {
                                  context
                                      .read<CancleMonthlyDonationCubit>()
                                      .cancleMonthlyDonation();
                                },
                                color: colorScheme.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is MothlyDonationLoading)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: SpinKitCircle(
                        color: colorScheme.secondary,
                        size: 45,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
