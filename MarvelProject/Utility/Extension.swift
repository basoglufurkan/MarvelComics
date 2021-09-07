//
//  Extension.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import Foundation
import UIKit
@_exported import SDWebImage

extension UIImageView{
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setImgWebUrl(url : URL, isIndicator : Bool){
        
        if isIndicator == true{
            self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        }
            self.sd_setImage(with: url, placeholderImage: UIImage(named: "default"), options: .lowPriority, progress: nil
            , completed: { (image, error, cacheType, url) in
                guard image != nil else {
                    return
                }
            })
    }
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
