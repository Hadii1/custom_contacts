import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Data/contact.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({@required this.contact});
  final Contact contact;

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Container(
                  color: Colors.grey.withAlpha(25),
                  child: Center(
                    child: Text(
                      '${widget.contact.firstName} ${widget.contact.lastName}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
                child: NumberField(
                  contact: widget.contact,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 24, left: 24, right: 24, bottom: 12),
                child: Text(
                  'Title: ${widget.contact.jobTitle}',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Text(
                  'Department: ${widget.contact.department}',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
              Divider(),
              EmailField(
                email: widget.contact.email,
              ),
              Divider(),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.blue,
                    ),
                    Text(
                      'Contacts',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({@required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              'Email: $email',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(100),
            splashColor: Colors.blue,
            onTap: () async {
              bool launchable = await canLaunch(
                'mailto:$email',
              );

              if (launchable) {
                launch(
                  'mailto:$email',
                );
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Couldn\'t apply action'),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberField extends StatefulWidget {
  const NumberField({@required this.contact});
  final Contact contact;

  @override
  _NumberFieldState createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  TextEditingController _textCtrl;
  @override
  void initState() {
    _textCtrl = TextEditingController(text: '+ ${widget.contact.phoneNumber}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IgnorePointer(
              child: TextField(
                controller: _textCtrl,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ),
                readOnly: true,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            splashColor: Colors.blue,
            onTap: () async {
              bool launchable = await canLaunch(
                'tel:${widget.contact.phoneNumber}',
              );

              if (launchable) {
                launch(
                  'tel:${widget.contact.phoneNumber}',
                );
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Couldn\'t apply action'),
                  ),
                );
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        )

      ],
    );
  }
}
