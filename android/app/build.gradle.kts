plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.tugas_kelompok_dpm"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13113456"

    compileOptions {
        // [FIX] Sintaks Kotlin menggunakan 'is' di depan
        isCoreLibraryDesugaringEnabled = true       
        sourceCompatibility = JavaVersion.VERSION_1_8 // [FIX] Disesuaikan ke 1.8 agar kompatibel
        targetCompatibility = JavaVersion.VERSION_1_8 // [FIX] Disesuaikan ke 1.8 agar kompatibel
    }

    kotlinOptions {
        // [FIX] Disesuaikan dengan sourceCompatibility
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.example.tugas_kelompok_dpm"
        // [FIX] minSdk disetel ke 21, syarat minimal untuk desugaring
        minSdk = 21
        targetSdk = flutter.targetSdkVersion
        versionCode = 1 // flutter.versionCode
        versionName = "1.0" // flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // [FIX] Sintaks Kotlin menggunakan kurung biasa ()
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
