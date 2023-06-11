import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar("الشروط والأحكام"),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Container(
                  height: 140.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      // fit: BoxFit.fill,
                      image: AssetImage("assets/images/demo.png"),
                    ),
                  ),
                ),
                const TxtStyle("تطبيق سكن", 18, primary, FontWeight.normal),
                SizedBox(
                  width: 316.w,
                  child: const TxtStyle(
                    '''
تطبيق سكن هو ملك لشركة سكن للإيجار غرضه الوحيد تسهيل عمليات البحث عن سكن وعرض سكن للإيجار. سواءً كنت مؤجراً أو مستأجراً، أثناء استخدامك للتطبيق تأكد بأننا نسعى لتحقيق أفضل ما يمكننا لنحصل على رضاك، لهذا إن كان هناك ما تقترحه علينا لا تتردد بذلك.''',
                    12,
                    darkGrey,
                    FontWeight.normal,
                    longText: true,
                    isDescribtion: true,
                    textAlignm: TextAlign.center,
                  ),
                ),
                const TxtStyle(
                  "sakan@sakan.com",
                  14,
                  primary,
                  FontWeight.normal,
                ),
                // معلومات عامة
                const Divider(color: primary),
                const Align(
                  alignment: Alignment.centerRight,
                  child: TxtStyle(
                      "معلومات عامة", 13, Colors.black, FontWeight.normal),
                ),
                SizedBox(
                  width: 316.w,
                  child: const TxtStyle(
                    '''
- جميع المساكن المعروضة تعود ملكيتها لأصحابها، ويوفر المكتب الدعاية المطلوبة والاهتمام بالإجراءات التقليدية لتوفير الوقت على المستخدمين.
- في حال إعجابك بأحد المساكن اضغط على زر الإتصال وسيجيبك أحد عملاء مكتب سكن على الفور ليوضح لك جميع استفساراتك.
''',
                    12,
                    darkGrey,
                    FontWeight.normal,
                    longText: true,
                    isDescribtion: true,
                    textAlignm: TextAlign.start,
                  ),
                ),

                // "معلومات هامة عند عرض سكنك للإيجار"
                const Divider(color: primary),
                const Align(
                  alignment: Alignment.centerRight,
                  child: TxtStyle("معلومات هامة عند عرض سكنك للإيجار", 13,
                      Colors.black, FontWeight.normal,
                      longText: true),
                ),
                SizedBox(
                  width: 316.w,
                  child: const TxtStyle(
                    '''- تأكدك من وضع معلومات صحيحة وصادقة يسرع من عملية عرض سكنك لبقية المستخدمين.
- المعلومات التي تضعها عن سكنك هي معلومات حساسة وهامة، لهذا لا يمكنك تعديلها إلا بعد اتصالك بالمكتب لتقدم طلباً للتعديل، ويتم التعديل من خلال لوحة التحكم الخاصة بإدارة المكتب.
- سيتواصل معك المندوب بعد إرسالك للنموذج ليكمل معك بقية الإجراءات للعرض.
- الأمور المالية ومنها (العمولة - الدعاية) يتم التفاهم عليها بالتراضي عند اللقاء من أجل توقيع العقد، ولا يتم ذلك من خلال التطبيق لنسمح لك بالتحاور حولها وعدم تقييدك بخيارات محددة.
- أقل مدة للإيجار هي شهران، لهذا لا يُسمح بحذف السكن من التطبيق إلا بعد انقضاء المدة.''',
                    12,
                    darkGrey,
                    FontWeight.normal,
                    longText: true,
                    isDescribtion: true,
                    textAlignm: TextAlign.start,
                  ),
                ),
                SizedBox(height: 20.h),
                const Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TxtStyle(
                          "POWERED BY:  ", 13, Colors.black, FontWeight.normal),
                      TxtStyle(
                        "Sakan Company",
                        14,
                        primary,
                        FontWeight.normal,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
