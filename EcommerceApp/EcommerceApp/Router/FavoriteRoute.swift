import UIKit

protocol FavoriteRoute {
    func makeFavoriteScreen() -> UIViewController
}

extension FavoriteRoute where Self: RouterProtocol {
    func makeFavoriteScreen() -> UIViewController {
        let router = Router(rootTransition: Transition())
        let viewController = FavoriteViewController()
        router.root = viewController

        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Heart"), tag: 0)
        navigation.tabBarItem.titlePositionAdjustment.horizontal += 10
        
        return navigation
    }

    func selectListTab() {
        root?.tabBarController?.selectedIndex = 3
    }
}

extension Router: FavoriteRoute {}
