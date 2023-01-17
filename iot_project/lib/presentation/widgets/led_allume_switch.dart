import 'package:flutter/material.dart';
import 'package:iot_project/buisness_logique/bloc/get_sensors_data_bloc.dart';
import 'package:provider/provider.dart';

class LedAllumedSwitch extends StatefulWidget {
  String title;
  bool ledAllumeControle;
  LedAllumedSwitch(
      {super.key,
      required this.title,
      required this.ledAllumeControle});

  @override
  State<LedAllumedSwitch> createState() => _LedAllumedSwitchState();
}

class _LedAllumedSwitchState extends State<LedAllumedSwitch> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GetSensorsDataBloc>(context);
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          Text(widget.title,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
              )),
          Switch(
            // This bool value toggles the switch.
            value: widget.ledAllumeControle,
            activeColor: Colors.blue,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                  widget.ledAllumeControle = value;
                  bloc.add(PostAllumedLedValueEvent(activated: widget.ledAllumeControle));
              });
            },
          ),
        ],
      ),
    );
  }
}
