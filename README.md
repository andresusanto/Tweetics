# Tweetics
![Tweetics](/../screenshoot/screenshoots/awal.png?raw=true "Tweetics analisa twitter")
Twitter Analytics adalah aplikasi berbasis web untuk menganalisa Lalu Lintas Bandung berdasarkan Tweet pengguna Twitter di kawasan Bandung.

## Prinsip yang digunakan

### Pattern Matching
_Pattern Matching_ (dalam Bahasa Indonesia, pencocokan pola) merupakan proses membandingkan sebuah pola terhadap lingkup yang lebih besar. Pattern Matching merupakan salah satu ilmu yang sering diterapkan dalam berbagai bidang. Pencocokan DNA, pencarian kata dalam sebuah dokumen (misalkan fitur Find pada Adobe Reader dan Microsoft Word), dan proses analisis citra (misalkan pemeriksaan sidik jari dan pencocokan wajah) adalah sebagian dari banyaknya penggunaan _Pattern Matching_. 

### Algoritma-algoritma yang digunakan
1. Algoritma Knuth Morris-Pratt
2. Algoritma Boyer-Moore
3. Regular Expression

### Analisis
Dalam menyelesaikan permasalahan yang telah dideskripsikan di atas, kami menerapkan cara-cara String Matching : Knuth Morris-Pratt, Boyer Moore dan Regular Expression. Selain itu kami menggunakan API dari Twitter dan framework twitter4j. Kami memulai pemecahan masalah dengan cara mengambil 100 twit yang sesuai dengan kata kunci pencarian (pencarian menggunakan salah satu dari metode String Matching yang sudah dijelaskan di atas), lalu mulai mengelompokan twit-twit tersebut ke dalam kategori-kategori berdasarkan ada/tidaknya kata-kata  yang dianggap mewakili kategori tersebut. Twit yang tidak masuk ke kategori manapun akan dimasukkan ke dalam kategori unknown.

Pada aplikasi yang kami buat, user dapat membuat preferensi-nya sendiri sehingga diharapkan hasil yang dinginkan oleh user bisa lebih sesuai. 


## Screen Shoot
Memulai Analisis Baru:

![Analisis Baru Twitter](/../screenshoot/screenshoots/analisabaru.png?raw=true "Analisis Baru Twitter")



Hasil Analisis dari Twitter (kategori dapat dilihat di sebelah Kiri):

![Hasil Analisis](/../screenshoot/screenshoots/hasilpencarian.png?raw=true "Hasil Analisis")



Pengaturan/Setting:

![Setting](/../screenshoot/screenshoots/setting.png?raw=true "Setting")


## Lisensi
Program ini dibuat dan didistribusikan dengan lisensi MIT.
