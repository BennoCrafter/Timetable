import Foundation
import UIKit

struct Config {
    struct API {

    }

    struct Features {

    }

    struct UI {
        static let themeColor = "Blue"
        static let buttonCornerRadius: CGFloat = 8.0
        
        // Card UI Configurations
        static let cardWidth: CGFloat = UIScreen.main.bounds.width - 30
        static let cardHeight: CGFloat = 70
        static let cardSpacing: CGFloat = 5
        static let cardCornerRadius: CGFloat = 10
        static let startingYPosition: CGFloat = 90
        
        // Title UI Configurations
        static let firstLetterOfTitleUpper: Bool = true
        
    }
}
