import UIKit
import Combine

func buildNavigationBarButton(imageName: String, color: UIColor, target: Any?, action: Selector, withBadge count: Int?) -> UIBarButtonItem {
    
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: imageName), for: .normal)
    button.backgroundColor = color
    button.layer.cornerRadius = 7
    button.clipsToBounds = true
    button.addTarget(target, action: action, for: .touchUpInside)
    
    NSLayoutConstraint.activate([
        button.widthAnchor.constraint(equalToConstant: 30),
        button.heightAnchor.constraint(equalToConstant: 30)
    ])
    
    let barItem = UIBarButtonItem(customView: button)
    return barItem
}

func buildBarButtonItemWithTitle(title: String, color: UIColor, imageName: String, target: Any?, selector: Selector) -> UIBarButtonItem {
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal

        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(button)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -40),
            titleLabel.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: stack.topAnchor),
            button.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "\(title)  "
        label.font = Constants.Font.textSmall
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: imageName), for: .normal)
        button.backgroundColor = color
        button.tintColor = .black
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let barItem = UIBarButtonItem(customView: stack)
    barItem.width = 150
    
    return barItem
}

func buildNavigationTitleWithImage() -> UIView {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Zihuatanejo, Gro"
        titleLabel.font = Constants.Font.textSmall
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    lazy var imageLeft: UIImageView = {
        let imageLeft = UIImageView(image: UIImage(named: "LocationOrange"))
        imageLeft.translatesAutoresizingMaskIntoConstraints = false
        return imageLeft
    }()
    
    lazy var imageRight: UIImageView = {
        let imageRight = UIImageView(image: UIImage(named: "ArrowDown"))
        imageRight.translatesAutoresizingMaskIntoConstraints = false
        return imageRight
    }()
    
    lazy var titleStack: UIStackView = {
        let titleView = UIStackView(arrangedSubviews: [imageLeft, titleLabel, imageRight])
        titleView.axis = .horizontal
        titleView.spacing = 7.0
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageLeft.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            imageLeft.topAnchor.constraint(equalTo: titleView.topAnchor),
            imageLeft.widthAnchor.constraint(equalToConstant: 10),
            imageLeft.heightAnchor.constraint(equalToConstant: 15),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageLeft.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            imageRight.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            imageRight.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 7),
            imageRight.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -3),
            imageRight.widthAnchor.constraint(equalToConstant: 10),
            imageRight.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        return titleView
    }()
    
    return titleStack
}
