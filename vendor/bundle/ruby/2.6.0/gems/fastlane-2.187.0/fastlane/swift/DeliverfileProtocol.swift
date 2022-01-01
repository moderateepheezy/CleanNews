// DeliverfileProtocol.swift
// Copyright (c) 2021 FastlaneTools

public protocol DeliverfileProtocol: AnyObject {
    /// Path to your App Store Connect API Key JSON file (https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-json-file)
    var apiKeyPath: String? { get }

    /// Your App Store Connect API Key information (https://docs.fastlane.tools/app-store-connect-api/#use-return-value-and-pass-in-as-an-option)
    var apiKey: [String: Any]? { get }

    /// Your Apple ID Username
    var username: String? { get }

    /// The bundle identifier of your app
    var appIdentifier: String? { get }

    /// The version that should be edited or created
    var appVersion: String? { get }

    /// Path to your ipa file
    var ipa: String? { get }

    /// Path to your pkg file
    var pkg: String? { get }

    /// If set the given build number (already uploaded to iTC) will be used instead of the current built one
    var buildNumber: String? { get }

    /// The platform to use (optional)
    var platform: String { get }

    /// Modify live metadata, this option disables ipa upload and screenshot upload
    var editLive: Bool { get }

    /// Force usage of live version rather than edit version
    var useLiveVersion: Bool { get }

    /// Path to the folder containing the metadata files
    var metadataPath: String? { get }

    /// Path to the folder containing the screenshots
    var screenshotsPath: String? { get }

    /// Skip uploading an ipa or pkg to App Store Connect
    var skipBinaryUpload: Bool { get }

    /// Don't upload the screenshots
    var skipScreenshots: Bool { get }

    /// Don't upload the metadata (e.g. title, description). This will still upload screenshots
    var skipMetadata: Bool { get }

    /// Don’t create or update the app version that is being prepared for submission
    var skipAppVersionUpdate: Bool { get }

    /// Skip verification of HTML preview file
    var force: Bool { get }

    /// Clear all previously uploaded screenshots before uploading the new ones
    var overwriteScreenshots: Bool { get }

    /// Submit the new version for Review after uploading everything
    var submitForReview: Bool { get }

    /// Rejects the previously submitted build if it's in a state where it's possible
    var rejectIfPossible: Bool { get }

    /// Should the app be automatically released once it's approved? (Can not be used together with `auto_release_date`)
    var automaticRelease: Bool? { get }

    /// Date in milliseconds for automatically releasing on pending approval (Can not be used together with `automatic_release`)
    var autoReleaseDate: Int? { get }

    /// Enable the phased release feature of iTC
    var phasedRelease: Bool { get }

    /// Reset the summary rating when you release a new version of the application
    var resetRatings: Bool { get }

    /// The price tier of this application
    var priceTier: Int? { get }

    /// Path to the app rating's config
    var appRatingConfigPath: String? { get }

    /// Extra information for the submission (e.g. compliance specifications, IDFA settings)
    var submissionInformation: [String: Any]? { get }

    /// The ID of your App Store Connect team if you're in multiple teams
    var teamId: String? { get }

    /// The name of your App Store Connect team if you're in multiple teams
    var teamName: String? { get }

    /// The short ID of your Developer Portal team, if you're in multiple teams. Different from your iTC team ID!
    var devPortalTeamId: String? { get }

    /// The name of your Developer Portal team if you're in multiple teams
    var devPortalTeamName: String? { get }

    /// The provider short name to be used with the iTMSTransporter to identify your team. This value will override the automatically detected provider short name. To get provider short name run `pathToXcode.app/Contents/Applications/Application\ Loader.app/Contents/itms/bin/iTMSTransporter -m provider -u 'USERNAME' -p 'PASSWORD' -account_type itunes_connect -v off`. The short names of providers should be listed in the second column
    var itcProvider: String? { get }

    /// Run precheck before submitting to app review
    var runPrecheckBeforeSubmit: Bool { get }

    /// The default precheck rule level unless otherwise configured
    var precheckDefaultRuleLevel: String { get }

    /// **DEPRECATED!** Removed after the migration to the new App Store Connect API in June 2020 - An array of localized metadata items to upload individually by language so that errors can be identified. E.g. ['name', 'keywords', 'description']. Note: slow
    var individualMetadataItems: [String]? { get }

    /// **DEPRECATED!** Removed after the migration to the new App Store Connect API in June 2020 - Metadata: The path to the app icon
    var appIcon: String? { get }

    /// **DEPRECATED!** Removed after the migration to the new App Store Connect API in June 2020 - Metadata: The path to the Apple Watch app icon
    var appleWatchAppIcon: String? { get }

    /// Metadata: The copyright notice
    var copyright: String? { get }

    /// Metadata: The english name of the primary category (e.g. `Business`, `Books`)
    var primaryCategory: String? { get }

    /// Metadata: The english name of the secondary category (e.g. `Business`, `Books`)
    var secondaryCategory: String? { get }

    /// Metadata: The english name of the primary first sub category (e.g. `Educational`, `Puzzle`)
    var primaryFirstSubCategory: String? { get }

