import UIKit

protocol ProfileRoute {
    func makeProfileScreen() -> UIViewController
}

extension ProfileRoute where Self: RouterProtocol {
    func makeProfileScreen() -> UIViewController {
        let router = Router(rootTransition: Transition())
        let viewController = ProfileViewController()
        router.root = viewController

        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), tag: 0)
        navigation.tabBarItem.titlePositionAdjustment.horizontal -= 20
        
        return navigation
    }

    func selectListTab() {
        root?.tabBarController?.selectedIndex = 3
    }
}

extension Router: ProfileRoute {}
