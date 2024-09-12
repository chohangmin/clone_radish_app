import 'package:clone_radish_app/constants/common_size.dart';
import 'package:clone_radish_app/states/user_provider.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final inputBorder =
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  final TextEditingController _phoneNumberController =
      TextEditingController(text: "010");

  final TextEditingController _verifyNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;

      return IgnorePointer(
        ignoring: _verificationStatus == VerificationStatus.verifying,
        child: Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                '로그인 하기',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              elevation: Theme.of(context).appBarTheme.elevation,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: common_sm_padding,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          ExtendedImage.asset(
                            'assets/images/security.png',
                            width: size.width * 0.25,
                            height: size.height * 0.25,
                          ),
                          const SizedBox(
                            width: common_sm_padding,
                          ),
                          const Text(
                              '무 마켓은 전화번호로 가입합니다.\n여러분의 개인정보는 안전히 보관되며,\n외부에 노출되지 않습니다.'),
                        ],
                      ),
                      const SizedBox(
                        height: common_bg_padding,
                      ),
                      TextFormField(
                        validator: (phoneNumber) {
                          if (phoneNumber != null && phoneNumber.length == 13) {
                            return null;
                          } else {
                            return "올바른 전화번호를 입력하세요.";
                          }
                        },
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          MaskedInputFormatter("000-0000-0000"),
                        ],
                        decoration: InputDecoration(
                          enabledBorder: inputBorder,
                          focusedBorder: inputBorder,
                        ),
                      ),
                      const SizedBox(
                        height: common_sm_padding,
                      ),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState != null) {
                            bool passed = _formKey.currentState!.validate();
                            if (passed) {
                              _verificationStatus = VerificationStatus.codeSent;
                            }
                          }
                          FocusScope.of(context).unfocus();
                        },
                        child: const Text('인증문자 발송'),
                      ),
                      const SizedBox(
                        height: common_bg_padding,
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity:
                            (_verificationStatus == VerificationStatus.none)
                                ? 0
                                : 1,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          height: getVerificationHeight(_verificationStatus),
                          child: TextFormField(
                            controller: _verifyNumberController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              MaskedInputFormatter("000000"),
                            ],
                            decoration: InputDecoration(
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: common_sm_padding,
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: getVerificationBtnHeight(_verificationStatus),
                        child: TextButton(
                          onPressed: () {
                            attemptVerify();
                          },
                          child: (_verificationStatus ==
                                  VerificationStatus.verifying)
                              ? const CircularProgressIndicator()
                              : const Text('인증하기'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            resizeToAvoidBottomInset: true,
          ),
        ),
      );
    });
  }

  void attemptVerify() async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });
    context.read<UserProvider>().setUserAuth(true);
    logger.d('current user state ${context.read<UserProvider>().userState}');
  }
}

double getVerificationHeight(VerificationStatus status) {
  switch (status) {
    case VerificationStatus.none:
      return 0;
    case VerificationStatus.codeSent:
    case VerificationStatus.verifying:
    case VerificationStatus.verificationDone:
      return 60;
  }
}

double getVerificationBtnHeight(VerificationStatus status) {
  switch (status) {
    case VerificationStatus.none:
      return 0;
    case VerificationStatus.codeSent:
    case VerificationStatus.verifying:
    case VerificationStatus.verificationDone:
      return 48;
  }
}

enum VerificationStatus { none, codeSent, verifying, verificationDone }
