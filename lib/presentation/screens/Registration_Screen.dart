import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_event.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_state.dart';
import 'package:flutter_application_firebase/presentation/screens/Home_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
            (Route<dynamic> route) => false,
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Регистрация')),
        body: Container(
          width: 1000,
          height: 800,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextField(_nameController, 'ФИО'),
                _buildTextField(_emailController, 'Электронная почта'),
                
                _buildTextField(_phoneController, 'Номер телефона'),
                _buildTextField(_countryController, 'Страна'),
                _buildTextField(_passwordController, 'Пароль', isPassword: true),
                SizedBox(height: 24),
                ElevatedButton(
                  child: Text('Зарегистрироваться'),
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      SignUpRequested(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        phone: _phoneController.text,
                        country: _countryController.text,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                TextButton(
                  child: Text('Вход'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
        ),
        obscureText: isPassword,
      ),
    );
  }
}