//
//  ViewController.swift
//  TutApp
//
//  Created by jishnu b on 11/02/16.
//  Copyright © 2016 jishnu b. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var startPoint = CGPoint()
    var animationLayer = CALayer()
    var path = UIBezierPath()
    var penLayer : CALayer?
    let pathLayer = CAShapeLayer()
    
    
    @IBOutlet var btn: UIButton!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(animated: Bool) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            startPoint = touch.locationInView(self.view)
            path.moveToPoint(startPoint)
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            let currentPoint = touch.locationInView(self.view)
            path.addLineToPoint(currentPoint)           
            CreateAndReturnPathLayerOnVC(path)
        }
        
    }
    
    func CreateAndReturnPathLayerOnVC( path:UIBezierPath){
        
        pathLayer.frame =  self.view.layer.bounds
        pathLayer.bounds = self.view.layer.bounds
        pathLayer.geometryFlipped = false;
        pathLayer.path = path.CGPath;
        pathLayer.strokeColor =  UIColor.blackColor().CGColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 3.0
        pathLayer.lineJoin = kCALineJoinMiter
        self.view.layer.addSublayer(pathLayer)
        
    }
    
}

