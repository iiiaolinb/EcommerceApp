import UIKit
import Combine

final class CartTableViewCell: UITableViewCell {
    
    static let cellId = "CartTableViewCell"
    private var viewModel: CartViewModel?
    
    lazy var itemImageView: UIImageView = {
        let images = UIImageView()
        images.backgroundColor = .white
        images.layer.cornerRadius = 10
        images.clipsToBounds = true
        images.contentMode = .scaleAspectFit
        images.translatesAutoresizingMaskIntoConstraints = false
        return images
    }()
    
    lazy var itemsName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var itemsCost: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = Constants.Colors.orange
        label.numberOfLines = 0
        label.layoutIfNeeded()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var littleGrayView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.alpha = 0.3
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton(title: "+", target: self, selector: #selector(onPlusButton))
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton(title: "-", target: self, selector: #selector(onMinusButton))
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel?.numberOfItemsInRow(id: plusButton.tag)
        label.font = Constants.Font.textSmall
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.layoutIfNeeded()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(itemImageView)
        stack.addArrangedSubview(infoVerticalStack)
        stack.addArrangedSubview(itemsCountVerticalStack)
        stack.addArrangedSubview(garbageButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var infoVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(itemsName)
        stack.addArrangedSubview(itemsCost)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var itemsCountVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.addSubview(littleGrayView)
        stack.addArrangedSubview(plusButton)
        stack.addArrangedSubview(countLabel)
        stack.addArrangedSubview(minusButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var garbageButton: UIButton = {
        let button = UIButton(title: "", target: self, selector: nil)
        button.setImage(UIImage(named: "Garbage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.Colors.darkBlue

        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    @objc private func onPlusButton() {
        self.countLabel.text = CartViewModel.changeCount(.plus, buttonTag: plusButton.tag)
        CartViewController.updateUI()
    }
    
    @objc private func onMinusButton() {
        self.countLabel.text = CartViewModel.changeCount(.minus, buttonTag: minusButton.tag)
        CartViewController.updateUI()
    }
}




    //MARK: - setup constraints

extension CartTableViewCell {
    private func setupConstraints() {
        
        //main stack constraints
        contentView.addSubview(mainStack)
        mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        //image of item constraints
        contentView.addSubview(itemImageView)
        itemImageView.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor).isActive = true
        itemImageView.centerYAnchor.constraint(equalTo: mainStack.centerYAnchor).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.Sizes.imageInCartSizes.height)).isActive = true
        itemImageView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.Sizes.imageInCartSizes.width)).isActive = true
        
        //info stack constraints
        contentView.addSubview(infoVerticalStack)
        infoVerticalStack.topAnchor.constraint(equalTo: mainStack.topAnchor).isActive = true
        infoVerticalStack.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor).isActive = true
        infoVerticalStack.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20).isActive = true
        infoVerticalStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -60).isActive = true
        
        //items name constraints
        itemsName.centerXAnchor.constraint(equalTo: infoVerticalStack.centerXAnchor).isActive = true
        itemsName.topAnchor.constraint(equalTo: infoVerticalStack.topAnchor, constant: 5).isActive = true
        itemsName.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        //items price constraints
        itemsCost.centerXAnchor.constraint(equalTo: infoVerticalStack.centerXAnchor).isActive = true
        itemsCost.bottomAnchor.constraint(equalTo: infoVerticalStack.bottomAnchor, constant: -5).isActive = true
        itemsCost.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        //itemsCountVerticalStack constraints
        contentView.addSubview(itemsCountVerticalStack)
        itemsCountVerticalStack.topAnchor.constraint(equalTo: mainStack.topAnchor, constant: 10).isActive = true
        itemsCountVerticalStack.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: -10).isActive = true
        itemsCountVerticalStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -25).isActive = true
        itemsCountVerticalStack.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        //little grey view constraints
        littleGrayView.leadingAnchor.constraint(equalTo: itemsCountVerticalStack.leadingAnchor).isActive = true
        littleGrayView.trailingAnchor.constraint(equalTo: itemsCountVerticalStack.trailingAnchor).isActive = true
        littleGrayView.topAnchor.constraint(equalTo: itemsCountVerticalStack.topAnchor).isActive = true
        littleGrayView.bottomAnchor.constraint(equalTo: itemsCountVerticalStack.bottomAnchor).isActive = true
        
        //items count label constraints
        countLabel.centerXAnchor.constraint(equalTo: itemsCountVerticalStack.centerXAnchor).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: itemsCountVerticalStack.centerYAnchor).isActive = true
        
        //plus button constraints
        plusButton.centerXAnchor.constraint(equalTo: itemsCountVerticalStack.centerXAnchor).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: countLabel.topAnchor, constant: 2).isActive = true
        
        //minus button constraints
        minusButton.centerXAnchor.constraint(equalTo: itemsCountVerticalStack.centerXAnchor).isActive = true
        minusButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: -2).isActive = true
        
        //garbage image constraints
        contentView.addSubview(garbageButton)
        garbageButton.topAnchor.constraint(equalTo: mainStack.topAnchor).isActive = true
        garbageButton.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor).isActive = true
        garbageButton.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor).isActive = true
        garbageButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
