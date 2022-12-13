import UIKit

protocol ConfirmationRoute {
    func openConfirmationScreen(tableView: UITableView, forIndexPath indexPath: IndexPath)
}

extension ConfirmationRoute where Self: RouterProtocol {
    
    func openConfirmationScreen(tableView: UITableView, forIndexPath indexPath: IndexPath) {
        let viewController = ConfirmationViewController(tableView: tableView, indexPath: indexPath)
        let customTransitioningDelegate = TransitioningDelegate()
        viewController.transitioningDelegate = customTransitioningDelegate
        viewController.modalPresentationStyle = .custom
        
        route(to: viewController)
    }
}

extension Router: ConfirmationRoute {}
