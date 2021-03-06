//
//  Constants.swift
//  VOLA
//
//  Created by Connie Nguyen on 6/6/17.
//  Copyright © 2017 Systers-Opensource. All rights reserved.
//

import Foundation

struct NotificationName {
    static let googleDidSignIn = Notification.Name("googleDidSignIn")
    static let availableEventsUpdated = Notification.Name("availableEventsUpdated")
    static let calendarEventsUpdated = Notification.Name("calendarEventsUpdated")
    static let userLogin = Notification.Name("userLogin")
    static let themeDidChange = Notification.Name("themeDidChange")
}

enum DefaultsKey: String {
    case shownIntro
    case selectedTheme
}

/// Constants for storyboard segues
enum Segue: String {
    case showLoginManual
    case showEditProfile
    case showSettings
    case showLoginsManager

    /// Storyboard segue identifier
    var identifier: String {
        return rawValue
    }
}

enum DictKeys: String {
    case fields
    case user
    case ok = "OK"
}

enum UserNumbers: UInt {
    case twiceImageIcon = 200
}

/// Constants for localized UI display text
enum UIDisplay: String {
    case yes = "yes-short.prompt.label"
    case no = "no-short.prompt.label"
    case defaultName = "default-name.label"
    case loginErrorTitle = "login-error.title.label"
    case cancel = "cancel.prompt.label"
    case editSettings = "edit-settings.prompt.label"
    case loginRequiredTitle = "login-required.title.label"
    case loginRequiredPrompt = "login-required.prompt.label"
    case loginPrompt = "login.prompt.label"

    var localized: String {
        return rawValue.localized
    }
}

/// Constants for requests to Facebook for data
struct FBRequest {
    static let graphPath = "me"
    static let graphParameters = "email, name"
    static let readPermissions = ["public_profile", "email"]
    static let imageURLFormat = "https://graph.facebook.com/%@/picture?type=large"
}

/// Constants for Anita Borg Institute URLs
struct ABIURL {
    // TODO: set to real URL values
    static let termsOfService = URL(string: "https://anitaborg.org")
    static let privacyPolicy = URL(string: "https://anitaborg.org")
}
