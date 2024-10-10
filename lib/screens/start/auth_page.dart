import 'package:clone_radish_app/constants/common_size.dart';
import 'package:clone_radish_app/constants/shared_pref_keys.dart';
import 'package:clone_radish_app/states/user_provider.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final TextEditingController _codeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  String? _verificationId;
  int? _forceResendingToken;

  @override
  void dispose() {
    _codeController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

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
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
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
                            if (phoneNumber != null &&
                                phoneNumber.length == 13) {
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
                          onPressed: () async {
                            if (_verificationStatus ==
                                VerificationStatus.codeSending) return;
                            _getAddressOnSharedPreference();
                            if (_formKey.currentState != null) {
                              bool passed = _formKey.currentState!.validate();
                              if (passed) {
                                String phoneNum = _phoneNumberController.text;
                                phoneNum.replaceAll(' ', '');
                                phoneNum.replaceFirst('0', '');

                                FirebaseAuth auth = FirebaseAuth.instance;

                                setState(() {
                                  _verificationStatus =
                                      VerificationStatus.codeSending;
                                });
                                await auth.verifyPhoneNumber(
                                  phoneNumber: '+82$phoneNum',
                                  forceResendingToken: _forceResendingToken,
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) async {
                                    await auth.signInWithCredential(credential);
                                  },
                                  verificationFailed:
                                      (FirebaseAuthException error) {
                                    logger.e(error.message);
                                    setState(() {
                                      _verificationStatus =
                                          VerificationStatus.none;
                                    });
                                  },
                                  codeSent: (String verificationId,
                                      int? forceResendingToken) async {
                                    setState(() {
                                      _verificationId = verificationId;
                                      _forceResendingToken =
                                          forceResendingToken;
                                      _verificationStatus =
                                          VerificationStatus.codeSent;
                                    });
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                );
                              }
                            }
                            FocusScope.of(context).unfocus();
                          },
                          child: (_verificationStatus ==
                                  VerificationStatus.codeSending)
                              ? const SizedBox(
                                  height: 26,
                                  width: 26,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('인증문자 발송'),
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
                              controller: _codeController,
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
                                ? const SizedBox(
                                    width: 26,
                                    height: 26,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                : const Text('인증하기'),
                          ),
                        ),
                      ],
                    ),
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

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: _codeController.text);

      await FirebaseAuth.instance.signInWithCredential(credential);
      logger.d("성공된 인증!");
    } catch (e) {
      logger.e(e);
      SnackBar snackBar = const SnackBar(
        content: Text('잘못된 인증코드입니다.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });
    UserProvider();
  }

  _getAddressOnSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString(SHARED_ADDRESS) ?? "";
    double lat = prefs.getDouble(SHARED_LAT) ?? 0;
    double lon = prefs.getDouble(SHARED_LON) ?? 0;
    logger.d("Address from shared prefs - $address");
  }
}

double getVerificationHeight(VerificationStatus status) {
  switch (status) {
    case VerificationStatus.none:
      return 0;
    case VerificationStatus.codeSending:
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
    case VerificationStatus.codeSending:
    case VerificationStatus.codeSent:
    case VerificationStatus.verifying:
    case VerificationStatus.verificationDone:
      return 48;
  }
}

enum VerificationStatus {
  none,
  codeSending,
  codeSent,
  verifying,
  verificationDone
}
