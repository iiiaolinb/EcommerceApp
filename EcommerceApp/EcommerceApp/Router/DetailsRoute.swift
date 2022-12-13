import UIKit

protocol DetailsRoute {
    func makeDetailsScreen() -> UIViewController
    func openDetailsScreenWithTab()
    func openDetailsScreenWithNavigation()
}

extension DetailsRoute where Self: RouterProtocol {
    
    func makeDetailsScreen() -> UIViewController {
        let router = Router(rootTransition: Transition())
        let viewModel = DetailsViewModel(router: router)
        let viewController = DetailsViewController(viewModel: viewModel)
        router.root = viewController

        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(
            title: "", image: UIImage(named: "Bag"), tag: 2)
        navigation.tabBarItem.titlePositionAdjustment.horizontal += 40
        
        return navigation
    }
    
    func openDetailsScreenWithTab() {
        root?.tabBarController?.selectedIndex = 1
        root?.tabBarController?.tabBar.isHidden = true
    }
    
    func openDetailsScreenWithNavigation() {
        root?.navigationController?.popViewController(animated: true)
    }
}

extension Router: DetailsRoute {}
