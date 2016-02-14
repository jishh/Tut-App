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
    var pathLayer:CAShapeLayer?
    var isFromQuestionLabel = false
    //var pathLayer = CAShapeLayer()

    
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var firstAnswerLabel: UILabel!
    @IBOutlet var secondtAnswerLabel: UILabel!
    @IBOutlet var thirdAnswerLabel: UILabel!
    @IBOutlet var fourthAnswerLabel: UILabel!
    
    
    //MARK: VC lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setAspectFitContentModeForAllLabels()
       // setUpPathLayer()
    }
    override func viewDidAppear(animated: Bool) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpPathLayer(){
        pathLayer = CAShapeLayer()
    }
    //MARK: touch delegates
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if (touches.count == 1) // Single touches only
        {
            if let touch = touches.first
            {
                StartTracingBezierPathFromTouchesBegan(touch)
                
            }
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first
        {
            ExecuteDrawingOntouchesMoved(touch)
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first
        {
            
            CompleteDrawingOntouchesEnded(touch)
        }
        
    }
    
    //MARK: Draw Line From  Question To Answer
    
    
    func AddPathToShapeLayerAndView(BezierPath path:UIBezierPath, WithColor color:UIColor  ){
        removePathLayer()
        setUpPathLayer()
        pathLayer!.frame =  self.view.layer.bounds
        pathLayer!.bounds = self.view.layer.bounds
        pathLayer!.geometryFlipped = false;
        pathLayer!.path = path.CGPath;
        pathLayer!.strokeColor =  color.CGColor
        pathLayer!.fillColor = nil
        pathLayer!.lineWidth = 3.0
        pathLayer!.lineJoin = kCALineJoinMiter
        self.view.layer.addSublayer(pathLayer!)
        
    }
    
    //MARK: Touch logic for drawing
    
    
    func StartTracingBezierPathFromTouchesBegan(touch:UITouch){
        removePathLayer()
        setUpPathLayer()
        startPoint = touch.locationInView(self.view)
        if ( IsPointIsIncludedInFrame(Frame: questionLabel.frame, Point: startPoint)){
            path.moveToPoint(startPoint)
            isFromQuestionLabel = true
            
        }
        
    }
    
    
    func ExecuteDrawingOntouchesMoved(touch:UITouch){
        
        

        if ( isFromQuestionLabel == true)
        {
            let currentPoint = touch.locationInView(self.view)
            path.addLineToPoint(currentPoint)
            AddPathToShapeLayerAndView(BezierPath: path, WithColor: UIColor.blackColor())
        }
        
        
    }
    
    
    func CompleteDrawingOntouchesEnded(touch:UITouch)
    {
        isFromQuestionLabel = false
        let endPoint = touch.locationInView(self.view)
        GetChosenAnswerID(FromEndPoint: endPoint)
        removePathLayer()
    }
    
    
    
    //MARK: UI
    
    func setAspectFitContentModeForAllLabels(){
        MakeContentModeForLabel(questionLabel, contentMode: .ScaleAspectFit)
        MakeContentModeForLabel(firstAnswerLabel, contentMode: .ScaleAspectFit)
        MakeContentModeForLabel(secondtAnswerLabel, contentMode: .ScaleAspectFit)
        MakeContentModeForLabel(thirdAnswerLabel, contentMode: .ScaleAspectFit)
        MakeContentModeForLabel(fourthAnswerLabel, contentMode: .ScaleAspectFit)
    }
    
    //MARK:     Get Ans ID

    func GetChosenAnswerID( FromEndPoint endTouchPoint:CGPoint)->ChosenAnswerID
    {
        
        if ( IsPointIsIncludedInFrame(Frame: firstAnswerLabel.frame, Point: endTouchPoint))
        {
            chosenAnswerID = .First
            firstAnswerLabel.backgroundColor = UIColor.grayColor()
        }
        else if ( IsPointIsIncludedInFrame(Frame: secondtAnswerLabel.frame, Point: endTouchPoint))
        {
            chosenAnswerID = .Second
            secondtAnswerLabel.backgroundColor = UIColor.grayColor()

        }
            
        else if ( IsPointIsIncludedInFrame(Frame: thirdAnswerLabel.frame, Point: endTouchPoint))
        {
            chosenAnswerID = .Third
            thirdAnswerLabel.backgroundColor = UIColor.grayColor()

        }
        else if ( IsPointIsIncludedInFrame(Frame: fourthAnswerLabel.frame, Point: endTouchPoint))
        {
            chosenAnswerID = .Fourth
            fourthAnswerLabel.backgroundColor = UIColor.grayColor()

        }
        else {
            chosenAnswerID = .None
        }
        
        return chosenAnswerID
    }
    
    
    
    
    func removePathLayer()
    {
        if var pathLayerObj = pathLayer {
            pathLayer!.removeFromSuperlayer()
 
        }
        
        
        
    }
    
    
    
}

