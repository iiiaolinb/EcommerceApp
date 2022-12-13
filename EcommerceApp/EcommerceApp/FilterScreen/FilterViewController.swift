import UIKit

final class FilterViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.Font.textMain
        label.text = "Filter options"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var leftBarButtonItem: UIButton = {
        let button = UIButton(title: "X", target: self, selector: #selector(dismissVC))
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = Constants.Colors.darkBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var rightBarButtonItem: UIButton = {
        let button = UIButton(title: "Done", target: self, selector: #selector(filterIt))
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = Constants.Colors.orange
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var tableView = FilterTableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        setupConstraints()
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc private func filterIt() {
        
        //insert here some method with data filter
        
        dismiss(animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(leftBarButtonItem)
        leftBarButtonItem.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        leftBarButtonItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        leftBarButtonItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        leftBarButtonItem.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(rightBarButtonItem)
        rightBarButtonItem.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        rightBarButtonItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        rightBarButtonItem.widthAnchor.constraint(equalToConstant: 70).isActive = true
        rightBarButtonItem.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            tableView.widthAnchor.constraint(equalToConstant: Constants.Sizes.screenWidth - 80)
        ])
    }
}
