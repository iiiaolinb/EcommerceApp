import UIKit

final class PresentationController: UIPresentationController {

    override var shouldPresentInFullscreen: Bool { false }

    private lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()

    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTap))
        return recognizer
    }()

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = containerView,
              let presentedView = presentedView else { return }

        presentedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(presentedView)
        
        dimmView.translatesAutoresizingMaskIntoConstraints = false
        containerView.insertSubview(dimmView, at: 0)
        
        dimmView.alpha = 0
        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 1
        }

        NSLayoutConstraint.activate([
                presentedView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                presentedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                presentedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                presentedView.heightAnchor.constraint(lessThanOrEqualTo: containerView.heightAnchor,
                                                      constant: -containerView.safeAreaInsets.top),
                dimmView.topAnchor.constraint(equalTo: containerView.topAnchor),
                dimmView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                dimmView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                dimmView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed { presentedView?.removeFromSuperview() }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 0
        }
    }

    private func performAlongsideTransitionIfPossible(_ animation: @escaping () -> Void ) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            animation()
            return
        }
      
        coordinator.animate { _ in
                animation()
        }
    }
}
