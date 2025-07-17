import 'package:flutter/material.dart';
import 'main.dart';

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
      home: Scaffold(body: ListView(children: [BeritaNasionalF1()])),
    );
  }
}

class BeritaNasionalF1 extends StatelessWidget {
  const BeritaNasionalF1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 390,
              height: 2572,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    top: 225,
                    child: Container(
                      width: 349,
                      height: 198,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/img/brt/berita5.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 136,
                    child: SizedBox(
                      width: 329,
                      height: 80,
                      child: Text(
                        'Oliver Rowland kunci gelar juara dunia Formula E 2024/25 lebih awal',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Bree Serif',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 490,
                    child: SizedBox(
                      width: 350,
                      child: Text(
                        'Jakarta - Pembalap Nissan Oliver Rowland memastikan diri menjadi juara dunia Formula E musim ke-11 2024/25 setelah finis di posisi keempat pada balapan putaran ke-14 yang digelar di Sirkuit Tempelhof, Berlin, Minggu (13/7) waktu setempat. \n\n“Saya berharap akhir pekan ini bisa menjadi penentu gelar, tapi setelah hasil kemarin dan pagi ini, saya mulai ragu. Saat balapan, saya tidak tahu posisi Pascal, tapi ketika insinyur memberi tahu saya bahwa posisi empat sudah cukup, saya mulai sadar situasinya,” kata Rowland dikutip dari laman resmi Formula E, Senin. \n\nGelar tersebut diraih Rowland dengan dua seri tersisa musim ini, menjadikannya pembalap kesepuluh yang menjuarai Formula E sejak kejuaraan mobil listrik itu digelar pertama kali pada 2014. \n\nRowland tampil dominan sepanjang musim 2024/25 dengan meraih empat kemenangan dan tujuh podium. Ia berhasil menjaga keunggulan poin atas rival terdekatnya, pembalap TAG Heuer Porsche Pascal Wehrlein, yang hanya mampu finis di posisi ke-16 pada balapan di Berlin setelah strategi Attack Mode tidak berjalan sesuai rencana. \n\nPembalap asal Inggris itu memulai balapan dari posisi kedelapan akibat penalti turun lima posisi karena insiden dengan Stoffel Vandoorne (Maserati MSG Racing) di balapan sebelumnya. \n\nNamun, ia mampu tampil konsisten dan mengamankan posisi keempat untuk memastikan gelar juara dunia. \n\nPerjalanan Rowland menuju gelar juara tidak selalu mulus. Ia sempat kehilangan peluang menang akibat penalti penggunaan daya berlebih di Sao Paulo, serta mengalami kesulitan saat harus start dari belakang di Miami. Ia juga mengalami gagal finis pada putaran ke-13. \n\nRowland pertama kali tampil di Formula E sebagai pembalap pengganti Mahindra Racing pada musim kedua di Punta del Este. Ia kemudian membela Nissan sejak musim kelima sebelum kembali ke Mahindra di musim kedelapan. Namun, kerja sama itu berakhir lebih cepat dan sempat membuatnya nyaris kehilangan tempat di Formula E. \n\n“Saya mengambil risiko besar dengan meninggalkan kontrak saat itu. Saya tidak tidur selama dua atau tiga minggu. Tapi akhirnya saya kembali ke Nissan, dan menjadi juara bersama tim yang memberi saya awal karir di Formula E adalah sesuatu yang sangat emosional,” ujar Rowland. \n\nDengan dua putaran tersisa yang akan digelar di London akhir bulan ini, Rowland berpeluang mempersembahkan gelar juara tim dan konstruktor untuk Nissan. Tahun lalu, ia juga berhasil memenangi salah satu balapan di sirkuit tersebut. \n\n“Melihat kembali ke masa pertama saya di Formula E, saya tidak tahu apa-apa dan merasa sangat berat. Tapi melihat nama-nama juara sebelumnya, bisa berada di jajaran itu sebagai juara dunia adalah pencapaian luar biasa,” katanya.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w300,
                          height: 1.33,
                          letterSpacing: 1.20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 435,
                    child: SizedBox(
                      width: 350,
                      height: 40,
                      child: Text(
                        'Gambar Pembalap tim Nissan Oliver Rowland melaju saat kualifikasi seri ke-11 balapan Formula E World Championship 2025 di Jakarta International E-Prix Circuit (JIEC). (sumber: Antara).',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 193,
                    child: SizedBox(
                      width: 157,
                      height: 13,
                      child: Text(
                        '14 Juli 2025 09:26 WIB',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 10,
                          fontFamily: 'AR One Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 1600,
                    child: Text(
                      'Editor: Fofo',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: const Color(0xFF224699),
                        fontSize: 14,
                        fontFamily: 'League Spartan',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 17,
                    top: 1630.50,
                    child: Container(
                      width: 351,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF224699),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFF224699),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 1641,
                    child: Text(
                      'Tags:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF224699),
                        fontSize: 14,
                        fontFamily: 'AR One Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 61,
                    top: 1641,
                    child: SizedBox(
                      width: 76,
                      child: Text(
                        '#Hiburan',
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 14,
                          fontFamily: 'AR One Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 142,
                    top: 1641,
                    child: SizedBox(
                      width: 91,
                      height: 19,
                      child: Text(
                        '#Festival',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 14,
                          fontFamily: 'AR One Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 61,
                    top: 1666,
                    child: Text(
                      '#Ekraf',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF224699),
                        fontSize: 14,
                        fontFamily: 'AR One Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 273,
                    top: 1641,
                    child: Text(
                      '#Indonesia',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF224699),
                        fontSize: 14,
                        fontFamily: 'AR One Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 157,
                    top: 1666,
                    child: Text(
                      '#Femmevolution',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF224699),
                        fontSize: 14,
                        fontFamily: 'AR One Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    top: 1696,
                    child: Text(
                      'Bagikan',
                      style: TextStyle(
                        color: const Color(0xFF224699),
                        fontSize: 16,
                        fontFamily: 'League Spartan',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 152,
                    top: 1692,
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
                    left: 107,
                    top: 1692,
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
                    left: 242,
                    top: 1692,
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
                  Positioned(
                    left: 197,
                    top: 1692,
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
                    left: 28,
                    top: 2227,
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
                    top: 2250,
                    child: Container(
                      width: 320,
                      height: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),

                        image: DecorationImage(
                          image: AssetImage('assets/img/iklan2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 338,
                    top: 2229,
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
                    top: 2227,
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
                    left: 18,
                    top: 1766,
                    child: Container(
                      width: 355,
                      height: 416,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF224699),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: const Color(0xFF0075CC),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 1977,
                    child: SizedBox(
                      width: 325,
                      height: 20,
                      child: Opacity(
                        opacity: 0.50,
                        child: Text(
                          'Berkomentarlah secara bijaksana dan bertanggung jawab. Komentar sepenuhnya menjadi tanggung jawab komentator seperti diatur dalam UU ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontFamily: 'League Spartan',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 2042,
                    child: SizedBox(
                      width: 325,
                      height: 20,
                      child: Text(
                        'Belum ada komentar. Jadilah yang pertama untuk memberikan komentar!',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 42,
                    top: 1778,
                    child: SizedBox(
                      width: 100,
                      height: 22.65,
                      child: Text(
                        'Beri Komentar',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 307,
                    top: 2001,
                    child: SizedBox(
                      width: 51,
                      height: 15.70,
                      child: Text(
                        'Kirim',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF224699),
                          fontSize: 10,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 1810,
                    child: Container(
                      width: 325,
                      height: 158,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 53,
                    top: 1832,
                    child: Opacity(
                      opacity: 0.50,
                      child: Text(
                        'Tulis Tanggapan Anda....',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 2029,
                    child: Container(
                      width: 325,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 64,
                    top: 39,
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
                    left: 347,
                    top: 6,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/batere.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 307,
                    top: 6,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/wifi1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 19,
                    top: 66,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomepagePendaftarFix(),
                          ),
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/img/back.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 4,
                    top: 7,
                    child: SizedBox(
                      width: 76,
                      height: 21,
                      child: Text(
                        '04.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Bree Serif',
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
