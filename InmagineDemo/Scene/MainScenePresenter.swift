//
//  MainScenePresenter.swift
//  InmagineDemo
//
//  Created by Taranjeet Kaur on 03/07/2020.
//  Copyright © 2020 Taranjeet Kaur. All rights reserved.
//

import UIKit
import MetalPetal

enum Shape {
    case twoBytwo
    case threebythree
    case none
}

protocol MainSceneView: class {
    /* This method is to create canvas view depending on Screen
     400X400 wont be possible for all screen sizes.*/
    func setCanvas(view: UIView)
    // This variable is to unhide load image button after drawing the shapes.
    var isLoadImageButtonEnabled: Bool { get set }
    // This variable is to unhide apply filters button after loading the image.
    var isFiltersButtonEnabled: Bool { get set}
}

protocol MainScenePresenter {
    // This method is to draw squares of particular shape either 2X2 or 3X3.
    func drawSquares(for shape: Shape)
    // This method is to load images in squares.
    func loadImage(image: UIImage?)
    // This method is to apply image processing filters from MetalPetal Library.
    func applyFilters(to image: UIImage?)
    // Method to be called once the view is loaded.
    func viewDidLoad()
}

class MainScenePresenterImplementation: MainScenePresenter {
    
    private weak var view: MainSceneView?
    var canvasView: CanvasView
    
    init(view: MainSceneView, canvasView: CanvasView) {
        self.view = view
        self.canvasView = canvasView
    }
    
    func viewDidLoad() {
        view?.setCanvas(view: canvasView)
    }
    
    func drawSquares(for shape: Shape) {
        canvasView.shape = shape
        canvasView.setNeedsDisplay()
        view?.isLoadImageButtonEnabled = true
    }
    
    func loadImage(image: UIImage?) {
        guard let layer = canvasView.layers.first, let path = layer.path else { return }
        let imageLayer = CALayer()
        imageLayer.frame = UIBezierPath(cgPath: path).bounds
        imageLayer.contents = image?.cgImage
        layer.addSublayer(imageLayer)
        view?.isFiltersButtonEnabled = true
    }
    
}

extension MainScenePresenterImplementation {
    
    func applyFilters(to image: UIImage?) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let this = self, let cgImage = image?.cgImage else { return }
            let vibranceFilteredImage = this.applyVibranceFilter(MTIImage(cgImage: cgImage))
            let CLAHEFilteredImage = this.applyCLAHEFilter(vibranceFilteredImage)
            
            if let device = MTLCreateSystemDefaultDevice(), let context = try? MTIContext(device: device) {
                DispatchQueue.main.async { [weak self] in
                    do {
                        self?.loadImage(image: try UIImage(cgImage: context.makeCGImage(from: CLAHEFilteredImage)))
                    } catch {
                        debugPrint(error)
                    }
                }
            }
        }
    }
    
    private func applyVibranceFilter(_ image: MTIImage) -> MTIImage {
        let filter = MTIVibranceFilter()
        filter.amount = 2.0
        filter.inputImage = image
        guard let outputImage = filter.outputImage else { return image }
        return outputImage
    }
    
    private func applyCLAHEFilter(_ image: MTIImage) -> MTIImage  {
        let filter = MTICLAHEFilter()
        filter.clipLimit = 2.0
        filter.tileGridSize = MTICLAHESize(width: 8, height: 8)
        filter.inputImage = image
        guard let outputImage = filter.outputImage else { return image }
        return outputImage
    }
}
