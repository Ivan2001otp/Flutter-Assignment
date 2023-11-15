import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var _size = MediaQuery.of(context).size;

    return Expanded(
      flex: 3,
      child: Container(
        width: _size.width,
        height: _size.height / 2,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.darken),
                fit: BoxFit.cover,
                image: AssetImage('assets/images/green_top_view.jpg'))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Unsplash created by Underdogz Digital ',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 228, 228, 228),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(style: BorderStyle.none)),
                      contentPadding: EdgeInsets.all(6),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 131, 131, 131),
                      ),
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 131, 131, 131)),
                      hintText: 'Eg: skies , flowers , etc..')),
            )
          ],
        ),
      ),
    );
  }
}
