//
//  Square.swift
//  InmagineDemo
//
//  Created by Taranjeet Kaur on 03/07/2020.
//  Copyright © 2020 Taranjeet Kaur. All rights reserved.
//

import UIKit

protocol Square {
    func drawShape() -> CAShapeLayer
}

struct SquareImplementation: Square {

    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    func drawShape() -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let rect = CGRect(x: x, y: y, width: width, height: height)
        shapeLayer.path = UIBezierPath(rect: rect).cgPath
        shapeLayer.lineWidth = 2.0
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        return shapeLayer
    }
    
}
