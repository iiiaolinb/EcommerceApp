import UIKit

final class CartTableView: UITableView {
    
    private var viewModel: CartViewModel?
    
    init(viewModel: CartViewModel) {
        super.init(frame: CGRect.zero, style: .plain)
        self.viewModel = viewModel
        
        backgroundColor = .clear
        dataSource = self
        delegate = self
        register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.cellId)

        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModel = viewModel else { return UITableViewCell() }
        return viewModel.configureCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            viewModel?.openConfirmationScreen(tableView: tableView, forIndexPath: indexPath)
        }
    }
}

extension CartTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
