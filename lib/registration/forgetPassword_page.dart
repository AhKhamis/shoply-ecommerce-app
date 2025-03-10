import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'code_page.dart'; // Import Verify Code Page

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isEmailSelected = true;
  final FocusNode _inputFocusNode = FocusNode();
  String selectedCountryCode = '+1'; // Default to US
  String selectedCountryFlag = '🇺🇸'; // Default to US Flag

  @override
  void initState() {
    super.initState();
    _inputFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _inputFocusNode.dispose();
    super.dispose();
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          selectedCountryCode = '+${country.phoneCode}';
          selectedCountryFlag = country.flagEmoji;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Color.fromARGB(255, 37, 124, 167), Color(0xFF1A4C64)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds);
          },
          child: const Text(
            'Shoply',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const Spacer(),
            const Center(
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Enter your email or phone number, we will\nsend you a verification code',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),

            // Selection Toggle (Email or Mobile)
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 219, 228, 246),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isEmailSelected = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: isEmailSelected
                            ? const EdgeInsets.all(4.0)
                            : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: isEmailSelected
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'E-mail',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isEmailSelected = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: !isEmailSelected
                            ? const EdgeInsets.all(4.0)
                            : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: !isEmailSelected
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Mobile Number',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Input Field (Email or Mobile)
            isEmailSelected
                ? TextField(
                    focusNode: _inputFocusNode,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: _inputFocusNode.hasFocus
                            ? Colors.black
                            : Colors.grey,
                      ),
                      hintText: 'E-mail',
                      hintStyle:
                          const TextStyle(fontSize: 14, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  )
                : Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showCountryPicker(context);
                        },
                        child: Container(
                          width: 100,
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedCountryFlag,
                                  style: const TextStyle(fontSize: 20)),
                              const Icon(Icons.arrow_drop_down,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          focusNode: _inputFocusNode,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                            hintText: 'Phone Number',
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),

            const Spacer(),

            // Send Code Button (Navigate to Verify Code Page)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VerifyCodePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF267093),
                  minimumSize: const Size(double.infinity, 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Send Code',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
