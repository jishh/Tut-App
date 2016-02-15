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
    var path: UIBezierPath?
    var penLayer : CALayer?
    var pathLayer:CAShapeLayer?
    var isFromQuestionLabel = false
    
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var firstAnswerLabel: UILabel!
    @IBOutlet var secondtAnswerLabel: UILabel!
    @IBOutlet var thirdAnswerLabel: UILabel!
    @IBOutlet var fourthAnswerLabel: UILabel!
    
    
    //MARK: VC lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setAspectFillContentModeForAllLabels()
        // setAspectFitContentModeForAllLabels()
    }
    override func viewDidAppear(animated: Bool) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: touch delegates
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resetAllLabels()
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
    
    
    func AddPathToPathLayerAndView(BezierPath path:UIBezierPath, WithColor color:UIColor  ){
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
    
    func updatePathLayerPathOnTouchMoves(BezierPath path:UIBezierPath){
        pathLayer!.path = path.CGPath
        pathLayer?.setNeedsDisplay()
        //pathLayer?.removeFromSuperlayer()
        //self.view.layer.addSublayer(pathLayer!)
    }
    
    func setUpPathLayer(){
        pathLayer = CAShapeLayer()
    }
    
    func removePathLayer()
    {
        if let _ = pathLayer
        {
            pathLayer!.removeFromSuperlayer()
            // pathLayer = nil
        }
    }
    
    
    //MARK: Touch logic for drawing
    
    
    func StartTracingBezierPathFromTouchesBegan(touch:UITouch){
        
        startPoint = touch.locationInView(self.view)
        
        if ( IsPointIsIncludedInFrame(Frame: questionLabel.frame, Point: startPoint)){
            //create path
            path = UIBezierPath()
            path!.moveToPoint(startPoint)
            AddPathToPathLayerAndView(BezierPath: path!, WithColor: UIColor.blackColor())
            isFromQuestionLabel = true
        }
    }
    
    
    func ExecuteDrawingOntouchesMoved(touch:UITouch){
        
        if ( isFromQuestionLabel == true)
        {
            let currentPoint = touch.locationInView(self.view)
            path!.addLineToPoint(currentPoint)
            updatePathLayerPathOnTouchMoves(BezierPath:path!)
        }
        
        
    }
    
    
    func CompleteDrawingOntouchesEnded(touch:UITouch)
    {
        
        if (isFromQuestionLabel == true)
        {
            let endPoint = touch.locationInView(self.view)
            GetChosenAnswerID(FromEndPoint: endPoint)
            checkUserChosenAnswerWithDB()
            //reset bezier parh and CAshapelayer on toch ending
            path = nil
            removePathLayer()
            isFromQuestionLabel = false
        }
        
    }
    
    
    
    
    //MARK:     Get Ans ID After user finished touch(manage user selected answer)
    
    func GetChosenAnswerID( FromEndPoint endTouchPoint:CGPoint)->ChosenAnswerID
    {
        
        if ( IsPointIsIncludedInFrame(Frame: firstAnswerLabel.frame, Point: endTouchPoint))
        {
            userSelectedFirstAnswer()
        }
        else if ( IsPointIsIncludedInFrame(Frame: secondtAnswerLabel.frame, Point: endTouchPoint))
        {
            userSelectedSecondAnswer()
        }
            
        else if ( IsPointIsIncludedInFrame(Frame: thirdAnswerLabel.frame, Point: endTouchPoint))
        {
            userSelectedThirdAnswer()
        }
        else if ( IsPointIsIncludedInFrame(Frame: fourthAnswerLabel.frame, Point: endTouchPoint))
        {
            userSelectedFourthAnswer()
        }
        else {
            chosenAnswerID = .None
        }
        
        return chosenAnswerID
    }
    
    func userSelectedFirstAnswer(){
        chosenAnswerID = .First
        firstAnswerLabel.backgroundColor = UIColor.grayColor()
    }
    func userSelectedSecondAnswer(){
        chosenAnswerID = .Second
        secondtAnswerLabel.backgroundColor = UIColor.grayColor()
        
    }
    func userSelectedThirdAnswer(){
        chosenAnswerID = .Third
        thirdAnswerLabel.backgroundColor = UIColor.grayColor()
    }
    func userSelectedFourthAnswer(){
        chosenAnswerID = .Fourth
        fourthAnswerLabel.backgroundColor = UIColor.grayColor()
    }
    
    
    func checkUserChosenAnswerWithDB(){
        //for now say answer b is true here. Take the correct value from db later
        if (chosenAnswerID == .Second) {
            showAlert("Correct Answer", message: "Congrats. You chose the right answer", InViewControler: self)
        }
        else  if (chosenAnswerID != .None){
            showAlert("Sorry!. wrong Answer", message: "It was wrong answer", InViewControler: self)
            
        }
    }
    
    
    //MARK: UI
    
    func setAspectFitContentModeForAllLabels(){
        MakeContentModeForLabel(questionLabel, contentMode: .ScaleAspectFit)
        MakeContentModeForLabel(firstAnswerLabel, contentMode: .ScaleAspectFit)
        MakeContentModeForLabel(secondtAnswerLabel, contentMode: .ScaleAspectFit)
        MakeContentModeForLabel(thirdAnswerLabel, contentMode: .ScaleAspectFit)
        MakeContentModeForLabel(fourthAnswerLabel, contentMode: .ScaleAspectFit)
    }
    
    func setAspectFillContentModeForAllLabels(){
        MakeContentModeForLabel(questionLabel, contentMode: .ScaleAspectFill)
        MakeContentModeForLabel(firstAnswerLabel, contentMode: .ScaleAspectFill)
        MakeContentModeForLabel(secondtAnswerLabel, contentMode: .ScaleAspectFill)
        MakeContentModeForLabel(thirdAnswerLabel, contentMode: .ScaleAspectFill)
        MakeContentModeForLabel(fourthAnswerLabel, contentMode: .ScaleAspectFill)
    }
    func resetAllLabels(){
        firstAnswerLabel.backgroundColor = UIColor.clearColor()
        secondtAnswerLabel.backgroundColor = UIColor.clearColor()
        thirdAnswerLabel.backgroundColor = UIColor.clearColor()
        fourthAnswerLabel.backgroundColor = UIColor.clearColor()
        
    }
}

