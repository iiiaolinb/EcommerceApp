import UIKit

enum Constants {
    enum Font {
        static var textHeader1 = UIFont(name: "Mark Pro", size: 28)
        static var textHeader2 = UIFont(name: "Mark Pro", size: 20)
        static var textMain = UIFont(name: "Mark Pro", size: 18)
        static var textMedium = UIFont(name: "Mark Pro", size: 16)
        static var textSmall = UIFont(name: "Mark Pro", size: 12)
        static var textExtraSmall = UIFont(name: "Mark Pro", size: 9)
    }
    
    enum Colors {
        static let orange = UIColor(named: "Orange")
        static let darkBlue = UIColor(named: "DarkBlue")
        static let background = UIColor(named: "Background")
    }
    
    enum Sizes {
        static let screenHeight = UIScreen.main.bounds.height
        static let screenWidth = UIScreen.main.bounds.width
        static let imageInCartSizes = (width: 110, height: 90)
        static let buttonSizes = (width: screenWidth - 80, height: 50)
    }
    
    enum Default {
        static let badConnection =  "https://storage.yandexcloud.net/printio/assets/realistic_views/round_mouse_pad/detailed/02c38a14fea7f3aea392ec09c2e32e955ad35361.jpg?1593264253"
        static let grayHolder = "https://abrakadabra.fun/uploads/posts/2022-02/thumbs/1644218803_39-abrakadabra-fun-p-svetlo-serii-fon-tekstura-53.jpg"
        static let whiteHilder = "https://sm.ign.com/t/ign_in/video/t/the-ps3-is-too-high/the-ps3-is-too-high_h3m7.1200.jpg"
    }
}


