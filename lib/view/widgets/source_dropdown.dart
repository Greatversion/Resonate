import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resonate/main.dart';
import 'package:resonate/view/auxScreen.dart';
import 'package:resonate/view/blutooth_screen.dart';



class ModesWidget extends StatefulWidget {
  @override
  _ModesWidgetState createState() => _ModesWidgetState();
}

class _ModesWidgetState extends State<ModesWidget> {
  final List<ListTile> items = [
    ModeTile(darkColor.lightgrey, 'Bluetooth Mode',
        'Connects to devices via Bluetooth', Icons.bluetooth),
    ModeTile(
        darkColor.lightgrey, 'Wi-Fi Mode', 'Stream over Wi-Fi', Icons.wifi),
    ModeTile(darkColor.lightgrey, 'AUX Mode', 'Plug in with Aux', Icons.cable),
  ];

  ListTile? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<ListTile>(
        isExpanded: true,
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.memory_outlined,
              size: 35,
              color: darkColor.lightgreen,
            ),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              child: Text(
                'Select Another Mode',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items.map((ListTile item) {
          return DropdownMenuItem<ListTile>(
            value: item,
            child: item,
          );
        }).toList(),
        value: selectedValue,
        onChanged: (ListTile? value) {
          setState(() {
            selectedValue = value;

            if (selectedValue == items[0]) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const BluetoothScreen()),
              );
            } else if (selectedValue == items[1]) {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => MyApp()),
              // );
            } else if (selectedValue == items[2]) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AuxScreen()),
              );
            }
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 80,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black26,
            ),
            color: darkColor.lightgrey,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(Icons.arrow_drop_down_circle_outlined, size: 25),
          iconSize: 14,
          iconEnabledColor: Colors.white,
          iconDisabledColor: darkColor.darkgreen,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: double.maxFinite,
          width: MediaQuery.of(context).size.width - 24,
          decoration: BoxDecoration(
            color: darkColor.lightgrey,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 80,
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
ListTile ModeTile(
    Color tileColor, String title, String subtitle, IconData icon) {
  return ListTile(
    tileColor: tileColor,
    leading: Icon(
      icon,
      size: 25,
      color: Colors.white,
    ),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
