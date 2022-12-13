import UIKit

class PushTransition: NSObject {
    var isAnimated: Bool = true
    var from: UIViewController?

    var navigationController: UINavigationController? {
        guard let navigation = from as? UINavigationController else {
            return from?.navigationController }
        return navigation
    }

    init(isAnimated: Bool = true) {
        self.isAnimated = isAnimated
    }
}

extension PushTransition: TransitionProtocol {
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        self.from = from
        navigationController?.delegate = self
        navigationController?.pushViewController(viewController, animated: isAnimated)
    }

    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        navigationController?.popViewController(animated: isAnimated)
    }
}

extension PushTransition: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let transitionCoordinator = navigationController.transitionCoordinator,
              let _ = transitionCoordinator.viewController(forKey: .from),
              let _ = transitionCoordinator.viewController(forKey: .to) else { return }
    }
}

