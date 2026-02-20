# Tutorial 2 Game Development 2025/2026 Genap

## Playtest
### 1. Apa saja pesan log yang dicetak pada panel Output?
Ketika objek landasan dibuat dan digerakkan ke atas, hingga pesawat hampir menyentuh batas atas area permainan, panel output menampilkan dua pesan log:
- `Platform initialized` ->  muncul saat _scene_ dimulai, menandakan bahwa objek `PlatformBlue` sudah berhasil di-_load_ dan _script_ `PlatformBlue.gd` telah dijalankan.
- `Reached objective!` -> muncul ketika pesawat masuk atau bersentuhan dengan area tertentu yang merupakan _ObjectiveArea_ yang mendeteksi _collision_/_overlap_

### 2. Coba gerakkan landasan ke batas area bawah, lalu gerakkan kembali ke atas hingga hampir menyentuh batas atas. Apa saja pesan log yang dicetak pada panel Output?
Log yang muncul adalah `Reached objective!`. Pesan ini muncul berulang kali karena setiap kali pesawat kembali masuk ke area _ObjectiveArea_, sistem akan memicu event (signal) yang mencetak pesan tersebut ke panel output.

### 3. Buka scene MainLevel dengan tampilan workspace 2D. Apakah lokasi scene ObjectiveArea memiliki kaitan dengan pesan log yang dicetak pada panel Output pada percobaan sebelumnya?
Ya, lokasi scene _ObjectiveArea_ memiliki kaitan dengan pesan log yang muncul. _ObjectiveArea_ berada di bagian atas area permainan, sehingga ketika pesawat bergerak naik dan memasuki area tersebut, sistem akan mendeteksi _collision_/_overlap_ dan memicu signal (`body_entered`) yang kemudian mencetak pesan `Reached objective!` pada panel Output.

## Memanipulasi Node dan Scene
### 1. Scene BlueShip dan StonePlatform sama-sama memiliki sebuah child node bertipe Sprite2D. Apa fungsi dari node bertipe Sprite2D?
Node bertipe `Sprite2D` berfungsi untuk menampilkan gambar pada _scene_ 2D. Pada _scene_ `BlueShip` dan `StonePlatform`, `Sprite2D` digunakan untuk merepresentasikan tampilan visual dari objek tersebut, seperti gambar pesawat dan gambar landasan.

### 2. Root node dari scene BlueShip dan StonePlatform menggunakan tipe yang berbeda. BlueShip menggunakan tipe RigidBody2D, sedangkan StonePlatform menggunakan tipe StaticBody2D. Apa perbedaan dari masing-masing tipe node?
- `RigidBody2D` merupakan _node physics_ yang pergerakannya dikontrol oleh _engine physics_ dalam artian objek bisa bergerak sesuai hukum fisika. Objek ini bisa jatuh karena gravitasi, bisa terdorong, bisa terpental saat bertabrakan. Pada `BlueShip`, tipe ini digunakan agar pesawat bisa ikut bergerak dan terdorong saat berinteraksi/kena landasan.

- Sedangkan `StaticBody2D` adalah _node physics_ yang tidak bergerak dan tidak terpengaruh hukum fisika. Objek ini tidak jatuh, tidak terdorong, dan biasanya digunakan sebagai objek diam seperti lantai, dinding, atau platform. Pada `StonePlatform`, tipe ini digunakan karena platform berfungsi sebagai landasan yang diam dan menjadi tempat pesawat bertabrakan.

### 3. Ubah nilai atribut Mass pada tipe RigidBody2D secara bebas di scene BlueShip, lalu coba jalankan scene MainLevel. Apa yang terjadi?
Pada _scene_ ini, perubahan nilai _mass_ tidak memberikan pengaruh yang signifikan terhadap gerakan pesawat. Hal ini karena pergerakan pesawat terutama dipengaruhi oleh gravitasi dan interaksi _collision_ dengan platform. Dalam fisika, percepatan akibat gravitasi tidak bergantung pada massa, sehingga meskipun nilai mass diubah, gerakan jatuh pesawat tetap relatif sama. Perbedaan massa akan lebih terlihat apabila diberikan gaya atau percepatan tambahan secara langsung pada objek.

### 4. Ubah nilai atribut Disabled milik node CollisionShape2D pada scene StonePlatform, lalu coba jalankan scene MainLevel. Apa yang terjadi?
Ketika atribut `Disabled` pada node `CollisionShape2D` diubah menjadi aktif, _collision_ pada `StonePlatform` dinonaktifkan. Akibatnya, platform tidak lagi berfungsi sebagai penghalang, sehingga pesawat menembus platform dan jatuh karena gravitasi. Hal ini terjadi karena _physics engine_ tidak mendeteksi adanya bentuk _collision_ pada platform tersebut.

### 5. Pada scene MainLevel, coba manipulasi atribut Position, Rotation, dan Scale milik node BlueShip secara bebas. Apa yang terjadi pada visualisasi BlueShip di Viewport?
- **Position** : Jika Position dimanipulasi, BlueShip akan berpindah tempat sesuai nilai X dan Y yang diubah, dimana X menggeser ke kiri/kanan, Y menggeser ke atas/bawah.
- **Rotation** : Jika Rotation dimanipulasi BlueShip akan berputar sesuai nilai derajat yang diberikan. Misalnya 90° -> maka pesawat akan menghadap ke samping.
- **Scale** : Jika Scale dimanipulasi, maka ukuran pesawat akan membesar atau mengecil sesuai nilai yang dimasukkan.

![Screenshot 1](https://github.com/user-attachments/assets/4378b471-57c0-45b2-a512-0ab937e8cc58)
![Screenshot 2](https://github.com/user-attachments/assets/13a34895-f44a-4cc7-a577-ebf108337d3f)
![Screenshot 3](https://github.com/user-attachments/assets/95412ec4-67a4-4472-a768-45dc9bddf4e9)

> Note : Perubahan Scale pada `RigidBody2D` terlihat di editor, tetapi saat Run dijalankan perubahan tersebut tidak berpengaruh karena RigidBody2D dikontrol oleh _physics engine_. Godot menyarankan untuk mengubah ukuran pada node anak seperti `Sprite2D` atau `CollisionShape2D` agar perubahan ukuran dapat diterapkan dengan benar saat game berjalan.

### 6. Pada scene MainLevel, perhatikan nilai atribut Position node PlatformBlue, StonePlatform, dan StonePlatform2. Mengapa nilai Position node StonePlatform dan StonePlatform2 tidak sesuai dengan posisinya di dalam scene (menurut Inspector) namun visualisasinya berada di posisi yang tepat?
Nilai `Position` pada `StonePlatform` dan `StonePlatform2` terlihat tidak sesuai dengan posisi visualnya karena kedua node tersebut merupakan _child_ dari PlatformBlue. Dimana titik (0,0) mereka dihitung relatif terhadap posisi `PlatformBlue`, bukan terhadap koordinat global di dalam _scene_. Nilai Position yang ditampilkan di _Inspector_ adalah posisi lokal terhadap _parent_-nya, sedangkan posisi yang terlihat di _Viewport_ merupakan hasil kombinasi _transform_ dari _parent_ dan node itu sendiri (_global position_). Oleh karena itu, meskipun nilai `Position` terlihat berbeda, secara visual objek tetap berada di posisi yang benar.
