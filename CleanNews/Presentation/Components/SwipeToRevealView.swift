//
//  SwipeToRevealView..swift
//  CleanNews
//
//  Created by Afees Lawal on 09.01.22.
//

import UIKit

final class SwipeToRevealView: UIView {
    let visableView = UIView()
    var originalPoint: CGPoint!
    let maxSwipe: CGFloat

    @IBInspectable var swipeBufffer: CGFloat = 2.0
    @IBInspectable var highVelocity: CGFloat = 300.0

    private let originalXCenter: CGFloat = UIScreen.main.bounds.width / 2
    private var panGesture: UIPanGestureRecognizer!

    public var isPanGestureEnabled: Bool {
        get { panGesture.isEnabled }
        set(newValue) {
            panGesture.isEnabled = newValue
        }
    }

    init(maxSwipe: CGFloat) {
        self.maxSwipe = maxSwipe
        super.init(frame: .zero)
        setupViews()
        setupGesture()
    }

    private func setupViews() {
        addSubview(visableView)
        visableView.constraintToSuperviewEdges()
    }

    private func setupGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(swipe(_:)))
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
    }

    @objc func swipe(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let newXPosition = center.x + translation.x
        let velocity = sender.velocity(in: self)

        switch sender.state {
        case .changed:
            let shouldSwipeRight = translation.x > 0 && newXPosition < originalXCenter
            let shouldSwipeLeft = translation.x < 0 && newXPosition > originalXCenter - maxSwipe
            guard shouldSwipeRight || shouldSwipeLeft else { break }
            center.x = newXPosition
        case .ended:
            if -velocity.x > highVelocity {
                center.x = originalXCenter - maxSwipe
                break
            }
            guard center.x > originalXCenter - maxSwipe - swipeBufffer, center.x < originalXCenter - maxSwipe + swipeBufffer, velocity.x < highVelocity else {
                center.x = originalXCenter
                break
            }
        default:
            break
        }
        panGesture.setTranslation(.zero, in: self)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SwipeToRevealView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
        true
    }
}
