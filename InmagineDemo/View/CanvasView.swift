//
//  CanvasView.swift
//  InmagineDemo
//
//  Created by Taranjeet Kaur on 03/07/2020.
//  Copyright © 2020 Taranjeet Kaur. All rights reserved.
//

import UIKit

class CanvasView : UIView {
    
    var shape: Shape = .none
    var padding: CGFloat = 50.0
    var layers = [CAShapeLayer]()
    
    init(frame: CGRect, shape: Shape) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemGray6
        self.shape = shape
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        switch shape {
        case .twoBytwo:
            drawTwoByTwoSquares()
        case .threebythree:
            drawThreeByThreeSquares()
        case .none:
            return
        }
    }
    
    private func drawTwoByTwoSquares() {
        _ = layers.map { $0.removeFromSuperlayer() }
        layers = []
        let width = (frame.width - padding * 3)/2
        for i in  0...3 {
            let x = i % 2 == 0 ? padding : frame.width/2 + padding/2
            let y = i % 3 == 0 ? padding : padding * 2 + width
            layers.append(SquareImplementation(x: x,
                                               y: y,
                                               width: width,
                                               height: width)
                .drawShape())
        }
        
        _ = layers.map { layer.addSublayer($0) }
        
    }
    
    private func drawThreeByThreeSquares() {
        _ = layers.map { $0.removeFromSuperlayer() }
        layers = []
        let width = (frame.width - padding * 4)/3
        let centerLine = padding * 2 + width
        let lastLine = padding * 3 + width * 2
        
        for i in  0...8 {
            let x = i % 3 == 0 ? padding : i % 3 == 1 ? centerLine : lastLine
            let y = 0...2 ~= i ? padding : 3...5 ~= i ? centerLine : lastLine
            layers.append(SquareImplementation(x: x,
                                               y: y,
                                               width: width,
                                               height: width)
                .drawShape())
        }
        
        _ = layers.map { layer.addSublayer($0) }
        
    }
    
}
