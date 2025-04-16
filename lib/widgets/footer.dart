import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      margin: EdgeInsets.all(0),
      color: const Color(0xFF0E1823), // 深色背景
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isMobile)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogoAndDescription(context),
                const Divider(color: Colors.white24),
                _buildLinkColumn("关于我们", ["团队介绍", "品牌故事", "加入我们"]),
                _buildLinkColumn("支持", ["帮助中心", "常见问题", "联系客服"]),
                _buildLinkColumn(
                    "联系", ["邮箱: contact@example.com", "电话: 123-456-789"]),
              ],
            ),
          if (isMobile)
            Column(
              children: [
                _buildLogoAndDescription(context),
                const SizedBox(height: 20),
                _buildLinkColumn("关于我们", ["团队介绍", "品牌故事", "加入我们"]),
                const SizedBox(height: 20),
                _buildLinkColumn("支持", ["帮助中心", "常见问题", "联系客服"]),
                const SizedBox(height: 20),
                _buildLinkColumn(
                    "联系", ["邮箱: contact@example.com", "电话: 123-456-789"]),
              ],
            ),
          const SizedBox(height: 30),
          const Divider(color: Colors.white24),
          const SizedBox(height: 15),
          Text(
            '© 2025 YourCompany Inc. 保留所有权利',
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoAndDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 你的 logo，可以换成 Image.asset(...) 或 SvgPicture
        Text(
          context.tr('general.title'),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '为开发者与创作者提供高质量工具与服务。',
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
      ],
    );
  }

  Widget _buildLinkColumn(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              link,
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ),
        ),
      ],
    );
  }
}
