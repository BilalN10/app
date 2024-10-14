import 'package:findyourdresse_app/config/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextWithUrl extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final TextOverflow overflow;
  final int? maxLines;

  const TextWithUrl({
    Key? key,
    required this.text,
    this.style,
    this.overflow = TextOverflow.ellipsis,
    this.linkStyle,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final regex = RegExp(r'((http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-]))');

    final List<InlineSpan> textSpans = [];

    var matches = regex.allMatches(text);

    int currentIndex = 0;
    for (Match match in matches) {
      // Add non-URL text before the match
      final nonUrlText = text.substring(currentIndex, match.start);
      if (nonUrlText.isNotEmpty) {
        textSpans.add(
          TextSpan(text: nonUrlText, style: style),
        );
      }

      // Add URL text with tap recognizer
      final urlText = match.group(0);
      textSpans.add(
        TextSpan(
          text: urlText,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              Uri? _ = Uri.tryParse(urlText!);
              if (_ != null && await canLaunchUrl(_)) launchUrl(_);
            },
        ),
      );

      currentIndex = match.end;
    }

    // Add remaining non-URL text
    if (currentIndex < text.length) {
      textSpans.add(
        TextSpan(
          text: text.substring(currentIndex),
          style: AppThemeStyle.detailSubtitle,
        ),
      );
    }

    return RichText(
      text: TextSpan(children: textSpans),
      maxLines: maxLines ?? 100000,
      overflow: overflow,
    );
  }
}
