# Socket Map

Flutter ile geliştirilmiş, harita tabanlı canlı araç takip uygulaması. Uygulama araç konumlarını `socket.io` üzerinden dinler, harita üzerinde marker olarak gösterir ve bağlantı kesildiğinde mock veri akışına geçerek ekranın çalışmaya devam etmesini sağlar.

## Özellikler

- `flutter_map` ve OpenStreetMap ile canlı araç konumu gösterimi
- Araç adına tıklayarak detay ekranına geçiş
- Detay ekranında araç konumu, hız bilgisi ve yakınlaştırılmış harita görünümü
- `Riverpod` ile state yönetimi
- `socket_io_client` ile gerçek zamanlı veri akışı
- Soket bağlantısı koptuğunda otomatik mock veri akışına geçiş

## Kullanılan Teknolojiler

- Flutter
- Dart
- Riverpod / Flutter Riverpod
- flutter_map
- socket_io_client
- flutter_svg
- logger

## Proje Yapısı

```text
lib/
  core/
    theme/
  features/
    vehicle_tracking/
      data/
        models/
        sources/
      domain/
        entities/
      presentation/
        providers/
        screens/
        view_models/
```

## Öne Çıkan Akış

1. Uygulama açıldığında `TrackingMapScreen` yüklenir.
2. `vehicleTrackingViewModelProvider`, soket bağlantısını başlatır ve takip isteği gönderir.
3. `TrackingRemoteDataSource`, `filo_verisi_akisi` event'ini dinleyerek araç listesini modele dönüştürür.
4. Haritadaki marker'a tıklanınca `TrackingDetailScreen` açılır.
5. Soket bağlantısı kesilirse uygulama `MockVehicleService` üzerinden simüle edilmiş araç verisi üretmeye devam eder.

## Kurulum

### Gereksinimler

- Flutter SDK
- Dart SDK
- Android Studio, VS Code veya benzeri bir Flutter geliştirme ortamı

### Bağımlılıkları yükleme

```bash
flutter pub get
```

### Uygulamayı çalıştırma

```bash
flutter run
```

## Soket Sunucusu Yapılandırması

Repo içinde gerçek IP adresi tutulmaz. Soket adresi ve cihaz adı `dart-define` üzerinden dışarıdan verilir.

Merkezi config:

- [lib/core/config/app_config.dart](/c:/Users/comertZz/Desktop/masa/flutter/socket_map/lib/core/config/app_config.dart)

Yerel geliştirme için önerilen akış:

1. [config/dart_defines.local.example.json](/c:/Users/comertZz/Desktop/masa/flutter/socket_map/config/dart_defines.local.example.json) dosyasını kopyalayıp `config/dart_defines.local.json` oluşturun.
2. Kendi soket adresinizi ve cihaz adınızı bu yerel dosyaya yazın.
3. Uygulamayı bu dosyayla çalıştırın.

Örnek `config/dart_defines.local.json`:

```json
{
  "SOCKET_URL": "http://192.168.x.x:3000",
  "TRACKING_DEVICE_NAME": "23BS857"
}
```

Çalıştırma:

```bash
flutter run --dart-define-from-file=config/dart_defines.local.json
```

Varsayılan fallback değerleri:

```text
SOCKET_URL=http://localhost:3000
TRACKING_DEVICE_NAME=demo-device
```

## Flavor Yapısı

Projede iki marka girişi bulunur:

- `Takibiz`: yeşil tema
- `BMW`: mavi tema

Flutter entry point dosyaları:

- [lib/main_takibiz.dart](/c:/Users/comertZz/Desktop/masa/flutter/socket_map/lib/main_takibiz.dart)
- [lib/main_bmw.dart](/c:/Users/comertZz/Desktop/masa/flutter/socket_map/lib/main_bmw.dart)

Ortak flavor tanımları:

- [lib/core/flavor/flavor_config.dart](/c:/Users/comertZz/Desktop/masa/flutter/socket_map/lib/core/flavor/flavor_config.dart)

Android flavor çalıştırma örnekleri:

```bash
flutter run --flavor takibiz -t lib/main_takibiz.dart --dart-define-from-file=config/dart_defines.local.json
flutter run --flavor bmw -t lib/main_bmw.dart --dart-define-from-file=config/dart_defines.local.json
```

İsterseniz genel giriş noktasını da kullanabilirsiniz:

```bash
flutter run --dart-define=APP_FLAVOR=takibiz --dart-define-from-file=config/dart_defines.local.json
flutter run --dart-define=APP_FLAVOR=bmw --dart-define-from-file=config/dart_defines.local.json
```

Beklenen temel event yapıları:

- İstemciden sunucuya: `takip_baslat`
- Sunucudan istemciye: `filo_verisi_akisi`

Beklenen örnek araç verisi:

```json
{
  "name": "23 ELZ 23",
  "lat": 38.67,
  "lng": 39.22,
  "hiz": 78
}
```

## Mock Veri Davranışı

Gerçek zamanlı soket bağlantısı kesildiğinde uygulama otomatik olarak mock veri üretir. Bu sayede:

- harita ekranı boş kalmaz
- marker hareketleri test edilebilir
- UI geliştirmeleri backend'e bağlı kalmadan sürdürülebilir

Mock veri kaynağı:

- [lib/features/vehicle_tracking/data/sources/mock_vehicle_data.dart](/c:/Users/comertZz/Desktop/masa/flutter/socket_map/lib/features/vehicle_tracking/data/sources/mock_vehicle_data.dart)

## Önemli Ekranlar

- Harita ekranı: [lib/features/vehicle_tracking/presentation/screens/tracking_map_screen.dart](/c:/Users/comertZz/Desktop/masa/flutter/socket_map/lib/features/vehicle_tracking/presentation/screens/tracking_map_screen.dart)
- Detay ekranı: [lib/features/vehicle_tracking/presentation/screens/tracking_detail_screen.dart](/c:/Users/comertZz/Desktop/masa/flutter/socket_map/lib/features/vehicle_tracking/presentation/screens/tracking_detail_screen.dart)

## Geliştirme Notları

- Harita katmanı OpenStreetMap tile servisini kullanır.
- Araç ikonları SVG asset olarak yüklenir.
- Tema ayarları `lib/core/theme/theme.dart` altında tutulur.
- Projede hem provider katmanında hem de view model tarafında takip akışı tanımları bulunuyor; geliştirme sırasında bu akışın tek yerde merkezileştirilmesi bakım kolaylığı sağlayabilir.

## Test

Varsayılan Flutter test altyapısı proje içinde mevcut:

```bash
flutter test
```

## Lisans

Bu repo için ayrıca bir lisans dosyası tanımlı değil.
