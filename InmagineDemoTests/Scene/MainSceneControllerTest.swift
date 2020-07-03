//
//  MainScenePresenterTest.swift
//  InmagineDemoTests
//
//  Created by Taranjeet Kaur on 04/07/2020.
//  Copyright © 2020 Taranjeet Kaur. All rights reserved.
//

import XCTest
@testable import InmagineDemo

class MainSceneControllerTest: XCTestCase {
    
    let view = MainSceneViewMock()
    let canvasView = CanvasView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width), shape: .none)
    var sampleImage = UIImage(named: "sampleImage")
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCanvasView() {
        //Given
        let presenter = MainScenePresenterImplementation(view: view, canvasView: canvasView)
        //When
        presenter.viewDidLoad()
        //Then
        XCTAssertNotNil(view.canvasView)
    }
    
    func testIsLoadImageButtonEnabled() {
        //Given
        let presenter = MainScenePresenterImplementation(view: view, canvasView: canvasView)
        //When
        presenter.viewDidLoad()
        presenter.drawSquares(for: .twoBytwo)
        //Then
        XCTAssertTrue(view.isLoadImageButtonEnabled)
        
    }
    
    func testIsFiltersButtonEnabled() {
        //Given
        let presenter = MainScenePresenterImplementation(view: view, canvasView: canvasView)
        //When
        presenter.viewDidLoad()
        presenter.drawSquares(for: .twoBytwo)
        canvasView.draw(canvasView.frame)
        presenter.loadImage(image: sampleImage)
        //Then
        XCTAssertTrue(view.isLoadImageButtonEnabled)
        XCTAssertTrue(view.isFiltersButtonEnabled)
        
    }
    
}
