import UIKit

final class HeaderView: UICollectionReusableView {
    private(set) lazy var label = UILabel()
    
    lazy var seeMoreButton: UIButton = {
        let button = UIButton(title: "See more", target: self, selector: nil)
        button.setTitleColor(Constants.Colors.orange, for: .normal)
        button.titleLabel?.font = Constants.Font.textSmall
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.textHeader1
        label.textAlignment = .left
        
        addSubview(label)
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(seeMoreButton)
        NSLayoutConstraint.activate([
            seeMoreButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            seeMoreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}


final class Spacer: UICollectionReusableView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}




