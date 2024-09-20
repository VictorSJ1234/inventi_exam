import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'random_string_provider.dart';

class HomepageUi extends StatelessWidget {
  const HomepageUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final randomStringProvider = Provider.of<RandomStringProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Image.asset(
            'assets/inventi_logos/inventi_logo_2.png',
            height: 40,
          ),
        ),
        backgroundColor: const Color(0xFFF1F7FF),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/menu_button.png',
            height: 50,
          ),
          onPressed: () {
            // not functional
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFF1F7FF),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  color: const Color(0xFFf1f7ff),
                  padding: const EdgeInsets.all(10),
                  child: randomStringProvider.isLoading
                      ? Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: const SizedBox.shrink()
                  )
                      : Text(
                    randomStringProvider.errorMessage != null
                        ? "Can't Fetch String"
                    :randomStringProvider.randomString,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await randomStringProvider.fetchRandomString();
                    },
                    child: randomStringProvider.isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                        : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.build, color: Colors.white),

                        SizedBox(height: 4),

                        Text(
                          'Click the button to generate a random string',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
