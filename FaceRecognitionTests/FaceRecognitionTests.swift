//
//  FaceRecognitionTests.swift
//  FaceRecognitionTests
//
//  Created by Mauro Arantes on 09/08/2022.
//

import XCTest
@testable import FaceRecognition

class FaceRecognitionTests: XCTestCase {
    
    var viewController: ViewController!

    override func setUp() {
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController
    }
    
    func testFaceCount_invalidPicture_countIsZero() {
        //given
        let image = "photo"
        
        //when
        let fc = viewController.faceCount(image: image)
        //then
        XCTAssertEqual(fc, 0)
    }
    
    func testFaceCount_Sample1_countIsOne() {
        //given
        let image = "sample1"
        
        //when
        let fc = viewController.faceCount(image: image)
        //then
        XCTAssertEqual(fc, 1)
    }
    
    func testFaceCount_Sample2_countIsEight() {
        //given
        let image = "sample2"
        
        //when
        let fc = viewController.faceCount(image: image)
        //then
        XCTAssertEqual(fc, 8)
    }
}
