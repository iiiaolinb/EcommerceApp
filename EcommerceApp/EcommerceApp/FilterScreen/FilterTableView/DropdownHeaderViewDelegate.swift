import UIKit

protocol DropdownHeaderViewDelegate {
    func toggleSection(header: DropdownHeaderView, section: Int)
}

final class DropdownHeaderView: UITableViewHeaderFooterView {
    var section: Int!
    var delegate: DropdownHeaderViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapped))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTapped(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! DropdownHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(title: String, section: Int, delegate: DropdownHeaderViewDelegate) {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
