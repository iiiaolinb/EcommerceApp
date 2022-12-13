import UIKit

protocol CartRoute {
    func openCartScreen()
}

extension CartRoute where Self: RouterProtocol {
    func openCartScreen(with transition: TransitionProtocol) {
            let router = Router(rootTransition: transition)
            let viewModel = CartViewModel(router: router)
            let viewController = CartViewController(viewModel: viewModel)
            router.root = viewController
    
            route(to: viewController, with: transition)
        }
    
        func openCartScreen() {
            openCartScreen(with: PushTransition())
        }
}

extension Router: CartRoute {}

