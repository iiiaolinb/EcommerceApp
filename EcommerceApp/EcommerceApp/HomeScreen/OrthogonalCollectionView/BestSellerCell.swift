import UIKit

final class BestSellerCell: UICollectionViewCell {
    static let cellId = "BestSellerCell"
    var toggle: Bool = true
    
    lazy var letterLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        imageView.backgroundColor = .white
        return imageView
    }()
    
    lazy var gestureButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton(title: "", target: self, selector: #selector(isFavorite))
        button.backgroundColor = .white
        button.setImage(UIImage(named: "HeartOrangeBorder"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.masksToBounds = false
        button.layer.shadowOpacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var fullPrice: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.textSmall
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var discountPrice: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.textExtraSmall
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var itemsName: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.textExtraSmall
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func isFavorite() {
        self.heartButton.setImage(toggle ? UIImage(named: "HeartOrangeBorder") : UIImage(named: "HeartOrange"), for: .normal)
        toggle.toggle()
    }
    
    private func setupViews() {
        contentView.addSubview(letterLabel)
        NSLayoutConstraint.activate([
            letterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            letterLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            letterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        contentView.addSubview(gestureButton)
        NSLayoutConstraint.activate([
            gestureButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gestureButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            gestureButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gestureButton.widthAnchor.constraint(equalTo: letterLabel.widthAnchor)
        ])
        
        contentView.addSubview(heartButton)
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            heartButton.heightAnchor.constraint(equalToConstant: 20),
            heartButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        contentView.addSubview(itemsName)
        NSLayoutConstraint.activate([
            itemsName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            itemsName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30)
        ])
        
        contentView.addSubview(fullPrice)
        NSLayoutConstraint.activate([
            fullPrice.bottomAnchor.constraint(equalTo: itemsName.topAnchor, constant: 0),
            fullPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30)
        ])
        
        contentView.addSubview(discountPrice)
        NSLayoutConstraint.activate([
            discountPrice.bottomAnchor.constraint(equalTo: itemsName.topAnchor, constant: 0),
            discountPrice.leadingAnchor.constraint(equalTo: fullPrice.trailingAnchor, constant: 10)
        ])
    }
}
