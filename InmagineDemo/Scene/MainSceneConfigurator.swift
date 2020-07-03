//
//  MainSceneConfigurator.swift
//  InmagineDemo
//
//  Created by Taranjeet Kaur on 03/07/2020.
//  Copyright © 2020 Taranjeet Kaur. All rights reserved.
//

import UIKit

protocol MainSceneConfigurator {
    func configure(viewController: MainViewController)
}

class MainSceneConfiguratorImplementation: MainSceneConfigurator {
    
    func configure(viewController: MainViewController) {
        let canvasView = CanvasView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width), shape: .none)
        let presenter = MainScenePresenterImplementation(view: viewController, canvasView: canvasView)
        viewController.presenter = presenter
    }
    
}
