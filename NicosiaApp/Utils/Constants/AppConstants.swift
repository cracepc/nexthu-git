import Foundation

struct AppConstants {
    static let appName = "Nicosia App"
    static let appVersion = "1.0.0"
    static let baseURL = "https://api.example.com"
    
    struct UserDefaults {
        static let isFirstLaunch = "isFirstLaunch"
        static let userToken = "userToken"
        static let lastLoginDate = "lastLoginDate"
    }
    
    struct Notification {
        static let userDidLogin = "userDidLogin"
        static let userDidLogout = "userDidLogout"
    }
    
    struct Animation {
        static let defaultDuration = 0.3
        static let springDamping = 0.8
        static let springVelocity = 0.5
    }
}