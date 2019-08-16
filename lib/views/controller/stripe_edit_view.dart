part of views;

class StripeEditView extends StatefulWidget {
  final Stripe stripe;

  StripeEditView(this.stripe);

  @override
  _StripeEditViewState createState() => _StripeEditViewState(stripe);
}

class _StripeEditViewState extends State<StripeEditView> {
  final Stripe stripe;

  _StripeEditViewState(this.stripe);

  @override
  Widget build(BuildContext context) {
    List content = [];
    content.add(
      ListTile(
        leading: Icon(Icons.account_circle),
        title: TextFormField(
          autocorrect: false,
          initialValue: stripe.name,
          decoration: InputDecoration(
            labelText: "Name",
            hintText: "Stripe",
          ),
          onSaved: (String s) => stripe.name = s,
          //validator: validateBasic,
          //autovalidate: _autoValidateFields,
        ),
      ),
    );
    for (var pin in stripe.pins) {
      content.add(PinEditPart(pin));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Stripe'),
      ),
      body: Form(
        child: NoOverglow(
          child: ListView(children: content),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('Save'),
            onPressed: () {
              // TODO update server stripe
            },
          ),
          FlatButton(
            child: Text('add'),
            onPressed: () {
              // TODO send server new stripe
            },
          ),
        ],
      ),
    );
  }

}
