//
//  ViewController.swift
//  CleanNews
//
//  Created by Afees Lawal on 31/12/2021.
//

import UIKit

class BaseViewController<CustomView: UIView>: UIViewController {
    // MARK: - LifeCylce

    init(view: CustomView = CustomView()) {
        customView = view
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
        view.clipsToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViewControllerBehaviors()
        bindViews()
        setupViewActions()
        bindViewModel()
    }

    // MARK: - Internal

    let customView: CustomView

    func addViewControllerBehaviors() {}

    func setupViewActions() {}

    func bindViewModel() {}

    func bindViews() {}
}
