//
//  XibRegister.swift
//  AXXESSPracticalTest
//
//  Created by Jayesh on 24/07/20.
//  Copyright © 2020 Jayesh kanzariya. All rights reserved.
//

import Foundation
import UIKit
/// It's a protocol. that is responsible for re-use view related stuff.
protocol ReusableView: class {}
/// Extension of `ReusableView` that is used to extend the functions and properties.
extension ReusableView where Self: UIView {
    /// computed property that is used to get reuser identifier in form of `String`.
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
/// It's a protocol. that is responsible for nib-loadable view related stuff.
protocol NibLoadableView: class { }
/// Extension of `NibLoadableView` that is used to extend the functions and properties.
extension NibLoadableView where Self: UIView {
    /// computed property that is used to get nib name in form of `String`.
    static var NibName: String {
        return String(describing: self)
    }
}
/// Extension of `UITableView` that is used to extend the functions and properties.
extension UITableView {
    /// It's used to register `UITableViewCell`.
    /// - Parameters:
    ///     - type of the tableview cell.
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let Nib = UINib(nibName: T.NibName, bundle: nil)
        register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    /// It's used to register `UITableViewHeaderFooterView`.
    /// - Parameters:
    ///     - type of the tableview cell.
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let Nib = UINib(nibName: T.NibName, bundle: nil)
        register(Nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func cellForItemAtIndexPath<T>(indexPath : IndexPath,identifier : String = "\(T.self)") -> T{
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
/// Extension of `UICollectionView` that is used to extend the functions and properties.
extension UICollectionView {
    /// It's used to register `UICollectionViewCell`.
    /// - Parameters:
    ///     - type of the tableview cell.
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let Nib = UINib(nibName: T.NibName, bundle: nil)
        register(Nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func cellForItemAtIndexPath<T>(indexPath : IndexPath,identifier : String = "\(T.self)") -> T{
        return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
