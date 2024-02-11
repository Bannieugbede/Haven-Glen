import 'package:flutter/material.dart';
import 'package:haven_glen/utils/constants/sizes.dart';

class ZProfileMenu extends StatelessWidget {
  const ZProfileMenu({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: ZSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(title,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis)),
            Expanded(
                flex: 5,
                child: Text(value,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}
