plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.hasneticlabs.prod_pin"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    flavorDimensions += "app"

    productFlavors {
        create("staging") {
            dimension = "app"
            applicationId = "com.hasneticlabs.prod_pin.staging"
            resValue("string", "app_name", "ProdPin (Staging)")
        }

        create("prod") {
            dimension = "app"
            applicationId = "com.hasneticlabs.prod_pin"
            resValue("string", "app_name", "ProdPin")
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.hasneticlabs.prod_pin"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

//    signingConfigs {
//        create("release") {
//            keyAlias = keystoreProperties["keyAlias"].toString()
//            keyPassword = keystoreProperties["keyPassword"].toString()
//            storeFile = file(keystoreProperties["storeFile"].toString())
//            storePassword = keystoreProperties["storePassword"].toString()
//        }
//    }

    buildTypes {
        release {
            ///TODO: make it release later
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
        }

        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
