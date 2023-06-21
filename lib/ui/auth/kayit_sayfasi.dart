import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisisel_butce_yonetimi/ui/auth/login_page.dart';
import 'package:kisisel_butce_yonetimi/ui/auth/providers/auth_view_model_provider.dart';
import 'package:kisisel_butce_yonetimi/ui/profil/profil_page_update.dart';
import 'package:lottie/lottie.dart';
import '../../utils/color.dart';
import '../components/snackbar.dart';
import '../root.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({Key? key}) : super(key: key);
  final _formkey = GlobalKey<FormState>();
  static const String route = "/register";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final styles = theme.textTheme;
    final model = ref.watch(authViewModelProvider);
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
                Text('Kayıt Ol', style: styles.headlineLarge),
                SizedBox(height:12),
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
                const SizedBox(height: 12),
                TextFormField(
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
                      )),
                  onChanged: (v) => model.password = v,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  obscureText: model.gizliPassword2,
                  initialValue: model.password2,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      labelText: 'Tekrar Şifre',
                      suffixIcon: IconButton(
                        icon: Icon(model.gizliPassword2
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () {
                          model.gizliPassword2 = !model.gizliPassword2;
                        },
                      )),
                  onChanged: (v) => model.password2 = v,
                ),
                const SizedBox(height: 12),
                MaterialButton(
                  color: kmavi,
                  padding: const EdgeInsets.all(16),
                  onPressed:
                      model.email.isNotEmpty && model.password.isNotEmpty&& model.password2.isNotEmpty
                          ? () async {
                              if (_formkey.currentState!.validate()) {
                                try {
                                  await model.kayit();
                                  Navigator.pushReplacementNamed(
                                      context, Root.route);
                                } catch (e) {
                                  AppSnackbar(context).error(e);
                                }
                                //model.giris();
                                Navigator.pushNamed(context, ProfilPageUpdate.route);
                              }
                            }
                          : null,
                  child: Text('Kayıt Ol'.toUpperCase()),
                ),
                const SizedBox(height: 4),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text:'Zaten Üye Misiniz?',
                      style: styles.bodyLarge,
                      children: [
                        TextSpan(
                            text: ' Giriş Yap',
                            style: styles.labelLarge!.copyWith(
                                fontSize: styles.bodyLarge!.fontSize),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                    context, LoginPage.route);
                              }),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