    /// Metadata: The english name of the primary second sub category (e.g. `Educational`, `Puzzle`)
    var primarySecondSubCategory: String? { get }

    /// Metadata: The english name of the secondary first sub category (e.g. `Educational`, `Puzzle`)
    var secondaryFirstSubCategory: String? { get }

    /// Metadata: The english name of the secondary second sub category (e.g. `Educational`, `Puzzle`)
    var secondarySecondSubCategory: String? { get }

    /// **DEPRECATED!** This is no longer used by App Store Connect - Metadata: A hash containing the trade representative contact information
    var tradeRepresentativeContactInformation: [String: Any]? { get }

    /// Metadata: A hash containing the review information
    var appReviewInformation: [String: Any]? { get }

    /// Metadata: Path to the app review attachment file
    var appReviewAttachmentFile: String? { get }

    /// Metadata: The localised app description
    var description: [String: Any]? { get }

    /// Metadata: The localised app name
    var name: [String: Any]? { get }

    /// Metadata: The localised app subtitle
    var subtitle: [String: Any]? { get }

    /// Metadata: An array of localised keywords
    var keywords: [String: Any]? { get }

    /// Metadata: An array of localised promotional texts
    var promotionalText: [String: Any]? { get }

    /// Metadata: Localised release notes for this version
    var releaseNotes: [String: Any]? { get }

    /// Metadata: Localised privacy url
    var privacyUrl: [String: Any]? { get }

    /// Metadata: Localised Apple TV privacy policy text
    var appleTvPrivacyPolicy: [String: Any]? { get }

    /// Metadata: Localised support url
    var supportUrl: [String: Any]? { get }

    /// Metadata: Localised marketing url
    var marketingUrl: [String: Any]? { get }

    /// Metadata: List of languages to activate
    var languages: [String]? { get }

    /// Ignore errors when invalid languages are found in metadata and screenshot directories
    var ignoreLanguageDirectoryValidation: Bool { get }

    /// Should precheck check in-app purchases?
    var precheckIncludeInAppPurchases: Bool { get }

    /// The (spaceship) app ID of the app you want to use/modify
    var app: Int? { get }
}

public extension DeliverfileProtocol {
    var apiKeyPath: String? { nil }
    var apiKey: [String: Any]? { nil }
    var username: String? { nil }
    var appIdentifier: String? { nil }
    var appVersion: String? { nil }
    var ipa: String? { nil }
    var pkg: String? { nil }
    var buildNumber: String? { nil }
    var platform: String { "ios" }
    var editLive: Bool { false }
    var useLiveVersion: Bool { false }
    var metadataPath: String? { nil }
    var screenshotsPath: String? { nil }
    var skipBinaryUpload: Bool { false }
    var skipScreenshots: Bool { false }
    var skipMetadata: Bool { false }
    var skipAppVersionUpdate: Bool { false }
    var force: Bool { false }
    var overwriteScreenshots: Bool { false }
    var submitForReview: Bool { false }
    var rejectIfPossible: Bool { false }
    var automaticRelease: Bool? { nil }
    var autoReleaseDate: Int? { nil }
    var phasedRelease: Bool { false }
    var resetRatings: Bool { false }
    var priceTier: Int? { nil }
    var appRatingConfigPath: String? { nil }
    var submissionInformation: [String: Any]? { nil }
    var teamId: String? { nil }
    var teamName: String? { nil }
    var devPortalTeamId: String? { nil }
    var devPortalTeamName: String? { nil }
    var itcProvider: String? { nil }
    var runPrecheckBeforeSubmit: Bool { true }
    var precheckDefaultRuleLevel: String { "warn" }
    var individualMetadataItems: [String]? { nil }
    var appIcon: String? { nil }
    var appleWatchAppIcon: String? { nil }
    var copyright: String? { nil }
    var primaryCategory: String? { nil }
    var secondaryCategory: String? { nil }
    var primaryFirstSubCategory: String? { nil }
    var primarySecondSubCategory: String? { nil }
    var secondaryFirstSubCategory: String? { nil }
    var secondarySecondSubCategory: String? { nil }
    var tradeRepresentativeContactInformation: [String: Any]? { nil }
    var appReviewInformation: [String: Any]? { nil }
    var appReviewAttachmentFile: String? { nil }
    var description: [String: Any]? { nil }
    var name: [String: Any]? { nil }
    var subtitle: [String: Any]? { nil }
    var keywords: [String: Any]? { nil }
    var promotionalText: [String: Any]? { nil }
    var releaseNotes: [String: Any]? { nil }
    var privacyUrl: [String: Any]? { nil }
    var appleTvPrivacyPolicy: [String: Any]? { nil }
    var supportUrl: [String: Any]? { nil }
    var marketingUrl: [String: Any]? { nil }
    var languages: [String]? { nil }
    var ignoreLanguageDirectoryValidation: Bool { false }
    var precheckIncludeInAppPurchases: Bool { true }
    var app: Int? { nil }
}

// Please don't remove the lines below
// They are used to detect outdated files
// FastlaneRunnerAPIVersion [0.9.75]
