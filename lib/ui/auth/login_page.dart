import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisisel_butce_yonetimi/ui/auth/providers/auth_view_model_provider.dart';
import 'package:lottie/lottie.dart';

import '../../utils/color.dart';
import '../components/snackbar.dart';
import '../root.dart';
import 'kayit_sayfasi.dart';

class LoginPage extends ConsumerWidget {
  static const String route = "/loginn";
  LoginPage({Key? key}) : super(key: key);
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final styles = theme.textTheme;
    final provider = authViewModelProvider;
    final model = ref.read(authViewModelProvider);
    ref.watch(provider.select((value) => value.loading));

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Lottie.asset(
                    'Assets/lottie/wallet2.json',
                    repeat: false,
                  ),
                ),
                SizedBox(height:4),
                Text("Giriş Yap", style: styles.headlineLarge),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: model.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                  ),
                  onChanged: (v) => model.email = v,
                  validator: (v) => model.emailKontrol(v!),
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider.select((value) => value.gizliPassword));
                    return TextFormField(
                      obscureText: model.gizliPassword,
                      initialValue: model.password,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        labelText: 'Şifre',
                        suffixIcon: IconButton(
                          icon: Icon(model.gizliPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                          onPressed: () {
                            model.gizliPassword = !model.gizliPassword;
                          },
                        ),
                      ),
                      onChanged: (v) => model.password = v,
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider);
                    return MaterialButton(
                      color: kmavi,
                      padding: const EdgeInsets.all(16),
                      onPressed: model.email.isNotEmpty &&
                          model.password.isNotEmpty
                          ? () async {
                        if (_formkey.currentState!.validate()) {
                          try {
                            await model.giris();
                            Navigator.pushReplacementNamed(
                                context, Root.route);
                          } catch (e) {
                            AppSnackbar(context).error(e);
                          }
                          model.giris();
                        }
                      }
                          : null,
                      child: Text("Giriş Yap".toUpperCase()),
                    );
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Hesabınız Yok mu? ',
                    style: styles.bodyLarge,
                    children: [
                      TextSpan(
                        text:'Kayıt ol',
                        style: styles.labelLarge!.copyWith(
                          fontSize: styles.bodyLarge!.fontSize,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, RegisterPage.route);
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

