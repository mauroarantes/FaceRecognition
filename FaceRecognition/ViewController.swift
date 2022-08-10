//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Mauro Arantes on 09/08/2022.
//

import UIKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let image = UIImage(named: "sample1") else { return }
        let imageView = UIImageView(image: image)
        
        let scaledHeight = view.frame.width / image.size.width * image.size.height
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: scaledHeight)
        imageView.backgroundColor = .orange
        
        view.addSubview(imageView)
        
        let request = VNDetectFaceRectanglesRequest { req, err in
            
            if let err = err {
                print("Failed to detect faces:", err)
                return
            }
            
//            print(req)
            
            req.results?.forEach({ res in
//                print(res)
                
                guard let faceObservation = res as? VNFaceObservation else { return }
                
                let x = self.view.frame.width * faceObservation.boundingBox.origin.x
                let width = self.view.frame.width * faceObservation.boundingBox.width
                let height = scaledHeight * faceObservation.boundingBox.height
                let y = scaledHeight * (1 - faceObservation.boundingBox.origin.y) - height + imageView.frame.origin.y
                
                let redView = UIView()
                redView.backgroundColor = .red
                redView.alpha = 0.4
                redView.frame = CGRect(x: x, y: y, width: width, height: height)
                self.view.addSubview(redView)
                
                print(faceObservation.boundingBox)
            })
        }
        
        guard let cgImage = image.cgImage else { return }
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
            
        } catch let reqErr {
            print("Failed to perform request:", reqErr)
        }
    }


}

