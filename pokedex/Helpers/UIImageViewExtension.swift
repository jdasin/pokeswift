//
//  UIImageViewExtension.swift
//  pokedex
//
//  Created by Admin on 4/5/21.
//

import Foundation
import UIKit
extension UIImageView {
    func load(url: String, onLoad: ((UIImage) -> Void)?){
        if let imageUrl = URL(string: url) {
            load(url: imageUrl, onLoad: onLoad)
        }
    }
    
    func load(url: URL, onLoad: ((UIImage) -> Void)?) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        onLoad?(image)
                    }
                }
            }
        }
    }
}
