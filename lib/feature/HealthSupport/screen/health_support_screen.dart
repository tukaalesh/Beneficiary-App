import 'package:charity_app/constants/custom_text.dart';
import 'package:flutter/material.dart';

class HealthSupportScreen extends StatelessWidget {
  const HealthSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text("تقديم طلب مساعدة صحي")),
          body: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  'يرجى إدخال هذه المعلومات بدقة ومصداقية تامة',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/صحي.png',
                    color: Colors.white.withOpacity(0.5),
                    colorBlendMode: BlendMode.dstATop,
                  ),
                ),
              ),
              // Customtextfields(hint: "", inputType: inputType, mycontroller: mycontroller, valid: valid)
            ],
          ),
        ));
  }
}
