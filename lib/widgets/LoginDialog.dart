import 'package:flutter/material.dart';
import '../dto/Request.dart';
import '../service/OcpService.dart';
import '../service/service_locator.dart';
import 'DialogInput.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key, required this.onChanged}) : super(key: key);

  final ValueChanged<Request> onChanged;
  @override
  LoginDialogState createState() {
    return LoginDialogState();
  }
}

class LoginDialogState extends State<LoginDialog> {
  final _formKey = GlobalKey<FormState>();
  final urlController = TextEditingController();
  final usrController = TextEditingController();
  final passController = TextEditingController();
  String token = "";
  void clearForm() {
    urlController.text = '';
    usrController.text = '';
    passController.text = '';
  }

  void _saveToken() {
    widget.onChanged(Request(token: token, url: urlController.text));
  }

  OcpService service = getIt<OcpService>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Login'),
      contentPadding: EdgeInsets.all(20),
      elevation: 10,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DialogInput(
                    controller: urlController,
                    label: 'Api Url',
                    autofocus: true),
                DialogInput(controller: usrController, label: 'User'),
                DialogInput(
                    controller: passController, label: 'Password', pass: true),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    child: const Text('Connect'),
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        token = await service.login(urlController.text,
                            usrController.text, passController.text);
                        if (token == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Incorrect user or password')),
                          );
                        } else {
                          _saveToken();
                          clearForm();
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
