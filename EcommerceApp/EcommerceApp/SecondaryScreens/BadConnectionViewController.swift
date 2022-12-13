import UIKit

final class BadConnectionViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.Font.textHeader2
        label.numberOfLines = 0
        label.text = "Bad internet. Check your connection!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(title: "Cancel", target: self, selector: #selector(onCancelButton))
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = Constants.Colors.darkBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.Colors.orange
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        setupConstraints()
    }
    
    @objc private func onCancelButton() {
        dismiss(animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            titleLabel.widthAnchor.constraint(equalToConstant: Constants.Sizes.buttonSizes.width),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)
        ])
            
        view.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: Constants.Sizes.buttonSizes.width),
            confirmButton.heightAnchor.constraint(equalToConstant: CGFloat(Constants.Sizes.buttonSizes.height))
            ])
    }
}

