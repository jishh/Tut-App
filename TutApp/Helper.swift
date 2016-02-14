
//
//  Helper.swift
//  TutApp
//
//  Created by jishnu b on 11/02/16.
//  Copyright © 2016 jishnu b. All rights reserved.
//

import Foundation
import UIKit


//MARK: Selected answer id

 enum ChosenAnswerID  {
    
    case First// slow at beginning and end
    case Second // slow at beginning
    case Third // slow at end
    case Fourth
    case None
}

var chosenAnswerID = ChosenAnswerID.None


func DrawLine( From from:CGPoint, To to:CGPoint, WithColor color:UIColor ,OnView view:UIView){
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)
   // UIGraphicsBeginImageContext(view.frame.size);
    let  context = UIGraphicsGetCurrentContext()
    var currentColor =  UIColor.blackColor()
    CGContextSetStrokeColorWithColor(context, currentColor.CGColor)
    CGContextSetLineWidth(context, 2.0)
    CGContextBeginPath(context)
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
    

}


func CreatePathLayerAndPenLayerAndAddAnimation(OnLayer layer:CALayer  ,ForVC viewController:UIViewController, ForPath  path:UIBezierPath){
    //create layers
 //   let pathLayer = CreateAndReturnPathLayer(OnLayer: layer :path)
    
    let pathLayer = CreateAndReturnPathLayer(OnLayer: layer, path: path)
    let penLayer = CreatePenLayer(OnLayer:pathLayer )
    
    //add animations
    AddAnimationToPathLayer(pathLayer)
    AddAnimationToPenLayer(WithPathLayer:pathLayer , ForVC: viewController)
}




func CreateAndReturnPathLayer(OnLayer layer:CALayer  , path:UIBezierPath)->CAShapeLayer{
    
    let pathLayer = CAShapeLayer()
    pathLayer.frame =  layer.bounds
   // pathLayer.bounds =  CGPathGetBoundingBox(path.CGPath)
    pathLayer.bounds = layer.bounds
    pathLayer.geometryFlipped = false;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor =  UIColor.blackColor().CGColor
    pathLayer.fillColor = nil
    pathLayer.lineWidth = 3.0
    pathLayer.lineJoin = kCALineJoinBevel
    layer.addSublayer(pathLayer)
    return pathLayer
    
}


func CreatePenLayer(OnLayer layer:CAShapeLayer){
    
    let  penImage = UIImage(named: "pen")
    let penLayer = CALayer()
    penLayer.contents = penImage?.CGImage
    penLayer.anchorPoint = CGPointZero
    penLayer.frame =  CGRectMake(0, 0, (penImage?.size.width)!, (penImage?.size.height)!)
    layer.addSublayer(penLayer)
}


func AddAnimationToPathLayer(layer:CALayer){
    
    let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
    pathAnimation.duration = 10.0
    pathAnimation.fromValue =    NSNumber(float: 0.0)
    pathAnimation.toValue =    NSNumber(float: 1.0)
    layer.addAnimation(pathAnimation, forKey: "strokeEnd")
    
}


func AddAnimationToPenLayer(WithPathLayer layer:CAShapeLayer ,  ForVC viewController:UIViewController){
    
    
    let penAnimation = CAKeyframeAnimation(keyPath: "position")
    penAnimation.duration = 10.0
    penAnimation.path = layer.path;
    penAnimation.calculationMode = kCAAnimationPaced;
    penAnimation.delegate = viewController
    layer.addAnimation(penAnimation, forKey: "position")
    
}

//func AppendCGMutablePathRefToUIBezierPath(ForString   pathString:String)->CGPath{
//
//
//    let  pathCreated = attributedTextObjC.getAttributedTextPath(pathString)
//    let path = UIBezierPath()
//    path.moveToPoint(CGPointZero)
//    path.appendPath(UIBezierPath(CGPath: pathCreated) )
//
//}

func MakeContentModeForLabel(label:UILabel, contentMode: UIViewContentMode){
    label.contentMode = contentMode
}
//MARK: Check is point included in frame
func IsPointIsIncludedInFrame( Frame frame:CGRect, Point point:CGPoint)->Bool
{
    
    if (CGRectContainsPoint(frame, point)){
        return true
    }
    return false
}


