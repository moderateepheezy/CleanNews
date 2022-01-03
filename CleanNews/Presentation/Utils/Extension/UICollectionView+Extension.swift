//
//  UICollectionView+Extension.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

extension UICollectionView {
    func dequeueCell<CellType: UICollectionViewCell>(ofType _: CellType.Type, for indexPath: IndexPath) -> CellType {
        let reuseIdentifier = "\(CellType.self)"
        let someCell = dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard let cell = someCell as? CellType else {
            fatalError("Could not dequeue cell of type \(CellType.self)")
        }
        return cell
    }

    func registerCell<CellType: UICollectionViewCell>(ofType _: CellType.Type) {
        let reuseIdentifier = "\(CellType.self)"
        register(CellType.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    func registerReusableView<ViewType: UICollectionReusableView>(ofType _: ViewType.Type, forKind kind: String) {
        let reuseIdentifier = "\(ViewType.self)"
        register(ViewType.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier)
    }

    func dequeueReusableView<ViewType: UICollectionReusableView>(ofType _: ViewType.Type, forKind kind: String, for indexPath: IndexPath) -> ViewType {
        let reuseIdentifier = "\(ViewType.self)"
        let someView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard let view = someView as? ViewType else {
            fatalError("Could not dequeue supplementary view of type \(ViewType.self)")
        }
        return view
    }
}
