import 'package:flutter/material.dart';
import 'package:pr2/theme/app_theme.dart';
import 'package:pr2/widgets/text_field.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final _fullNameController = TextEditingController(text: 'Иванов Иван Иванович');
  final _emailController = TextEditingController(text: 'test123@mail.ru');
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppTheme.card,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: AppTheme.textIcon,
                    ),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  const Text(
                    'Профиль',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: const NetworkImage(
                        'https://i.pravatar.cc/150?u=profile',
                      ),
                      backgroundColor: AppTheme.card,
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      GestureDetector(
                        onTap: () {
                          final current = ModalRoute.of(context)?.settings.name;
                          if (current != '/profile') {
                            Navigator.of(context).pushNamed('/profile');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Это экран профиля'),
                              ),
                            );
                          }
                        },
                        child: CustomTextField(
                          label: 'ФИО',
                          hint: 'Иванов Иван Иванович',
                          icon: Icons.person_outline,
                          fieldType: FieldType.fullName,
                          controller: _fullNameController,
                          focusNode: _fullNameFocus,
                          nextFocusNode: _emailFocus,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Email',
                            hint: 'Email',
                            icon: Icons.email_outlined,
                            fieldType: FieldType.email,
                            controller: _emailController,
                            focusNode: _emailFocus,
                            nextFocusNode: _passwordFocus,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Пароль',
                            hint: 'Пароль',
                            icon: Icons.lock_outline,
                            fieldType: FieldType.password,
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            nextFocusNode: _confirmPasswordFocus,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Повторите пароль',
                            hint: 'Повторите пароль',
                            icon: Icons.lock_outline,
                            fieldType: FieldType.confirmPassword,
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocus,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Поле не может быть пустым';
                              }
                              if (value.trim() !=
                                  _passwordController.text.trim()) {
                                return 'Пароли не совпадают';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Изменения сохранены',
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.surface,
                                foregroundColor: AppTheme.textPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Сохранить',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
