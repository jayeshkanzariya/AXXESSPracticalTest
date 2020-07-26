//
//  UIImageViewExtension.swift
//  AXXESSPracticalTest
//
//  Created by Jayesh on 24/07/20.
//  Copyright © 2020 Jayesh kanzariya. All rights reserved.
//

import UIKit
import Kingfisher
///// Extension of `UIImageView` that is used to extend the functions and properties.
extension UIImageView {
    /// It's used to set image to image view based on given string url with animation.
    /// - Parameters:
    ///     - url: instance of `String` that is used to store url link.
    func setImageWith(url: String, placeHolder: UIImage? = nil) {
        if url != "" {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: URL(string: url))
        } else {
           self.image = placeHolder
        }
    }
}
