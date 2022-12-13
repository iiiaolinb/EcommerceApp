import UIKit

final class ConfirmationViewController: UIViewController {
    
    private var indexPath = IndexPath()
    private var tableView = UITableView()
    
    init(tableView: UITableView, indexPath: IndexPath) {
        super.init(nibName: nil, bundle: nil)
        self.tableView = tableView
        self.indexPath = indexPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.Font.textHeader2
        label.numberOfLines = 0
        label.text = "Are you sure you want to delete the object?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yesButton: UIButton = {
        let button = UIButton(title: "Yes", target: self, selector: #selector(onYesButton))
        button.backgroundColor = Constants.Colors.orange
        button.setTitleColor(Constants.Colors.darkBlue, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var noButton: UIButton = {
        let button = UIButton(title: "No", target: self, selector: #selector(onNoButton))
        button.backgroundColor = Constants.Colors.darkBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        setupConstraints()
    }
    
    @objc private func onYesButton() {
        CartViewModel.deleteRowInSection(tableView: tableView, indexPath: indexPath)
        dismiss(animated: true)
    }
    
    @objc private func onNoButton() {
        dismiss(animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(questionLabel)
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            questionLabel.heightAnchor.constraint(equalToConstant: 60),
            questionLabel.widthAnchor.constraint(equalToConstant: Constants.Sizes.buttonSizes.width),
            questionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
            
        view.addSubview(yesButton)
        NSLayoutConstraint.activate([
            yesButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            yesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yesButton.widthAnchor.constraint(equalToConstant: Constants.Sizes.buttonSizes.width),
            yesButton.heightAnchor.constraint(equalToConstant: CGFloat(Constants.Sizes.buttonSizes.height))
            ])
        
        view.addSubview(noButton)
        NSLayoutConstraint.activate([
            noButton.topAnchor.constraint(equalTo: yesButton.bottomAnchor, constant: 10),
            noButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noButton.widthAnchor.constraint(equalToConstant: Constants.Sizes.buttonSizes.width),
            noButton.heightAnchor.constraint(equalToConstant: CGFloat(Constants.Sizes.buttonSizes.height))
            
        ])
    }
}

