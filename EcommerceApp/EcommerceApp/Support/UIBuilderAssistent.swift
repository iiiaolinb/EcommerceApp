import UIKit

func buildBlankButton(withTitle title: String, target: Any, selector: Selector?) -> UIButton {
    lazy var button: UIButton = {
        let button = UIButton(title: title, target: target, selector: selector)
        button.backgroundColor = Constants.Colors.orange
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints  = false
        
        return button
    }()
    
    return button
}
