//
//  BaseView.swift
//  CleanNews
//
//  Created by Afees Lawal on 01/01/2022.
//

import UIKit

class BaseView: UIView {
    // MARK: - LifeCylce

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Internal

    var withAction: (() -> Void)? {
        didSet {
            guard withAction != nil else { return }
            isUserInteractionEnabled = true
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performAction)))
        }
    }

    func setupViewHeirachy() { abstractMethod() }

    @objc func setupConstraints() { abstractMethod() }

    func setupProperties() {}

    // MARK: - Private

    private func setupView() {
        backgroundColor = .white
        setupViewHeirachy()
        setupConstraints()
        setupProperties()
    }

    @objc private func performAction() {
        withAction?()
    }

    private func abstractMethod() -> Never {
        fatalError("this method should be overriden")
    }
}
