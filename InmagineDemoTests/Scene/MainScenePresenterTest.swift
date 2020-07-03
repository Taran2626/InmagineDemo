//
//  MainScenePresenterTest.swift
//  InmagineDemoTests
//
//  Created by Taranjeet Kaur on 04/07/2020.
//  Copyright © 2020 Taranjeet Kaur. All rights reserved.
//

import XCTest
@testable import InmagineDemo

class MainScenePresenterTest: XCTestCase {

    let view = MainSceneViewMock()
    let canvasView = CanvasView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width), shape: .none)
    var viewController: MainViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: MainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        viewController = vc
        _ = viewController.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDrawSquaresForTwoByTwo() {
        //Given
        let presenter = MainScenePresenterImplementation(view: view, canvasView: canvasView)
        //When
        presenter.viewDidLoad()
        viewController.presenter = presenter
        viewController.drawTwobyTwoSquares(UIButton())
        canvasView.draw(canvasView.frame)
        //Then
        XCTAssertEqual(canvasView.layers.count, 4)
    }
    
    func testDrawSquaresForThreeByThree() {
        //Given
        let presenter = MainScenePresenterImplementation(view: view, canvasView: canvasView)
        //When
        presenter.viewDidLoad()
        viewController.presenter = presenter
        viewController.drawThreebyThreeSquares(UIButton())
        canvasView.draw(canvasView.frame)
         //Then
        XCTAssertEqual(canvasView.layers.count, 9)
    }
    
    func testIsImageLoaded() {
        
        //Given
        let presenter = MainScenePresenterImplementation(view: view, canvasView: canvasView)
        //When
        presenter.viewDidLoad()
        presenter.drawSquares(for: .threebythree)
        canvasView.draw(canvasView.frame)
        
        viewController.presenter = presenter
        viewController.btnLoadImage(UIButton())
        
        //Then
        let imageLayers = canvasView.layers.first?.sublayers
        XCTAssertEqual(imageLayers?.count, 1)
        XCTAssertNotNil(imageLayers?.first?.contents)

    }

}
