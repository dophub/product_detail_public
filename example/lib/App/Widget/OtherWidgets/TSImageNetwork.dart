
import 'package:flutter/material.dart';
import 'package:example/App/Theme/AppColors.dart';

/// Base Image.network
class TSImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Widget? errorWidget;

  const TSImageNetwork(
      {Key? key,
      required this.imageUrl,
      this.height,
      this.width,
      this.fit,
      this.errorWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return errorWidget ?? const Icon(Icons.image, color: AppColor.paleTextColor);
      },
      fit: fit ?? BoxFit.cover,
    );
  }
}
