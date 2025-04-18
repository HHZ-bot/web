import 'package:flutter/material.dart';
import 'package:webpig/providers/theme_manager.dart'; // 你已有的主题管理器

class HelpPageApp extends StatefulWidget {
  const HelpPageApp({super.key});

  @override
  State<HelpPageApp> createState() => _HelpPageAppState();
}

class _HelpPageAppState extends State<HelpPageApp> {
  int _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 700;
    final containerWidth = screenWidth * 0.8;
    final itemWidth = isWide ? containerWidth / 2 - 8 : containerWidth;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        '请先选择适用您的情形',
        style: TextStyle(fontSize: 40),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: containerWidth,
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  direction: isWide ? Axis.horizontal : Axis.vertical,
                  children: [
                    _buildRadioOption(0, '我只有中国大陆区Apple ID', itemWidth),
                    _buildRadioOption(1, '我有海外Apple ID', itemWidth),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_selectedOption == 0) const HelpCard(),
            if (_selectedOption == 1)
              const Text(
                'This is a simple text view.',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(int value, String label, double width) {
    final isSelected = _selectedOption == value;
    final isSmallScreen = MediaQuery.of(context).size.width < 700;

    return InkWell(
      onTap: () {
        setState(() => _selectedOption = value);
      },
      child: Container(
        width: width,
        padding: EdgeInsets.only(
          left: 40,
          top: isSmallScreen ? 20 : 28,
          bottom: isSmallScreen ? 20 : 28,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    ThemeProvider.instance.primaryColor!.withOpacity(0.7),
                    ThemeProvider.instance.primaryColor!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(58),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 4),
              blurRadius: 10,
            ),
          ],
          border: isSelected ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.scale(
              scale: width / 240,
              child: Radio<int>(
                value: value,
                groupValue: _selectedOption,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedOption = newValue!;
                  });
                },
                activeColor: isSelected ? Colors.white : Colors.grey,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return isSelected ? Colors.white : Colors.grey;
                  }
                  return Colors.grey;
                }),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  fontSize: width * 0.062,
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HelpCard extends StatefulWidget {
  const HelpCard({super.key});

  @override
  State<HelpCard> createState() => _HelpCardState();
}

class _HelpCardState extends State<HelpCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 未展开时显示默认内容
            if (!_expanded)
              const Text(
                'Having trouble with iOS setup? Tap below to view the full guide.',
                style: TextStyle(fontSize: 16),
              ),

            // 展开后显示的内容
            if (_expanded)
              Column(
                children: [
                  _buildStep(
                    imageUrl: 'assets/images/step1.png', // 修改为你本地的图片路径
                    description: '1. Open iPhone Settings > Tap VPN',
                  ),
                  const SizedBox(height: 12),
                  _buildStep(
                    imageUrl: 'assets/images/step2.png', // 修改为你本地的图片路径
                    description: '2. Tap "Add VPN Configuration"',
                  ),
                  const SizedBox(height: 12),
                  _buildStep(
                    imageUrl: 'assets/images/step3.png', // 修改为你本地的图片路径
                    description:
                        '3. Choose Type > IKEv2 and fill in server info',
                  ),
                  const SizedBox(height: 12),
                  _buildStep(
                    imageUrl: 'assets/images/step4.png', // 修改为你本地的图片路径
                    description: '4. Save and toggle VPN on to connect',
                  ),
                ],
              ),

            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                setState(() => _expanded = !_expanded);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_expanded ? 'Collapse' : 'Show More',
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.blue,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStep({required String imageUrl, required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imageUrl,
            width: 80, height: 80, fit: BoxFit.cover), // 使用本地图片
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
