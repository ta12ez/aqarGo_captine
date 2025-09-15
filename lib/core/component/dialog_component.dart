import 'package:flutter/material.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/constant/color.dart';

class DialogComponent extends StatelessWidget {
  final String title;
  final String content;
  final String? confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Color confirmColor;
  const DialogComponent({
    Key? key,
    required this.title,
    required this.content,
    this.confirmText,
    this.confirmColor=mainColor1,
     this.onConfirm,
    this.cancelText = "إلغاء",
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style:  Theme.of(context).textTheme.titleSmall!.copyWith(color: mainColor2)
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (cancelText.isNotEmpty)
                  Expanded(
                    child: ButtomComponent(
                        color: Colors.grey,
                        text: cancelText, onPressed: (){
                      Navigator.pop(context);
                      if (onCancel != null) onCancel!();

                    }),
                  ),
                const SizedBox(width: 8),
                if(confirmText!=null)
                Expanded(
                  child: ButtomComponent(
                    color: confirmColor,
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm!();
                    },
                    text: confirmText!,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
