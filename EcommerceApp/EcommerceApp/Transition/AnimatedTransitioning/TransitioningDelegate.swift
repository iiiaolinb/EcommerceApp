import UIKit

final class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented,
                               presenting: presenting ?? source
        )
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? { PresentAnimatedTransitioning() }


    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? { DismissAnimatedTransitioning() }
}
