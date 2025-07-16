import 'package:flutter/material.dart';
import 'berita_1.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(body: ListView(children: [HomepagePendaftarFix()])),
    );
  }
}

class HomepagePendaftarFix extends StatelessWidget {
  const HomepagePendaftarFix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 390,
              height: 1622,
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 21,
                    top: 766,
                    child: Text(
                      'Berita Terkini',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'League Spartan',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 131,
                    top: 1105,
                    child: Text(
                      '4 jam lalu',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.34),
                        fontSize: 12,
                        fontFamily: 'Bree Serif',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 132,
                    top: 1054,
                    child: SizedBox(
                      width: 229,
                      height: 59,
                      child: Text(
                        'Pengurus MPI Jakarta Dikukuhkan untuk Siapkan Atlet Hadapi PON 2028',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Bree Serif',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 17,
                    top: 1034,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/img/amboyoy.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 133,
                    top: 1193,
                    child: SizedBox(
                      width: 229,
                      height: 59,
                      child: Text(
                        'Wakili Indonesia, Tata Juliastrid Raih Gelar Miss Cosmo 2024 ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Bree Serif',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 132,
                    top: 1244,
                    child: Text(
                      '13 jam lalu',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.34),
                        fontSize: 12,
                        fontFamily: 'Bree Serif',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 17,
                    top: 1172,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/img/amboyoy.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 1147,
                    child: Container(
                      width: 364,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFF6380EA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 1285,
                    child: Container(
                      width: 364,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFF6380EA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 11,
                    top: 1009,
                    child: Container(
                      width: 364,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFF6380EA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 9,
                    top: 1285,
                    child: Container(
                      width: 364,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFF6380EA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 46,
                    top: 1422,
                    child: Text(
                      'Ikuti Kami di',
                      style: TextStyle(
                        color: const Color(0xFF224699),
                        fontSize: 16,
                        fontFamily: 'League Spartan',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 1358,
                    child: SizedBox(width: 300, height: 18),
                  ),
                  Positioned(
                    left: 33,
                    top: 1310,
                    child: SizedBox(
                      width: 100,
                      height: 20,
                      child: Text(
                        'Site Map',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 15,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 1340,
                    child: SizedBox(
                      width: 115,
                      height: 18,
                      child: Text(
                        'Berita',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 1358,
                    child: SizedBox(
                      width: 115,
                      height: 18,
                      child: Text(
                        'Publishing',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 1376,
                    child: SizedBox(
                      width: 115,
                      height: 18,
                      child: Text(
                        'Tentang Kami',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 148,
                    top: 1376,
                    child: SizedBox(
                      width: 115,
                      height: 18,
                      child: Text(
                        'Beriklan',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 148,
                    top: 1358,
                    child: SizedBox(
                      width: 115,
                      height: 18,
                      child: Text(
                        'Kontak',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 148,
                    top: 1340,
                    child: SizedBox(
                      width: 115,
                      height: 18,
                      child: Text(
                        'Karir',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 263,
                    top: 1340,
                    child: SizedBox(
                      width: 115,
                      height: 18,
                      child: Text(
                        'Pedoman Media',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 263,
                    top: 1358,
                    child: SizedBox(
                      width: 115,
                      height: 18,
                      child: Text(
                        'Siber',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 1461,
                    child: Container(
                      width: 363,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFF6380EA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 1405,
                    child: Container(
                      width: 363,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFF6380EA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 28,
                    top: 614,
                    child: Container(
                      width: 334,
                      height: 135,
                      decoration: ShapeDecoration(
                        shadows: [
                          BoxShadow(
                            color: const Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: const Color(0xFF224699),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 638,
                    child: Container(
                      width: 320,
                      height: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),

                        image: DecorationImage(
                          image: AssetImage('assets/img/iklan1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 340.05,
                    top: 615,
                    child: Container(
                      width: 11.45,
                      height: 12,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Stack(),
                    ),
                  ),
                  Positioned(
                    left: 338,
                    top: 618,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/highlight_off.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 165,
                    top: 615,
                    child: SizedBox(
                      width: 57.10,
                      height: 13.50,
                      child: Text(
                        'Advertising',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 10,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 324.78,
                    top: 615,
                    child: Container(
                      width: 11.45,
                      height: 12,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Stack(),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 133,
                    child: Container(
                      width: 169,
                      height: 25,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F2FF),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFF224699),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 26,
                    top: 131,
                    child: SizedBox(
                      width: 156,
                      height: 26,
                      child: Text(
                        'National',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 16,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w700,
                          height: 1.78,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 203,
                    top: 133,
                    child: Container(
                      width: 167,
                      height: 25,
                      decoration: ShapeDecoration(
                        color: const Color.fromARGB(255, 60, 45, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 208,
                    top: 131,
                    child: SizedBox(
                      width: 155,
                      height: 26,
                      child: Text(
                        'International',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w600,
                          height: 1.78,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 58,
                    top: 1556,
                    child: SizedBox(
                      width: 300,
                      height: 18,
                      child: Text(
                        'mikirluk@mikirindonesia.com',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 26,
                    top: 1599,
                    child: SizedBox(
                      width: 341,
                      height: 20,
                      child: Text(
                        'Copyright @ 2024 Mikir Group - mikirluk.com . All Rights Reserverd',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 11,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 32,
                    top: 1492,
                    child: SizedBox(
                      width: 100,
                      height: 20,
                      child: Text(
                        'Informasi',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 15,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 58,
                    top: 1520,
                    child: SizedBox(
                      width: 300,
                      height: 18,
                      child: Text(
                        '0812-7429-0160',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 58,
                    top: 1538,
                    child: SizedBox(
                      width: 300,
                      height: 18,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'mik',
                              style: TextStyle(
                                color: const Color(0xFF224699),
                                fontSize: 12,
                                fontFamily: 'League Spartan',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'irluk@mikirindonesia.com',
                              style: TextStyle(
                                color: const Color(0xFF224699),
                                fontSize: 12,
                                fontFamily: 'League Spartan',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 1558,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/local_post_office.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 1540,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/local_post_office.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 1522,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/local_phone.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 190,
                    top: 1418,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/FACEBOOK ICON.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 222,
                    top: 1418,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/WA ICON.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 254,
                    top: 1418,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/X ICON.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 285,
                    top: 1418,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/IG ICON.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BeritaNasionalGayaHidup(),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          left: 21,
                          top: 224,
                          child: Container(
                            width: 349,
                            height: 358,
                            decoration: ShapeDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: const Color(0xFFAAB7D3),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 27,
                          top: 232,
                          child: Container(
                            width: 337,
                            height: 164,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: AssetImage('assets/img/brt/berita1.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 26,
                          top: 399.16,
                          child: SizedBox(
                            width: 340,
                            height: 86.10,
                            child: Text(
                              'Polisi Indonesia Menahan 12\nTersangka dalam Kasus Perdagangan Bayi',
                              style: TextStyle(
                                color: const Color(0xFF224699),
                                fontSize: 20,
                                fontFamily: 'Bree Serif',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 26,
                          top: 493,
                          child: SizedBox(
                            width: 70,
                            height: 17.41,
                            child: Text(
                              '16/07/25',
                              style: TextStyle(
                                color: const Color(0xFF224699),
                                fontSize: 15,
                                fontFamily: 'Alumni Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 96,
                          top: 503.64,
                          child: Container(
                            width: 264,
                            height: 1, // tambahkan tinggi agar kelihatan
                            color: const Color(0xFF224699),
                          ),
                        ),
                        Positioned(
                          left: 26,
                          top: 518.15,
                          child: SizedBox(
                            width: 334,
                            height: 48.37,
                            child: Text(
                              'Pihak berwenang telah menahan 12 tersangka setelah mengungkap terduga sindikat perdagangan bayi.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: const Color(0xFF224699),
                                fontSize: 12,
                                fontFamily: 'AR One Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 21,
                    top: 180,
                    child: Container(
                      width: 56.04,
                      height: 26.04,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F2FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 23.55,
                    top: 182.08,
                    child: SizedBox(
                      width: 50.95,
                      height: 20.83,
                      child: Text(
                        'Beranda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 94.88,
                    top: 183.12,
                    child: SizedBox(
                      width: 50.95,
                      height: 20.83,
                      child: Text(
                        'Olahraga',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 166.20,
                    top: 183.12,
                    child: SizedBox(
                      width: 50.95,
                      height: 20.83,
                      child: Text(
                        'Politik',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 237.53,
                    top: 183.12,
                    child: SizedBox(
                      width: 50.95,
                      height: 20.83,
                      child: Text(
                        'Hiburan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    //beranda ni
                    left: 308.86,
                    top: 173.12,
                    child: SizedBox(
                      width: 50.95,
                      height: 40.83,
                      child: Text(
                        'Gaya Hidup',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -11,
                    top: 784,
                    child: Container(
                      width: 414,
                      height: 211,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 25,
                            top: 195,
                            child: Text(
                              '1 jam lalu',
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.34),
                                fontSize: 12,
                                fontFamily: 'Bree Serif',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 25,
                            top: 141,
                            child: SizedBox(
                              width: 160,
                              height: 53,
                              child: Text(
                                'Film Animasi Deep Sea: Petualangan Fantasi di Dasar Laut',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Bree Serif',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 228,
                            top: 195,
                            child: Text(
                              '1 jam lalu',
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.34),
                                fontSize: 12,
                                fontFamily: 'Bree Serif',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 227,
                            top: 141,
                            child: SizedBox(
                              width: 160,
                              height: 53,
                              child: Text(
                                'Animasi Stop-Motion, Teman atau Lawan Bagi Animator?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Bree Serif',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 25,
                            top: 18,
                            child: Container(
                              width: 162,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage('assets/img/amboyoy.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 227,
                            top: 18,
                            child: Container(
                              width: 162,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage('assets/img/amboyoy.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 320,
                    top: 8,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/wifi.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 62,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/3_bar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 345,
                    top: 64,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/search.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 65,
                    top: 37,
                    child: Container(
                      width: 262,
                      height: 88,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/Logo-mikirluk.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 21,
                    top: 8,
                    child: SizedBox(
                      width: 76,
                      height: 29,
                      child: Text(
                        '04.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
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
    );
  }
}
