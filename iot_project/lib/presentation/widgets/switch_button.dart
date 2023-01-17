import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_project/buisness_logique/bloc/get_sensors_data_bloc.dart';
import 'package:provider/provider.dart';

class SwitchBtn extends StatefulWidget {
  String title;
  bool value;
  bool isForLedControle;
  SwitchBtn(
      {super.key,
      required this.title,
      required this.value,
      required this.isForLedControle});

  @override
  State<SwitchBtn> createState() => _SwitchBtnState();
}

class _SwitchBtnState extends State<SwitchBtn> {
  bool switchValue = false;
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
            value: switchValue,
            activeColor: Colors.blue,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                switchValue = value;
                value = switchValue;
                if (widget.isForLedControle) {
                  bloc.add(ActivateLedAutoControle(activated: value));
                  bloc.add(PostLedAutoControleValueEvent(activated: value));
                } else {
                  bloc.add(PostAllumedLedValueEvent(activated: value));
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
