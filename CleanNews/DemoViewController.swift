//
//  DemoViewController.swift
//  CleanNews
//
//  Created by Afees Lawal on 01/01/2022.
//

import UIKit

final class DemoViewController: BaseViewController<DemoView> {
    var isChanged = false

    override func addViewControllerBehaviors() {
        addBehaviors([NavigationBarStyleBehavior(barStyle: .light)])
    }

    override func setupViewActions() {
        customView.changeStatusStyleButton.addTarget(self, action: #selector(didChangedStatusBar), for: .touchUpInside)
    }

    @objc private func didChangedStatusBar() {
        addBehaviors([NavigationBarStyleBehavior(barStyle: isChanged ? .light : .dark)])
        customView.configWith(text: isChanged ? "Light Status bar" : "Dark Status bar")
        isChanged.toggle()
    }
}

final class DemoView: BaseView {
    private enum Constants {
        static let changeStatusStyleButtonHeight: CGFloat = 40
        static let changeStatusStyleButtonWidth: CGFloat = 80
        static let textLabelTopSpacing: CGFloat = 10
    }

    private(set) lazy var changeStatusStyleButton = UIButton.create {
        $0.setTitle("Change", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
    }

    private lazy var textLabel = UILabel.create {
        $0.text = "Light Status bar"
    }

    override func setupViewHeirachy() {
        addSubviews([changeStatusStyleButton, textLabel])
    }

    override func setupConstraints() {
        setupAutoLayout()
    }

    override func setupProperties() {
        backgroundColor = .red
    }

    func configWith(text: String) {
        textLabel.text = text
    }
}

// MARK: - AutoLayout

extension DemoView {
    func setupAutoLayout() {
        changeStatusStyleButton.constraintToConstant(
            CGSize(width: Constants.changeStatusStyleButtonWidth, height: Constants.changeStatusStyleButtonHeight)
        )
        changeStatusStyleButton.constraintCenterToSuperview()

        textLabel.topAnchor.constraint(
            equalTo: changeStatusStyleButton.bottomAnchor,
            constant: Constants.textLabelTopSpacing
        ).isActive = true
        textLabel.constraintCenter(to: self, axis: [.horizontal])
    }
}
