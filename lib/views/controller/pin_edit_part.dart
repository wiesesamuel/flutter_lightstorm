part of views;

class PinEditPart extends StatefulWidget {
  final Pin pin;

  PinEditPart(this.pin);

  @override
  _PinEditPartState createState() => _PinEditPartState(pin);
}

class _PinEditPartState extends State<PinEditPart> {
  bool state = false;
  final Pin pin;
  ListView pinSettings;
  ListTile header;

  @override
  Widget build(BuildContext context) {
    if (state) {
      return pinSettings;
    } else
      return header;
  }

  _PinEditPartState(this.pin) {
    header = ListTile(
      leading: Icon(Icons.lightbulb_outline),
      title: Text(pin.name),
      onTap: () => setState(() {
        state = !state;
      }),
    );

    Color pickerColor = Color(pin.color);

    pinSettings = ListView(
      children: [
        ListTile(
          leading: Icon(Icons.lightbulb_outline),
          title: TextFormField(
            autocorrect: false,
            initialValue: pin.name,
            decoration: InputDecoration(
              labelText: "Name",
              hintText: "Pin",
            ),
            keyboardType: TextInputType.text,
            onSaved: (String s) => pin.name = s,
          ),
        ),
        ListTile(
          leading: Icon(Icons.sms),
          title: TextFormField(
            autocorrect: false,
            initialValue: pin.pin_nr.toString(),
            decoration: InputDecoration(
              labelText: "Pin Nr",
              hintText: "Pin",
            ),
            keyboardType: TextInputType.number,
            onSaved: (String s) => pin.pin_nr = int.parse(s),
          ),
        ),
        ListTile(
          leading: Icon(Icons.color_lens),
          title: Text("Color"),
          onTap: () => showDialog(
            context: context,
            child: AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pin.color,
                  onColorChanged: (Color color) {
                    setState(() => pickerColor = color);
                  },
                  enableLabel: true,
                  pickerAreaHeightPercent: 0.8,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    setState(() => pin.color = pickerColor);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
