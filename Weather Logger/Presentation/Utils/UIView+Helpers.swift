//
//  UIView+Helpers.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 14/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import UIKit

protocol InitFromNib { }

extension InitFromNib where Self: UIView {
    
    static var viewIdentifier: String {
        return String(describing: self)
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: self.viewIdentifier, bundle: .main)
    }
    
    static func loadFromNib() -> Self {
        let view =  Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)![0] as! Self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
}

extension UIView: InitFromNib { }
