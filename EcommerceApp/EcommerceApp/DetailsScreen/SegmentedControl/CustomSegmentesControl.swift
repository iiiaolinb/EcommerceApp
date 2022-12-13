import UIKit

protocol CustomSegmentedControlDelegate: class {
    func change(to index:Int)
}

class CustomSegmentedControl: UIView {
    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    private var shopView: UIView!
    private var detailsView: UIView!
    private var featuresView: UIView!
    
    private var screenWidth = UIScreen.main.bounds.width
    
    var textColor: UIColor = .black
    var selectorViewColor: UIColor = Constants.Colors.orange ?? .orange
    var selectorTextColor: UIColor = Constants.Colors.orange ?? .orange
    
    weak var delegate: CustomSegmentedControlDelegate?
    var viewModel: DetailsViewModel?
    
    var selectedIndex : Int = 0
    
    lazy var detailsHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.addArrangedSubview(firstStack)
        stack.addArrangedSubview(seconfStack)
        stack.addArrangedSubview(thirdStack)
        stack.addArrangedSubview(fourthStack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var firstStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(imageForFirstStack)
        stack.addArrangedSubview(labelForFirstStack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var seconfStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(imageForSecondStack)
        stack.addArrangedSubview(labelForSecondStack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var thirdStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(imageForThirdStack)
        stack.addArrangedSubview(labelForThirdStack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var fourthStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(imageForFourthStack)
        stack.addArrangedSubview(labelForFourthStack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var imageForFirstStack: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CPU")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var imageForSecondStack: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Camera")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var imageForThirdStack: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SSD")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var imageForFourthStack: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SD")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var labelForFirstStack: UILabel = {
        let label = UILabel()
        label.text = viewModel?.model?.cPU ?? "0"
        label.font = Constants.Font.textSmall
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelForSecondStack: UILabel = {
        let label = UILabel()
        label.text = viewModel?.model?.camera
        label.font = Constants.Font.textSmall
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelForThirdStack: UILabel = {
        let label = UILabel()
        label.text = viewModel?.model?.ssd
        label.font = Constants.Font.textSmall
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelForFourthStack: UILabel = {
        let label = UILabel()
        label.text = viewModel?.model?.sd
        label.font = Constants.Font.textSmall
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var settingsBarVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(settingsLabel)
        stack.addArrangedSubview(settingsBarHorizontalStack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Select color and capacity"
        label.font = Constants.Font.textMain
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var settingsBarHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addSubview(firstColorOption)
        stack.addSubview(secondColorOption)
        stack.addSubview(firstCapacityOption)
        stack.addSubview(secondCapacityOption)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var firstColorOption: UIButton = {
        let button = UIButton(title: "", target: self, selector: #selector(setColorOption1))
        button.setImage(UIImage(named: "Select"), for: .normal)
        button.backgroundColor = UIColor(hex: viewModel?.model?.color?[0] ?? "#000000")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var secondColorOption: UIButton = {
        let button = UIButton(title: "", target: self, selector: #selector(setColorOption2))
        button.backgroundColor = UIColor(hex: viewModel?.model?.color?[1] ?? "#000000")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var firstCapacityOption: UIButton = {
        let button = UIButton(title: "\(viewModel?.model?.capacity?[0] ?? "0") Gb", target: self, selector: #selector(setCapacityOption1))
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = Constants.Font.textSmall
        button.backgroundColor = Constants.Colors.orange
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var secondCapacityOption: UIButton = {
        let button = UIButton(title: "\(viewModel?.model?.capacity?[1] ?? "0") Gb", target: self, selector: #selector(setCapacityOption2))
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.titleLabel?.font = Constants.Font.textSmall
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var detailsBlankLabel: UILabel = {
        let label = UILabel()
        label.text = "        Somthing about this model"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var featuresBlankLabel: UILabel = {
        let label = UILabel()
        label.text = "        Somthing about this model"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: DetailsViewModel, frame:CGRect, buttonTitle: [String]) {
        super.init(frame: frame)
        self.viewModel = viewModel
        self.buttonTitles = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
        //the method changes the position of the subview when the button is clicked
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPositionForSegment = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                let selectorPositionForShop = frame.width * CGFloat(buttonIndex)
                let selectorPositionForDetails = frame.width * CGFloat(buttonIndex) - frame.width
                let selectorPositionForFeaturs = frame.width * CGFloat(buttonIndex) - 2 * frame.width
                selectedIndex = buttonIndex
                delegate?.change(to: selectedIndex)

                UIView.animate(withDuration: 0.5) {
                    self.selectorView.frame.origin.x = selectorPositionForSegment
                    self.shopView.frame.origin.x = selectorPositionForShop
                    self.detailsView.frame.origin.x = selectorPositionForDetails
                    self.featuresView.frame.origin.x = selectorPositionForFeaturs
                    btn.setTitleColor(self.selectorTextColor, for: .normal)
                }
            }
        }
    }
    
    @objc private func setColorOption1() {
        viewModel?.setColorOption1(first: firstColorOption, second: secondColorOption)
        DetailsViewController.setColorToggle = viewModel?.model?.color?[0] ?? "#000000"
    }
    
    @objc private func setColorOption2() {
        viewModel?.setColorOption2(second: secondColorOption, first: firstColorOption)
        DetailsViewController.setColorToggle = viewModel?.model?.color?[1] ?? "#000000"
    }
    
    @objc private func setCapacityOption1() {
        viewModel?.setCapacityOption1(first: firstCapacityOption, second: secondCapacityOption)
        DetailsViewController.setCapacityToggle = self.viewModel?.model?.capacity?[0] ?? "0"
    }
    
    @objc private func setCapacityOption2() {
        viewModel?.setCapacityOption2(second: secondCapacityOption, first: firstCapacityOption)
        DetailsViewController.setCapacityToggle = self.viewModel?.model?.capacity?[1] ?? "0"
    }
}

    //MARK: - Configuration View

extension CustomSegmentedControl {
    func updateView() {
        createButton()
        configSelectorView()
        configureShopView()
        configureDeatailsView()
        configureFeaturesView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.titleLabel?.font = Constants.Font.textMain
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
    
    private func configSelectorView() {
        selectorView = UIView(frame: CGRect(x: 0, y: 50, width: frame.width / 3, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func configureShopView() {
        shopView = UIView(frame: CGRect(x: 0, y: self.frame.height * 1/3, width: frame.width, height: self.frame.height * 2/3))
        shopView.backgroundColor = .clear
        addSubview(shopView)

        setupConstraints()
    }
    
    private func configureDeatailsView() {
        detailsView = UIView(frame: CGRect(x: -frame.width, y: self.frame.height * 1/3, width: frame.width, height: self.frame.height * 2/3))
        detailsView.backgroundColor = .clear
        addSubview(detailsView)
        
        detailsView.addSubview(detailsBlankLabel)
    }
    
    private func configureFeaturesView() {
        featuresView = UIView(frame: CGRect(x: -2 * frame.width, y: self.frame.height * 1/3, width: frame.width, height: self.frame.height * 2/3))
        featuresView.backgroundColor = .clear
        addSubview(featuresView)
        
        featuresView.addSubview(featuresBlankLabel)
    }
}







    //MARK: - setup constraints

extension CustomSegmentedControl {
    private func setupConstraints() {
        //details stack constraints
        shopView.addSubview(detailsHorizontalStack)
        detailsHorizontalStack.centerXAnchor.constraint(equalTo: shopView.centerXAnchor).isActive = true
        detailsHorizontalStack.topAnchor.constraint(equalTo: shopView.topAnchor).isActive = true
        detailsHorizontalStack.widthAnchor.constraint(equalTo: shopView.widthAnchor, constant: -32).isActive = true
        detailsHorizontalStack.heightAnchor.constraint(equalToConstant: shopView.bounds.height / 2).isActive = true
        
        imageForFirstStack.centerXAnchor.constraint(equalTo: firstStack.centerXAnchor).isActive = true
        imageForFirstStack.topAnchor.constraint(equalTo: firstStack.topAnchor, constant: 10).isActive = true
        imageForFirstStack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageForFirstStack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imageForSecondStack.centerXAnchor.constraint(equalTo: seconfStack.centerXAnchor).isActive = true
        imageForSecondStack.topAnchor.constraint(equalTo: seconfStack.topAnchor, constant: 10).isActive = true
        imageForSecondStack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageForSecondStack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imageForThirdStack.centerXAnchor.constraint(equalTo: thirdStack.centerXAnchor).isActive = true
        imageForThirdStack.topAnchor.constraint(equalTo: thirdStack.topAnchor, constant: 10).isActive = true
        imageForThirdStack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageForThirdStack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imageForFourthStack.centerXAnchor.constraint(equalTo: fourthStack.centerXAnchor).isActive = true
        imageForFourthStack.topAnchor.constraint(equalTo: fourthStack.topAnchor, constant: 10).isActive = true
        imageForFourthStack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageForFourthStack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //settings vertical stack constraints
        shopView.addSubview(settingsBarVerticalStack)
        settingsBarVerticalStack.centerXAnchor.constraint(equalTo: shopView.centerXAnchor).isActive = true
        settingsBarVerticalStack.topAnchor.constraint(equalTo: shopView.topAnchor, constant: shopView.bounds.height / 2).isActive = true
        settingsBarVerticalStack.widthAnchor.constraint(equalTo: shopView.widthAnchor, constant: -32).isActive = true
        settingsBarVerticalStack.heightAnchor.constraint(equalToConstant: shopView.bounds.height / 2).isActive = true
        
        //settings label constraints
        settingsLabel.topAnchor.constraint(equalTo: settingsBarVerticalStack.topAnchor).isActive = true
        settingsLabel.leadingAnchor.constraint(equalTo: settingsBarVerticalStack.leadingAnchor).isActive = true
        settingsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //settings horizontal stack constraints
        settingsBarHorizontalStack.leadingAnchor.constraint(equalTo: settingsBarVerticalStack.leadingAnchor).isActive = true
        settingsBarHorizontalStack.trailingAnchor.constraint(equalTo: settingsBarVerticalStack.trailingAnchor).isActive = true
        settingsBarHorizontalStack.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor).isActive = true
        settingsBarHorizontalStack.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 10 ).isActive = true
        
        //first color constraints
        firstColorOption.leadingAnchor.constraint(equalTo: settingsBarHorizontalStack.leadingAnchor).isActive = true
        firstColorOption.centerYAnchor.constraint(equalTo: settingsBarHorizontalStack.centerYAnchor).isActive = true
        firstColorOption.widthAnchor.constraint(equalToConstant: 30).isActive = true
        firstColorOption.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //second color constraints
        secondColorOption.leadingAnchor.constraint(equalTo: settingsBarHorizontalStack.leadingAnchor, constant: 50).isActive = true
        secondColorOption.centerYAnchor.constraint(equalTo: settingsBarHorizontalStack.centerYAnchor).isActive = true
        secondColorOption.widthAnchor.constraint(equalToConstant: 30).isActive = true
        secondColorOption.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //first capacity constraints
        firstCapacityOption.trailingAnchor.constraint(equalTo: settingsBarHorizontalStack.trailingAnchor, constant: -80).isActive = true
        firstCapacityOption.centerYAnchor.constraint(equalTo: settingsBarHorizontalStack.centerYAnchor).isActive = true
        firstCapacityOption.widthAnchor.constraint(equalToConstant: 60).isActive = true
        firstCapacityOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //second capacity constraints
        secondCapacityOption.trailingAnchor.constraint(equalTo: settingsBarHorizontalStack.trailingAnchor).isActive = true
        secondCapacityOption.centerYAnchor.constraint(equalTo: settingsBarHorizontalStack.centerYAnchor).isActive = true
        secondCapacityOption.widthAnchor.constraint(equalToConstant: 60).isActive = true
        secondCapacityOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
