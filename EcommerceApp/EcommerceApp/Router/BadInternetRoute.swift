import UIKit

protocol BadConnectionRoute {
    func openBadConnectionScreen()
}

extension BadConnectionRoute where Self: RouterProtocol {
    
    func openBadConnectionScreen() {
        let viewController = BadConnectionViewController()
        let customTransitioningDelegate = TransitioningDelegate()
        viewController.transitioningDelegate = customTransitioningDelegate
        viewController.modalPresentationStyle = .custom
        
        route(to: viewController)
    }
}

extension Router: BadConnectionRoute {}
