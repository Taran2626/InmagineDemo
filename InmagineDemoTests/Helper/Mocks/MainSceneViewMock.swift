//
//  MainSceneViewMock.swift
//  InmagineDemoTests
//
//  Created by Taranjeet Kaur on 04/07/2020.
//  Copyright © 2020 Taranjeet Kaur. All rights reserved.
//

import UIKit
@testable import InmagineDemo

class MainSceneViewMock: MainSceneView {
    
    var canvasView: UIView?
    
    func setCanvas(view: UIView) {
        canvasView = view
    }
    
    var isLoadImageButtonEnabled: Bool = false
    var isFiltersButtonEnabled: Bool = false
    
}
