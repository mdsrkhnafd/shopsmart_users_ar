import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopsmart_users_ar/services/my_app_method.dart';
import '../../consts/my_validators.dart';
import '../../root_screen.dart';
import '../../services/assets_manager.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/subtitle_text.dart';
import '../../widgets/title_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _forgetPassFCT() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });

        await auth.sendPasswordResetEmail(
            email: _emailController.text.trim().toString());

        Fluttertoast.showToast(
          msg:
              "We have sent you an email to recover the password, please check your email",
          textColor: Colors.white,
        );

        // if(!mounted) return;
        // Navigator.pushReplacementNamed(context, RootScreen.routeName);
      } on FirebaseException catch (error) {
        if (error.code == 'user-not-found') {
          /// Handle the case where the email is not registered
          if (!mounted) return;
          await MyAppMethods.showErrorORWarningDialog(
              context: context,
              subtitle: "This email is not registered. Please sign up.",
              fct: () {});
          // Fluttertoast.showToast(
          //   msg: "This email is not registered. Please sign up.",
          //   textColor: Colors.white,
          // );
          // if(!mounted) return;
          // Navigator.pushReplacementNamed(context, RootScreen.routeName);
        } else {
          if (!mounted) return;
          await MyAppMethods.showErrorORWarningDialog(
              context: context, subtitle: error.toString(), fct: () {});
        }
      } catch (error) {
        if (!mounted) return;
        await MyAppMethods.showErrorORWarningDialog(
            context: context, subtitle: error.toString(), fct: () {});
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppNameTextWidget(
          fontSize: 22,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            // shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            physics: const BouncingScrollPhysics(),
            children: [
              // Section 1 - Header
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                AssetsManager.forgotPassword,
                width: size.width * 0.6,
                height: size.width * 0.6,
              ),
              const SizedBox(
                height: 10,
              ),
              const TitlesTextWidget(
                label: 'Forgot password',
                fontSize: 22,
              ),
              const SubtitleTextWidget(
                label:
                    'Please enter the email address you\'d like your password reset information sent to',
                fontSize: 14,
              ),
              const SizedBox(
                height: 40,
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'youremail@email.com',
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(IconlyLight.message),
                        ),
                        filled: true,
                      ),
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                      onFieldSubmitted: (_) {
                        // Move focus to the next field when the "next" button is pressed
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    // backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  icon: const Icon(IconlyBold.send),
                  label: const Text(
                    "Request link",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () async {
                    _forgetPassFCT();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
