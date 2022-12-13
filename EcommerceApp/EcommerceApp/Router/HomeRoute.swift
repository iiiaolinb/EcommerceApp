import UIKit

protocol HomeRoute {
    func makeHomeScreen() -> UIViewController
    func goHome()
}

extension HomeRoute where Self: RouterProtocol {
    func makeHomeScreen() -> UIViewController {
        let router = Router(rootTransition: Transition())
        let viewModel = HomeViewModel(router: router)
        let viewController = HomeViewController(viewModel: viewModel)
        router.root = viewController

        let navigation = UINavigationController(rootViewController: viewController)
        
        navigation.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "TabBarItem"), tag: 0)
        navigation.tabBarItem.titlePositionAdjustment.horizontal +=  50
        
        return navigation
    }
 
    func goHome() {
        root?.tabBarController?.selectedIndex = 0
    }
}

extension Router: HomeRoute {}
