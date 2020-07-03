//
//  MainViewController.swift
//  InmagineDemo
//
//  Created by Taranjeet Kaur on 03/07/2020.
//  Copyright © 2020 Taranjeet Kaur. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainSceneView {
    
    var configurator: MainSceneConfigurator! = MainSceneConfiguratorImplementation()
    var presenter: MainScenePresenter!
    
    var sampleImage = UIImage(named: "sampleImage")
    @IBOutlet weak var btnApplyFilters: UIButton!
    @IBOutlet weak var btnLoadImage: UIButton!
    
    var isFiltersButtonEnabled: Bool = false{
        didSet {
            btnApplyFilters.isHidden = !self.isFiltersButtonEnabled
        }
    }
    
    var isLoadImageButtonEnabled: Bool = false {
        didSet {
            btnLoadImage.isHidden = !self.isLoadImageButtonEnabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(viewController: self)
        self.presenter.viewDidLoad()
    }
    
    func setCanvas(view: UIView) {
        self.view.addSubview(view)
    }

    @IBAction func drawTwobyTwoSquares(_ sender: Any) {
        presenter.drawSquares(for: .twoBytwo)
        isFiltersButtonEnabled = false
    }
    
    @IBAction func drawThreebyThreeSquares(_ sender: Any) {
        presenter.drawSquares(for: .threebythree)
        isFiltersButtonEnabled = false
    }
    
    @IBAction func btnLoadImage(_ sender: Any) {
        presenter.loadImage(image: sampleImage)
    }
    
    @IBAction func btnApplyFilter(_ sender: Any) {
        presenter.applyFilters(to: sampleImage)
    }
}

