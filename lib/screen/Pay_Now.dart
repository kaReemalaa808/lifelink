import 'package:flutter/material.dart';
import 'invoice_page.dart';

/// `PayNow` is a simple wrapper that provides RTL directionality
/// and exposes the `PaymentScreen` so it can be pushed from the
/// app's main `MaterialApp` without nesting another one.
class PayNow extends StatelessWidget {
  const PayNow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: PaymentScreen(),
    );
  }
}

// --------------------------------------------------------------
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum PaymentMethod { vodafone, visa, mastercard }

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _selected = PaymentMethod.vodafone;
  final double _amount = 200.0;

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(Icons.bloodtype, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Text('بنك الدم', style: themeText.titleLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('الدفع', style: themeText.displayMedium),
              const SizedBox(height: 12),

              // Summary card
              Container(
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).scaffoldBackgroundColor == Colors.white
                      ? Colors.white
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF1D4D4)),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'ملخص العملية',
                      style: themeText.titleMedium!.copyWith(color: primary),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('نوع الخدمة', style: themeText.bodyMedium),
                        Text(
                          'كيس دم فصيله AB+ ',
                          style: themeText.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('المبلغ', style: themeText.bodyMedium),
                        Text(
                          '${_amount.toStringAsFixed(0)} جنيه',
                          style: themeText.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Text('طريقة الدفع', style: themeText.titleMedium),
              const SizedBox(height: 12),

              // Vodafone Cash
              _paymentTile(
                title: 'Vodafone Cash ',
                subtitle: 'سهل وسريع',
                icon: Image.asset('images/01.png', width: 70, height: 70),
                value: PaymentMethod.vodafone,
              ),

              const SizedBox(height: 10),

              // Visa
              _paymentTile(
                title: 'VISA',
                subtitle: 'استخدام البطاقة',
                icon: Image.asset('images/03.png', width: 70, height: 70),
                value: PaymentMethod.visa,
              ),

              const SizedBox(height: 10),

              // Mastercard
              _paymentTile(
                title: 'Mastercard',
                subtitle: 'استخدام البطاقة',
                icon: Image.asset('images/02.png', width: 70, height: 70),
                value: PaymentMethod.mastercard,
              ),

              const SizedBox(height: 24),

              if (_selected != PaymentMethod.vodafone) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'بيانات البطاقة',
                        style: themeText.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '●●●● ●●●● ●●●● ●●●●',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'MM/YY',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 110,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'CVV',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _onPayPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 8,
                  ),
                  child: Text(
                    'إتمام الدفع',
                    style: themeText.bodyLarge!.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: Text(
                  'جميع الحقوق محفوظة 2025',
                  textAlign: TextAlign.center,
                  style: themeText.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentTile({
    required String title,
    String? subtitle,
    required Widget icon,
    required PaymentMethod value,
  }) {
    final bool selected = _selected == value;
    return GestureDetector(
      onTap: () => setState(() => _selected = value),
      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: const Color(0xFFDDE2E5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : Colors.black87,
                    ),
                  ),
                  if (subtitle != null) const SizedBox(height: 4),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: selected ? Colors.white70 : Colors.black54,
                      ),
                    ),
                ],
              ),
            ),
            Radio<PaymentMethod>(
              value: value,
              groupValue: _selected,
              onChanged: (v) => setState(() => _selected = v!),
              activeColor: selected
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  void _onPayPressed() {
    final method = _selected == PaymentMethod.vodafone
        ? 'Vodafone Cash'
        : (_selected == PaymentMethod.visa ? 'VISA' : 'Mastercard');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الدفع'),
        content: Text(
          'المبلغ: ${_amount.toStringAsFixed(0)} جنيه\nطريقة الدفع: $method',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // يغلق الحوار

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                          InvoicePage(amount: _amount, method: method),
                ),
              );
            },
            child: const Text('متابعة'),
          ),
        ],
      ),
    );
  }
}
