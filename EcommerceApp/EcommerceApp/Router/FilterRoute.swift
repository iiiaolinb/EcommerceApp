import UIKit

protocol FilterRoute {
    func openFilterScreen()
}

extension FilterRoute where Self: RouterProtocol {
    
    func openFilterScreen() {
        let viewController = FilterViewController()
        let customTransitioningDelegate = TransitioningDelegate()
        viewController.transitioningDelegate = customTransitioningDelegate
        viewController.modalPresentationStyle = .custom
        
        route(to: viewController)
    }
}

extension Router: FilterRoute {}


