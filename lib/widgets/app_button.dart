import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final double? width;
  final double? height;
  final bool enabled;
  final double radius;

  const AppButton({
    super.key,
    required this.onTap,
    required this.title,
    this.width,
    this.height,
    this.enabled = true,
    this.radius = 10.0,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      child: SizedBox(
        width: widget.width,
        height: (widget.height ?? 60),
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                height: (widget.height ?? 60),
                color: !widget.enabled
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
                highlightElevation: 0,
                onPressed: () {
                  if (loading) return;
                  setState(() => loading = true);
                  widget.onTap();
                  setState(() => loading = false);
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  side: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.5),
                ),
                child: Center(
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          widget.title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
