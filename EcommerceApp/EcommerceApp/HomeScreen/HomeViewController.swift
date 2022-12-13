import UIKit

final class HomeViewController: UIViewController {

    private var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var categoryStack: UIStackView = {
        let stack = UIStackView()
        
        let topStack: UIStackView = {
            let topStack = UIStackView()
            topStack.axis = .horizontal
            topStack.addArrangedSubview(selectCategoryLabel)
            topStack.addArrangedSubview(viewAllButton)
            topStack.translatesAutoresizingMaskIntoConstraints = false
            return topStack
        }()
        
        stack.axis = .vertical
        stack.addArrangedSubview(topStack)
        stack.addArrangedSubview(categoryCollectionView)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var selectCategoryLabel: UILabel = {
        let textField = UILabel()
        textField.text = "Select Category"
        textField.font = Constants.Font.textHeader1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var viewAllButton: UIButton = {
        let button = UIButton(title: "View all", target: self, selector: nil)
        button.setTitleColor(Constants.Colors.orange, for: .normal)
        button.titleLabel?.font = Constants.Font.textSmall
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var searchBarTF: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "  search"
        search.backgroundColor = .white
        search.searchTextField.backgroundColor = .white
        search.layer.cornerRadius = 16
        search.clipsToBounds = true
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    lazy var findQRButton: UIButton = {
        let button = UIButton(title: "", target: self, selector: nil)
        button.setImage(UIImage(named: "Finder"), for: .normal)
        button.backgroundColor = Constants.Colors.orange
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    

    
    private let categoryCollectionView = CategoryCollectionView()
    lazy private var orthogonalCollectionView = OrthogonalCollectionView(viewModel: viewModel, frame: .zero, collectionViewLayout: GridCompositionalLayout.generateLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.Colors.background
        
        checkConnections()
        setupNavigationBar()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupNavigationBar() {
        let rightBarButtonItem = buildNavigationBarButton(imageName: "Filter", color: .clear, target: self, action: #selector(filterIt), withBadge: nil)
        rightBarButtonItem.tintColor = Constants.Colors.darkBlue
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        navigationItem.titleView = buildNavigationTitleWithImage()
    }
    
    final func checkConnections() {
        viewModel.checkConnections(self.orthogonalCollectionView)
    }
    
    @objc func filterIt() {
        viewModel?.goToFilterScreen()
    }
    

}




    //MARK: - setup constraints

extension HomeViewController {
    private func setupConstraints() {
        setupConstraintsForCategory()
        setupConstraintsForSearchBar()
        setupConstraintsForOrthogonalCollectionView()
    }
    
    private func setupConstraintsForCategory() {
        
        //select category stack constraints
        view.addSubview(categoryStack)
        categoryStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        categoryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        categoryStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        categoryStack.heightAnchor.constraint(equalToConstant: Constants.Sizes.screenHeight * 2/10).isActive = true
        
        //select category constraints
        selectCategoryLabel.leadingAnchor.constraint(equalTo: categoryStack.leadingAnchor).isActive = true
        selectCategoryLabel.topAnchor.constraint(equalTo: categoryStack.topAnchor).isActive = true
        selectCategoryLabel.heightAnchor.constraint(equalToConstant: Constants.Sizes.screenHeight / 20).isActive = true
        
        //view all constraints
        viewAllButton.trailingAnchor.constraint(equalTo: categoryStack.trailingAnchor).isActive = true
        viewAllButton.topAnchor.constraint(equalTo: categoryStack.topAnchor, constant: 10).isActive = true

        //categoryCollectionView constraints
        categoryCollectionView.topAnchor.constraint(equalTo: selectCategoryLabel.bottomAnchor).isActive = true
        categoryCollectionView.leadingAnchor.constraint(equalTo: categoryStack.leadingAnchor).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: categoryStack.trailingAnchor).isActive = true
        categoryCollectionView.heightAnchor.constraint(equalToConstant: Constants.Sizes.screenHeight / 10).isActive = true
    }
    
    private func setupConstraintsForSearchBar() {
        view.addSubview(searchBarTF)
        searchBarTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        searchBarTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64).isActive = true
        searchBarTF.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 20).isActive = true
        searchBarTF.heightAnchor.constraint(equalToConstant: Constants.Sizes.screenHeight / 20).isActive = true
        
        view.addSubview(findQRButton)
        findQRButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        findQRButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        findQRButton.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 20).isActive = true
        findQRButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    private func setupConstraintsForOrthogonalCollectionView() {
        view.addSubview(orthogonalCollectionView)
        orthogonalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        orthogonalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        orthogonalCollectionView.topAnchor.constraint(equalTo: searchBarTF.bottomAnchor, constant: 20).isActive = true
        orthogonalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
    }
}
