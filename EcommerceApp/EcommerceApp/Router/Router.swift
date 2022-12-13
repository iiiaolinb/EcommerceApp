import UIKit

protocol Closable: AnyObject {
    func close()
}

protocol Routable: AnyObject {
    func route(to viewController: UIViewController, with transition: TransitionProtocol)
    func route(to viewController: UIViewController)
}

protocol RouterProtocol: Routable {
    var root: UIViewController? {get set}
}

class Router: NSObject, RouterProtocol, Closable {
    
    weak var root: UIViewController?
    private let rootTransition: TransitionProtocol
    
    init(rootTransition: TransitionProtocol) {
        self.rootTransition = rootTransition
    }
    
    func close() {
        guard let root = root else { return }
        rootTransition.close(root, completion: nil)
    }
    
    //for push presentation
    func route(to viewController: UIViewController, with transition: TransitionProtocol) {
        guard let root = root else { return }
        transition.open(viewController, from: root, completion: nil)
    }
    
    //for up-down single presentation
    func route(to viewController: UIViewController) {
        guard let root = root else { return }
        root.present(viewController, animated: true)
    }
}
