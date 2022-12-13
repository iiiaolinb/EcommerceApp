import UIKit

final class HotSalesCell: UICollectionViewCell {
    static let cellId = "HotSalesCell"
    
    lazy var letterLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var newLabel: UILabel = {
        let label = UILabel()
        label.text = "New"
        label.backgroundColor = Constants.Colors.orange
        label.textColor = .white
        label.font = Constants.Font.textExtraSmall
        label.layer.cornerRadius = 11
        label.clipsToBounds = true
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var itemsNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = Constants.Font.textHeader1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var itemsSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = Constants.Font.textSmall
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = Constants.Font.textSmall
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        contentView.addSubview(letterLabel)
        NSLayoutConstraint.activate([
            letterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            letterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.addSubview(newLabel)
        NSLayoutConstraint.activate([
            newLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            newLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newLabel.widthAnchor.constraint(equalToConstant: 22),
            newLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        contentView.addSubview(itemsNameLabel)
        NSLayoutConstraint.activate([
            itemsNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            itemsNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
        
        contentView.addSubview(itemsSubtitleLabel)
        NSLayoutConstraint.activate([
            itemsSubtitleLabel.topAnchor.constraint(equalTo: itemsNameLabel.bottomAnchor, constant: 0),
            itemsSubtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
        
        contentView.addSubview(buyButton)
        NSLayoutConstraint.activate([
            buyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            buyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            buyButton.heightAnchor.constraint(equalToConstant: 20),
            buyButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
