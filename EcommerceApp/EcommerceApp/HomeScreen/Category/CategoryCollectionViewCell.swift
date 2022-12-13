import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "CategoryCollectionViewCell"
    private let sizeForItem = Constants.Sizes.screenWidth / 8
    
    override var isSelected: Bool {
        didSet {
            self.imageView.backgroundColor = isSelected ? Constants.Colors.orange : UIColor.white
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = self.sizeForItem / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = Constants.Font.textSmall
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.sizeForItem).isActive = true
        //imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.sizeForItem).isActive = true
        //imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: self.sizeForItem).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
