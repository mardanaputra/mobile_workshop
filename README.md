# Course Data Manager (Course Explorer v2)

**Nama**: Suniaramana Mardana Putra  
**NIM**: 2455011006  
**Mata Kuliah**: Pemrograman Mobile  

---

## Deskripsi Aplikasi
Aplikasi manajemen data mata kuliah (*courses*) yang dibangun menggunakan Flutter. Aplikasi ini menerapkan **Clean Architecture** dan **Repository Pattern**, yang memungkinkan pengalihan sumber data (*data source*) antara **REST API** (JSONPlaceholder) dan **Supabase PostgreSQL** secara fleksibel hanya dengan mengubah satu baris konfigurasi.

---

## Arsitektur Aplikasi
Aplikasi dibagi menjadi beberapa lapisan (*layer*):
1. **UI Layer (`screens/`, `widgets/`)**: Menampilkan data dan merespons interaksi pengguna tanpa melakukan query atau request langsung ke database/API.
2. **State Management (`providers/`)**: `CourseProvider` mengelola state aplikasi reaktif menggunakan `ChangeNotifier`.
3. **Repository Layer (`repositories/`)**: `CourseRepository` bertindak sebagai jembatan/kontrak antara Provider dan DataSource.
4. **Data Layer (`services/`)**: 
   - `CourseDataSource`: Abstract class/interface kontrak data.
   - `CourseApiService`: Implementasi REST API.
   - `CourseSupabaseService`: Implementasi Supabase Database (CRUD).

---

## Backend & Tech Stack
- **Framework**: Flutter & Dart
- **State Management**: Provider
- **Backend Service**: Supabase (PostgreSQL Database & Realtime Client) / REST API
- **Database Schema**: Tabel `courses` (`id`, `code`, `title`, `credits`, `status`, `created_at`)

---

## Cara Menjalankan Project
1. Clone repository ini:
   ```bash
   git clone <URL_REPOSITORY_GITHUB_KAMU>