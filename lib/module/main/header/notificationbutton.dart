
import 'package:flutter/material.dart';

class NotificationButton extends StatefulWidget {
  final Function() onPressed;
  const NotificationButton({super.key, required this.onPressed });
  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {


  void getDataFromServer(){
    // getCountUnhanded().then((alarmCount){
    //   setState(() {
    //     _alarmCount = alarmCount;
    //   });
    // });
  }

  @override
  void initState(){
    super.initState();
    // const oneSec = Duration(seconds: 5);
    // timerQueryData = Timer.periodic(oneSec, (Timer t) => getDataFromServer());   
  }

  @override
  void dispose(){
    super.dispose();
    // if (timerQueryData != null){
    //   timerQueryData!.cancel();
    // }
  }
  
  @override
  Widget build(BuildContext context) {
    int countNotification = 3;
    if (countNotification == 0){
      return TextButton(
        onPressed: widget.onPressed,
        child: const Icon(Icons.notifications),
      );
    } else {
      return Badge(
        label: Text('$countNotification'),  
        child: TextButton(
          onPressed: widget.onPressed,
          child: const Icon(Icons.notifications),
        )
      );
    }
    
  }
}