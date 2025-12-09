Nama : Abdul Rozzaq
Nim : 14022300051

# 🍅 Pomodoro Focus Timer App

Aplikasi Pomodoro Timer lintas platform (Android/iOS/Web) yang dibuat menggunakan Flutter. Proyek ini didesain untuk membantu pengguna mengatur sesi fokus dan istirahat dengan antarmuka yang bersih dan fitur kustomisasi tema.

## ✨ Fitur Utama

* **⏱️ Pomodoro Timer Intuitif:** Timer utama untuk fase Fokus, Istirahat Pendek (Short Break), dan Istirahat Panjang (Long Break).
* **🌙 Dukungan Tema (Dark/Light Mode):** Pengguna dapat beralih antara tema Terang dan Gelap untuk kenyamanan visual. Diimplementasikan menggunakan *State Management* **Provider**.
* **⚙️ Pengaturan Waktu Kustom:** Opsi untuk mengatur durasi spesifik (menit) untuk setiap fase Pomodoro, Istirahat Pendek, dan Istirahat Panjang.
* **🔔 Notifikasi Suara:** Memainkan suara notifikasi pada 5 detik terakhir sebelum transisi fase untuk memberi peringatan kepada pengguna.
* **🔄 State Management Efisien:** Menggunakan *package* `provider` untuk manajemen *state* tema dan logika timer yang terpusat.
* **📱 UI Responsif:** Tampilan yang bersih dan modern, dirancang untuk fokus pengguna.

## 🛠️ Teknologi yang Digunakan

* **Framework:** Flutter (Dart)
* **State Management:** `provider`
* **Audio/Notifikasi:** `audioplayers`

## 🚀 Cara Menjalankan Proyek

1.  **Clone Repositori:**
    ```bash
    git clone [Link Repositori Anda]
    cd [Nama Folder Proyek]
    ```

2.  **Dapatkan Dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Siapkan Assets:**
    Pastikan Anda memiliki file notifikasi (`bell.mp3`) di folder `assets/sounds/`.

4.  **Jalankan Aplikasi:**
    Karena titik masuk aplikasi (`main()`) berada di `lib/dashboard.dart`, gunakan target flag:
    ```bash
    flutter run -t lib/dashboard.dart
    ```

## 🖼️ Tampilan Aplikasi
![SS Aplikasi}(assets/picture/Gambar1.jpeg).
![SS Aplikasi}(assets/picture/Gambar2.jpeg).
