// ScreengrabfileProtocol.swift
// Copyright (c) 2021 FastlaneTools

public protocol ScreengrabfileProtocol: AnyObject {
    /// Path to the root of your Android SDK installation, e.g. ~/tools/android-sdk-macosx
    var androidHome: String? { get }

    /// **DEPRECATED!** The Android build tools version to use, e.g. '23.0.2'
    var buildToolsVersion: String? { get }

    /// A list of locales which should be used
    var locales: [String] { get }

    /// Enabling this option will automatically clear previously generated screenshots before running screengrab
    var clearPreviousScreenshots: Bool { get }

    /// The directory where to store the screenshots
    var outputDirectory: String { get }

    /// Don't open the summary after running _screengrab_
    var skipOpenSummary: Bool { get }

    /// The package name of the app under test (e.g. com.yourcompany.yourapp)
    var appPackageName: String { get }

    /// The package name of the tests bundle (e.g. com.yourcompany.yourapp.test)
    var testsPackageName: String? { get }

    /// Only run tests in these Java packages
    var useTestsInPackages: [String]? { get }

    /// Only run tests in these Java classes
    var useTestsInClasses: [String]? { get }

    /// Additional launch arguments
    var launchArguments: [String]? { get }

    /// The fully qualified class name of your test instrumentation runner
    var testInstrumentationRunner: String { get }

    /// **DEPRECATED!** Return the device to this locale after running tests
    var endingLocale: String { get }

    /// **DEPRECATED!** Restarts the adb daemon using `adb root` to allow access to screenshots directories on device. Use if getting 'Permission denied' errors
    var useAdbRoot: Bool { get }

    /// The path to the APK for the app under test
    var appApkPath: String? { get }

    /// The path to the APK for the the tests bundle
    var testsApkPath: String? { get }

    /// Use the device or emulator with the given serial number or qualifier
    var specificDevice: String? { get }

    /// Type of device used for screenshots. Matches Google Play Types (phone, sevenInch, tenInch, tv, wear)
    var deviceType: String { get }

    /// Whether or not to exit Screengrab on test failure. Exiting on failure will not copy sceenshots to local machine nor open sceenshots summary
    var exitOnTestFailure: Bool { get }

    /// Enabling this option will automatically uninstall the application before running it
    var reinstallApp: Bool { get }

    /// Add timestamp suffix to screenshot filename
    var useTimestampSuffix: Bool { get }

    /// Configure the host used by adb to connect, allows running on remote devices farm
    var adbHost: String? { get }
}

public extension ScreengrabfileProtocol {
    var androidHome: String? { nil }
    var buildToolsVersion: String? { nil }
    var locales: [String] { ["en-US"] }
    var clearPreviousScreenshots: Bool { false }
    var outputDirectory: String { "fastlane/metadata/android" }
    var skipOpenSummary: Bool { false }
    var appPackageName: String { "" }
    var testsPackageName: String? { nil }
    var useTestsInPackages: [String]? { nil }
    var useTestsInClasses: [String]? { nil }
    var launchArguments: [String]? { nil }
    var testInstrumentationRunner: String { "androidx.test.runner.AndroidJUnitRunner" }
    var endingLocale: String { "en-US" }
    var useAdbRoot: Bool { false }
    var appApkPath: String? { nil }
    var testsApkPath: String? { nil }
    var specificDevice: String? { nil }
    var deviceType: String { "phone" }
    var exitOnTestFailure: Bool { true }
    var reinstallApp: Bool { false }
    var useTimestampSuffix: Bool { true }
    var adbHost: String? { nil }
}

// Please don't remove the lines below
// They are used to detect outdated files
// FastlaneRunnerAPIVersion [0.9.73]
