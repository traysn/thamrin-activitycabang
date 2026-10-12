# Dashboard Aktivitas Cabang — Admin + Viewer Online

## Cara memasang (sekali saja)

1. Buat project di Supabase. Buka **SQL Editor**, jalankan isi `supabase.sql`.
2. Di **Authentication > Users**, buat satu akun admin (email/password). Salin **User UID** akun tersebut.
3. Di SQL Editor jalankan `insert into public.report_admins(user_id) values ('ISI-UID-ADMIN');` (ganti dengan UID asli).
4. Di Supabase **Project Settings > API** salin Project URL dan **anon / publishable key** ke `config.js`. **Jangan pernah menaruh service_role atau secret key** di file website.
5. Upload `index.html`, `admin.html`, `config.js` ke Vercel sebagai website statis (misalnya lewat repository GitHub). Pastikan file berada di root proyek.
6. Admin buka `https://alamat-website/admin.html`, login, upload Excel, klik **Proses & Publikasikan**.
7. Bos buka `https://alamat-website/` — tidak perlu login atau upload. Dashboard memperbarui data setiap 60 detik, atau tekan **Refresh**.

## Catatan penting

- Website belum otomatis online hanya dengan men-download ZIP: perlu setup Supabase dan deploy ke hosting.
- Setiap upload **mengganti seluruh dataset laporan sebelumnya** (bukan menambahkan). File Excel harus mencakup semua tanggal yang ingin ditampilkan.
- Data yang disimpan online **hanya jumlah aktivitas unik per cabang per tanggal**, bukan nama PIC, nomor telepon, atau baris mentah Excel.
- Valid jika Cabang, No Aktivitas, Tanggal Mulai Aktivitas, Kecamatan Aktivitas terisi. Duplikat = Cabang + Tanggal + No Aktivitas, dihitung sekali.
- Viewer publik: siapa pun yang memiliki link bisa melihat angka agregat. Jika laporan bersifat rahasia, perlu viewer login juga sebelum dipakai.
- Kolom 'Data Tidak Lengkap' dan 'Duplikat Dibuang' adalah statistik seluruh file yang diupload, bukan khusus rentang tanggal yang dipilih.
- Library Excel/PDF dan Supabase dimuat dari CDN, jadi butuh internet.
Test automatic deployment33
