import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments as User?;
    if(user!=null){
    _loadFormData(user);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuárioss]'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final isValid = _form.currentState?.validate();

              if (isValid! && isValid) {
                _form.currentState?.save();
                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'].toString(),
                    name: _formData['name'].toString(),
                    email: _formData['email'].toString(),
                    avatarUrl: _formData['avatarUrl'].toString(),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(children: <Widget>[
            TextFormField(
              initialValue: _formData['name'],
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nome inválido';
                }
                if (value.trim().length < 3) {
                  return 'Nome muito pequeno. No mínimo 3 letras';
                }
                return null;
              },
              onSaved: (value) => _formData['name'] = value.toString(),
            ),
            TextFormField(
              initialValue: _formData['email'],
              decoration: InputDecoration(labelText: 'E-Mail'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'E-mail inválido';
                }
                if (value.trim().length < 3) {
                  return 'E-mail muito pequeno.';
                }
                return null;
              },
              onSaved: (value) => _formData['email'] = value.toString(),
            ),
            TextFormField(
              initialValue: _formData['avatarUrl'],
              decoration: InputDecoration(labelText: 'URL do Avatar'),
              // validator: (value) {
              //   if (value == null || value.trim().isEmpty) {
              //     return 'URL inválido';
              //   }
              //   if (value.trim().length < 3) {
              //     return 'URL muito pequeno.';
              //   }
              //   return null;
              // },
              onSaved: (value) => _formData['avatarUrl'] = value.toString(),
            ),
          ]),
        ),
      ),
    );
  }
}