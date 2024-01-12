//
//  Extensions.swift
//  Stellroid
//
//  Created by Fanil_Jr on 20.12.2023.
//

import Foundation
import UIKit
import CoreImage

public extension UIColor {
    static func createColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor { ( traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? dark : light }
    }
}

public func waitingSpinnerEnable(activity: UIActivityIndicatorView, active: Bool) {
    if active {
        DispatchQueue.main.async {
            activity.startAnimating()
        }
    } else {
        DispatchQueue.main.async {
            activity.stopAnimating()
        }
    }
}

public func configureScroll(scroll: UIScrollView, pageControl: UIPageControl,with images: [String]) {
    let scrollViewWidth: CGFloat = scroll.frame.width
    let scrollViewHeight: CGFloat = scroll.frame.height
    
    for (index, image) in images.enumerated() {
        let imageView = CustomImageView(frame: CGRect(x: scrollViewWidth * CGFloat(index), y: 0, width: scrollViewWidth, height: scrollViewHeight))
        imageView.contentMode = .scaleToFill
        DispatchQueue.main.async {
            imageView.loadImage(urlString: image)
            scroll.addSubview(imageView)
        }
    }
    scroll.contentSize = CGSize(width: scroll.frame.width * CGFloat(images.count), height: scroll.frame.height)
    pageControl.numberOfPages = images.count
}

