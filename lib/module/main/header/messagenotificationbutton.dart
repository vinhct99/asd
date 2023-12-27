
import 'package:flutter/material.dart';
class MessageNotificationButton extends StatefulWidget {
  final Function() onPressed;
  const MessageNotificationButton({super.key, required this.onPressed});

  @override
  State<MessageNotificationButton> createState() => _MessageNotificationButtonState();
}

class _MessageNotificationButtonState extends State<MessageNotificationButton> {
  @override
  Widget build(BuildContext context) {
    int countNotification = 3;
    if (countNotification == 0){
      return TextButton(
        onPressed: widget.onPressed,
        child: const Icon(Icons.message),
      );
    } else {
      return Badge(
        label: Text('$countNotification'),  
        child: TextButton(
          onPressed: widget.onPressed,
          
          child: const Icon(Icons.messenger),
        )
      );
    }
  }
}
