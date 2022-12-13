import UIKit

final class FilterTableView: UITableView {
    
    static let cellId = "FilterTableViewCell"
    private var viewModel = FilterViewModel()
    
    init() {
        super.init(frame: .zero, style: .plain)

        register(UITableViewCell.self, forCellReuseIdentifier: FilterTableView.cellId)
        delegate = self
        dataSource = self

        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if viewModel.filterModel[indexPath.section].isTapped {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if  let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            }
            else {
                cell.accessoryType = .checkmark
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

extension FilterTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.filterModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterModel[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableView.cellId) else { return UITableViewCell() }
        cell.textLabel?.text =  viewModel.filterModel[indexPath.section].items[indexPath.row]
        cell.layer.borderWidth = 2
        
        return cell
    }
}

extension FilterTableView: DropdownHeaderViewDelegate {
    
        //the method expands the list
    func toggleSection(header: DropdownHeaderView, section: Int) {
        viewModel.filterModel[section].isTapped = !viewModel.filterModel[section].isTapped
        
        self.beginUpdates()

        for item in 0..<viewModel.filterModel[section].items.count {
            self.reloadRows(at: [IndexPath(row: item, section: section)], with: .automatic)
        }
        
        self.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = DropdownHeaderView()
        header.customInit(title: viewModel.filterModel[section].header, section: section, delegate: self)
        
        if section % 2 == 1 {
            header.layer.borderWidth = 1
            header.layer.borderColor = UIColor.lightGray.cgColor
            header.layer.cornerRadius = 3
            header.textLabel?.font = Constants.Font.textExtraSmall
        }
        return header
    }
}
