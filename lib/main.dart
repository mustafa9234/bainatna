import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const BainatnaApp());

const ink = Color(0xFF24143D);
const purple = Color(0xFF7042A5);
const pink = Color(0xFFE98AB5);
const gold = Color(0xFFE8C47A);

class BainatnaApp extends StatelessWidget {
  const BainatnaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'بيناتنا',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Arial',
          colorScheme: ColorScheme.fromSeed(seedColor: purple, brightness: Brightness.dark),
          scaffoldBackgroundColor: ink,
        ),
        home: const HomeScreen(),
      );
}

class Feeling {
  final String name, fromHim, fromHer, emoji;
  const Feeling(this.name, this.fromHim, this.fromHer, this.emoji);
}

const feelings = <Feeling>[
  Feeling('مشتاق', 'مشتاقلچ هواية، ودي أشوفچ هسه ❤️‍🔥', 'مشتاقتلك هواية، ودي أشوفك هسه ❤️‍🔥', '🥺'),
  Feeling('أحبك', 'أموت عليچ يا بعد روحي ❤️', 'أموت عليك يا بعد روحي ❤️', '❤️'),
  Feeling('أحتاجك', 'تعالي يمّي، محتاجچ 🫂', 'تعال يمّي، محتاجتك 🫂', '🫂'),
  Feeling('زعلان', 'آني متضايق منچ وخاطري مكسور 💔', 'آني متضايقة منك وخاطري مكسور 💔', '💔'),
  Feeling('أريد أصالحك', 'تعالي نتصالح، ما أتحمل زعلچ 😘', 'تعال نتصالح، ما أتحمل زعلك 😘', '😘'),
  Feeling('أغار عليك', 'أغار عليچ لأنچ غالية عندي ❤️', 'أغار عليك لأنك غالي عندي ❤️', '❤️‍🔥'),
  Feeling('فرحان', 'فرحتي تكمل بوجودچ 🥰', 'فرحتي تكمل بوجودك 🥰', '🥰'),
  Feeling('أريد أحچي', 'عندي حچي هواية إلك، مشتاق أسمع صوتچ 💗', 'عندي حچي هواية إلك، مشتاقت أسمع صوتك 💗', '💬'),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final codeController = TextEditingController();
  String? myCode;
  String? linkedCode;
  String sender = 'أنا';
  String? lastMessage;
  bool showFeelings = false;

  String makeCode() => (100000 + Random().nextInt(900000)).toString();

  void createCode() => setState(() {
        myCode = makeCode();
        linkedCode = null;
        showFeelings = false;
      });

  void joinCode() {
    final code = codeController.text.trim();
    if (code.length != 6 || int.tryParse(code) == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('أدخل رمز صحيح من 6 أرقام')));
      return;
    }
    setState(() {
      linkedCode = code;
      showFeelings = true;
    });
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft,
                colors: [Color(0xFF392052), ink, Color(0xFF171026)]),
            ),
            child: SafeArea(
              child: ListView(padding: const EdgeInsets.all(22), children: [
                const SizedBox(height: 18),
                const Icon(Icons.favorite_rounded, color: pink, size: 46),
                const SizedBox(height: 8),
                const Text('بيناتنا', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white)),
                const Text('مساحة صغيرة تجمع قلبين', textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFD9CBE8), fontSize: 15)),
                const SizedBox(height: 28),
                _avatars(),
                const SizedBox(height: 26),
                if (!showFeelings) _pairingCard() else _feelingsCard(),
                const SizedBox(height: 18),
                const Text('خصوصيتكم أولاً • ربط بين شخصين فقط', textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFB9A9CB), fontSize: 12)),
              ]),
            ),
          ),
        ),
      );

  Widget _avatars() => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _avatar('أنا', '🧑🏻‍🦱'),
        const Icon(Icons.favorite, color: pink, size: 30),
        _avatar('الشخص الثاني', '👩🏻‍🦰'),
      ]);

  Widget _avatar(String label, String face) => Column(children: [
        Container(width: 82, height: 82, decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.white.withOpacity(.10),
          border: Border.all(color: gold.withOpacity(.8), width: 1.5)),
          child: Center(child: Text(face, style: const TextStyle(fontSize: 42)))),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ]);

  Widget _panel({required Widget child}) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.white.withOpacity(.08),
          borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white.withOpacity(.13))),
        child: child,
      );

  Widget _pairingCard() => _panel(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('ابدأوا حكايتكم', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('بدون حساب، بدون إيميل، وبدون رقم هاتف', textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFFD5C8E2))),
        const SizedBox(height: 18),
        FilledButton.icon(onPressed: createCode, icon: const Icon(Icons.qr_code_2),
          label: const Text('إنشاء رمز ربط'),
          style: FilledButton.styleFrom(backgroundColor: purple, foregroundColor: Colors.white, padding: const EdgeInsets.all(14))),
        if (myCode != null) ...[
          const SizedBox(height: 12),
          const Text('رمزك للمشاركة', textAlign: TextAlign.center, style: TextStyle(color: gold)),
          SelectableText(myCode!, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 32, letterSpacing: 8, fontWeight: FontWeight.bold, color: Colors.white)),
          const Text('هذا رمز تجريبي محلي في هذه النسخة، وليس ربطاً عبر الإنترنت بعد.',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Color(0xFFE9C9D9))),
        ],
        const Divider(height: 28, color: Color(0x44FFFFFF)),
        const Text('عندك رمز من الطرف الثاني؟', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        TextField(controller: codeController, keyboardType: TextInputType.number, maxLength: 6,
          textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, letterSpacing: 6),
          decoration: InputDecoration(counterText: '', hintText: '••••••', hintStyle: const TextStyle(color: Colors.white38),
            filled: true, fillColor: Colors.black.withOpacity(.18), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)))),
        OutlinedButton(onPressed: joinCode, child: const Text('ربط بهذا الرمز', style: TextStyle(color: Colors.white))),
      ]));

  Widget _feelingsCard() => _panel(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('شنو تحب توصل إحساسك؟', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SegmentedButton<String>(segments: const [
          ButtonSegment(value: 'أنا', label: Text('أنا أرسل')),
          ButtonSegment(value: 'هي', label: Text('هي ترسل')),
        ], selected: {sender}, onSelectionChanged: (s) => setState(() => sender = s.first)),
        const SizedBox(height: 14),
        GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          itemCount: feelings.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2.7, crossAxisSpacing: 9, mainAxisSpacing: 9),
          itemBuilder: (context, i) => OutlinedButton(
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: pink.withOpacity(.6))),
            onPressed: () => setState(() => lastMessage = sender == 'أنا' ? feelings[i].fromHim : feelings[i].fromHer),
            child: Text('${feelings[i].emoji} ${feelings[i].name}', textAlign: TextAlign.center)),
        ),
        if (lastMessage != null) ...[
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: pink.withOpacity(.15), borderRadius: BorderRadius.circular(16)),
            child: Text(lastMessage!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18))),
          const Text('معاينة محلية فقط؛ الإرسال الحقيقي يحتاج ربط قاعدة بيانات.', textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFE9C9D9), fontSize: 11)),
        ],
      ]));
}
