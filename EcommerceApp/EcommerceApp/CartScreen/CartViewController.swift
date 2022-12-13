import UIKit

final class CartViewController: UIViewController {
    
    private var viewModel: CartViewModel!
    
    init(viewModel: CartViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var myCartLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: Constants.Sizes.screenHeight / 6, width: Constants.Sizes.screenWidth, height: 30))
        label.text = "My cart"
        label.font = Constants.Font.textHeader1
        return label
    }()
    
    lazy var roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.darkBlue
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.font = Constants.Font.textSmall
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery"
        label.font = Constants.Font.textSmall
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    static var totalCostLabel: UILabel = {
        let label = UILabel()
        label.text = CartViewModel.calculateTotalPrice()
        label.font = Constants.Font.textMedium
        label.textColor = .white
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var deliveryCostLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Free"
        label.font = Constants.Font.textMedium
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var totalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(totalLabel)
        stack.addArrangedSubview(CartViewController.totalCostLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var deliveryStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(deliveryLabel)
        stack.addArrangedSubview(deliveryCostLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var checkoutButton: UIButton = {
        let button = UIButton(title: "Checkout", target: self, selector: nil)
        button.backgroundColor = Constants.Colors.orange
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    lazy var borderdRect: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 0.5
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView = CartTableView(viewModel: viewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.Colors.background
        
        CartViewController.updateUI()
        
        setupNavigationBar()
        setupConstraints()
    }
    
    @objc private func backTo() {
        viewModel.backToDetailsScreen()
    }
    
    @objc private func goTo() {
        //insert some method
    }
    
    static func updateUI() {
        self.totalCostLabel.text = CartViewModel.calculateTotalPrice()
    }
       
    private func setupNavigationBar() {
        let leftBarButtonItem = buildNavigationBarButton(imageName: "ArrowBack", color: Constants.Colors.darkBlue ?? .black, target: self, action: #selector(backTo), withBadge: nil)

        let rightBarButtonItem = buildBarButtonItemWithTitle(title: "Add address", color: Constants.Colors.orange ?? .orange, imageName: "Location", target: self, selector: #selector(goTo))

        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        
        tabBarController?.tabBar.isHidden = true
    }
}






    //MARK: - setup constraints

extension CartViewController {
    private func setupConstraints() {
        
        view.addSubview(myCartLabel)
        
        view.addSubview(roundedView)
        roundedView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        roundedView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Sizes.screenHeight * 1/3).isActive = true
        roundedView.heightAnchor.constraint(equalToConstant: Constants.Sizes.screenHeight).isActive = true
        roundedView.widthAnchor.constraint(equalToConstant: Constants.Sizes.screenWidth).isActive = true
        
        //checkout button constraint
        view.addSubview(checkoutButton)
        checkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkoutButton.widthAnchor.constraint(equalToConstant: Constants.Sizes.screenWidth - 100).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //cost of items constraint
        view.addSubview(totalStack)
        totalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        totalStack.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -65).isActive = true
        totalStack.heightAnchor.constraint(equalToConstant: 25).isActive = true
        totalStack.widthAnchor.constraint(equalToConstant: Constants.Sizes.screenWidth - 100).isActive = true
        
        CartViewController.totalCostLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //border for cost & delivery area
        view.addSubview(borderdRect)
        borderdRect.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        borderdRect.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -20).isActive = true
        borderdRect.topAnchor.constraint(equalTo: totalStack.topAnchor, constant: -20).isActive = true
        borderdRect.widthAnchor.constraint(equalToConstant: Constants.Sizes.screenWidth + 20).isActive = true
        
        //table view constraint
        view.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 20).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: Constants.Sizes.screenWidth - 32).isActive = true
        tableView.bottomAnchor.constraint(equalTo: borderdRect.topAnchor, constant: -20).isActive = true
        
        //cost of delivery constraint
        view.addSubview(deliveryStack)
        deliveryStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deliveryStack.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -40).isActive = true
        deliveryStack.heightAnchor.constraint(equalToConstant: 25).isActive = true
        deliveryStack.widthAnchor.constraint(equalToConstant: Constants.Sizes.screenWidth - 100).isActive = true
        
        deliveryCostLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
