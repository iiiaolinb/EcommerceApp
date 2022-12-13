import UIKit

final class DetailsViewController: UIViewController {
    
    private var viewModel: DetailsViewModel!
    
    static var setColorToggle: String = "#772D03"
    static var setCapacityToggle: String = "126"
    
    init(viewModel: DetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var roundedView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: Constants.Sizes.screenHeight * 4/10, width: Constants.Sizes.screenWidth, height: Constants.Sizes.screenHeight * 6/10))
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: -5)
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(itemsNameLabel)
        stack.addArrangedSubview(heartButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var itemsNameLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel?.model?.title
        label.adjustsFontSizeToFitWidth = true
        label.font = Constants.Font.textMain
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(headerStack)
        stack.addArrangedSubview(starStack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var starStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addSubview(starImageView1)
        stack.addSubview(starImageView2)
        stack.addSubview(starImageView3)
        stack.addSubview(starImageView4)
        stack.addSubview(starImageView5)
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var starImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Star")
        imageView.alpha = viewModel?.model?.rating ?? 5 >= 0.5 ? 1 : 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var starImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Star")
        imageView.alpha = viewModel?.model?.rating ?? 5 >= 1.5 ? 1 : 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var starImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Star")
        imageView.alpha = viewModel?.model?.rating ?? 5 >= 2.5 ? 1 : 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var starImageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Star")
        imageView.alpha = viewModel?.model?.rating ?? 5 >= 3.5 ? 1 : 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var starImageView5: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Star")
        imageView.alpha = viewModel?.model?.rating ?? 5 >= 4.5 ? 1 : 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton(title: "", target: self, selector: #selector(isFavorite))
        button.backgroundColor = viewModel?.model?.isFavorites ?? false ? Constants.Colors.orange : Constants.Colors.darkBlue
        button.setImage(UIImage(named: "Heart"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var addToCartButton: UIButton = {
        guard let price = viewModel?.model?.price?.formattedWithSeparator else {
            return buildBlankButton(withTitle: "Add to cart", target: self, selector: #selector(onAddToCartTapped))
        }
        let button = UIButton(title: "Add to cart \(String(describing: price)).00 $", target: self, selector: #selector(onAddToCartTapped))
        button.backgroundColor = Constants.Colors.orange
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    lazy var rightBarButton: UIButton = {
        let button = UIButton(title: "", target: self, selector: #selector(goToCart))
        button.setImage(UIImage(named: "Bag"), for: .normal)
        button.backgroundColor = Constants.Colors.orange
        button.layer.cornerRadius = 7
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        button.addSubview(badgeLabel)
        NSLayoutConstraint.activate([
            badgeLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -1),
            badgeLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -1),
            badgeLabel.widthAnchor.constraint(equalToConstant: 20),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.textColor = .white
        label.font = Constants.Font.textSmall
        label.backgroundColor = Constants.Colors.darkBlue
        label.alpha = 0
        return label
    }()
    
    lazy private var segmentedControl: CustomSegmentedControl = {
        let codeSegmented = CustomSegmentedControl(
            viewModel: viewModel,
            frame: CGRect(x: 16,
                          y: Constants.Sizes.screenHeight * 5/10 + 20,
                          width: Constants.Sizes.screenWidth - 32,
                          height: Constants.Sizes.screenHeight * 3/10),
            buttonTitle: ["Shop","Details","Features"])
        codeSegmented.backgroundColor = UIColor.clear

        return codeSegmented
    }()
    
    lazy private var galleryCollectionView = GalleryCollectionView(viewModel: viewModel)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.Colors.background
        
        checkConnection()
        setupNavigationBar()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateBadgeLabel(badgeLabel, tabBar: tabBarController)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupNavigationBar() {
        let leftBarButtonItem = buildNavigationBarButton(imageName: "ArrowBack", color: Constants.Colors.darkBlue!, target: self, action: #selector(backTo), withBadge: nil)
        let rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        navigationItem.title = "Product details"

        tabBarController?.tabBar.isHidden = false
    }
    
    private func checkConnection() {
        viewModel.checkConnection(self)
    }
    
    @objc private func isFavorite() {
        viewModel.isFavorite(heartButton)
    }
    
    @objc private func onAddToCartTapped() {
        viewModel.addItemToCart(withColor: DetailsViewController.setColorToggle,
                                capacity: DetailsViewController.setCapacityToggle)
        viewModel.updateBadgeLabel(badgeLabel, tabBar: tabBarController)
    }
 
    @objc private func backTo() {
        viewModel.backToHomeScreen()
    }
    
    @objc private func goToCart() {
        viewModel?.openCartScreen()
    }
}





    //MARK: setup constraints

extension DetailsViewController {
    private func setupConstraints() {
        //gallery constraints
        view.addSubview(galleryCollectionView)
        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        galleryCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        galleryCollectionView.widthAnchor.constraint(equalToConstant: Constants.Sizes.screenWidth).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: Constants.Sizes.screenHeight * 3/10).isActive = true
        
        view.addSubview(roundedView)
        
        //vertical stack constraints
        view.addSubview(verticalStack)
        verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 4/10 + 20).isActive = true
        verticalStack.widthAnchor.constraint(equalToConstant: Constants.Sizes.screenWidth - 32).isActive = true
        verticalStack.heightAnchor.constraint(equalToConstant: Constants.Sizes.screenHeight / 10).isActive = true
        
        //header stack constraints
        view.addSubview(headerStack)
        headerStack.topAnchor.constraint(equalTo: verticalStack.topAnchor).isActive = true
        headerStack.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: 10).isActive = true
        headerStack.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: -10).isActive = true
        headerStack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //items name constraints
        itemsNameLabel.topAnchor.constraint(equalTo: headerStack.topAnchor).isActive = true
        itemsNameLabel.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor).isActive = true
        
        //heart button constraints
        heartButton.topAnchor.constraint(equalTo: headerStack.topAnchor).isActive = true
        heartButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        heartButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        heartButton.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor, constant: -20).isActive = true
        
        //star stack constraints
        starStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor).isActive = true
        starStack.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: 10).isActive = true
        starStack.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: -10).isActive = true
        starStack.heightAnchor.constraint(equalToConstant: Constants.Sizes.screenHeight / 20).isActive = true
        
        //star view constraints
        starImageView1.widthAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView1.centerYAnchor.constraint(equalTo: starStack.centerYAnchor).isActive = true
        starImageView1.leadingAnchor.constraint(equalTo: starStack.leadingAnchor).isActive = true
        
        starImageView2.widthAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView2.centerYAnchor.constraint(equalTo: starStack.centerYAnchor).isActive = true
        starImageView2.leadingAnchor.constraint(equalTo: starStack.leadingAnchor, constant: 20).isActive = true
        
        starImageView3.widthAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView3.heightAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView3.centerYAnchor.constraint(equalTo: starStack.centerYAnchor).isActive = true
        starImageView3.leadingAnchor.constraint(equalTo: starStack.leadingAnchor, constant: 40).isActive = true
        
        starImageView4.widthAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView4.heightAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView4.centerYAnchor.constraint(equalTo: starStack.centerYAnchor).isActive = true
        starImageView4.leadingAnchor.constraint(equalTo: starStack.leadingAnchor, constant: 60).isActive = true
        
        starImageView5.widthAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView5.heightAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView5.centerYAnchor.constraint(equalTo: starStack.centerYAnchor).isActive = true
        starImageView5.leadingAnchor.constraint(equalTo: starStack.leadingAnchor, constant: 80).isActive = true
        
        //addToCart button constraint
        view.addSubview(addToCartButton)
        addToCartButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Sizes.screenHeight * 8/10 + 20).isActive = true
        addToCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addToCartButton.widthAnchor.constraint(equalToConstant: Constants.Sizes.buttonSizes.width).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: CGFloat(Constants.Sizes.buttonSizes.height)).isActive = true
        
        view.addSubview(segmentedControl)
    }
}
