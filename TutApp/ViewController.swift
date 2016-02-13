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
    var isFromQuestionLabel = false
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var firstAnswerLabel: UILabel!
    @IBOutlet var secondtAnswerLabel: UILabel!
    @IBOutlet var thirdAnswerLabel: UILabel!
    @IBOutlet var fourthAnswerLabel: UILabel!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        questionLabel.contentMode = .ScaleAspectFit
        questionLabel.backgroundColor = UIColor.redColor()
    }
    override func viewDidAppear(animated: Bool) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if (touches.count == 1) // Single touches only
        {
            
            if let touch = touches.first {
                startPoint = touch.locationInView(self.view)
                
                if (CGRectContainsPoint(questionLabel.frame, startPoint)){
                    path.moveToPoint(startPoint)
                    isFromQuestionLabel = true
                    
                }
            }
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            if ( isFromQuestionLabel == true)
            {
                let currentPoint = touch.locationInView(self.view)
                path.addLineToPoint(currentPoint)
                AddPathToShapeLayerAndView(BezierPath: path, WithColor: UIColor.blackColor())
            }
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            isFromQuestionLabel = false

          //  let endPoint = touch.locationInView(self.view)
            
            
        }
        
        
        
    }
    
    
    
    func AddPathToShapeLayerAndView(BezierPath path:UIBezierPath, WithColor color:UIColor  ){
        
        pathLayer.frame =  self.view.layer.bounds
        pathLayer.bounds = self.view.layer.bounds
        pathLayer.geometryFlipped = false;
        pathLayer.path = path.CGPath;
        pathLayer.strokeColor =  color.CGColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 3.0
        pathLayer.lineJoin = kCALineJoinMiter
        self.view.layer.addSublayer(pathLayer)
        
    }
    
}

