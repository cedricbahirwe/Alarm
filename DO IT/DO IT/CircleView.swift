//
//  CircleView.swift
//  DO IT
//
//  Created by Cedric Bahirwe on 8/2/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import Foundation
import  UIKit


struct Angle {
    let startAngle: CGFloat
    let endAngle: CGFloat
    var color: UIColor
    var duration: Double
}


class MonochromeView: UIView {
    
    var data = Angle(startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), color: .systemBlue, duration: 10.0)
    
    private var pointToDraw: CGFloat = 1
    private var numberOfArcsToBeDrawn = 1
    
    
    private let arcStartAngleInDegrees: CGFloat = 0
    private let totalArcArea: CGFloat = 360
    
    private let outerArclineWidth: CGFloat = 7
    var animationDuration: Double = 60 {
        didSet {
            configureView(with: 1)
        }
    }
    private var previousStartAngle: CGFloat = 0.0
    private var currentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        configureView(with: 0)
    }
    
    private func calculateDurationSlots() {
        let percentage = animationDuration / Double(pointToDraw*100)
            if pointToDraw < data.endAngle && pointToDraw > data.startAngle {
                print("Got here")
                let difference = pointToDraw*100-data.startAngle*100
                let duration = Double(difference) * percentage
                data.duration = duration
            } else {
                print("Got there")
                let difference = data.endAngle*100 - data.startAngle*100
                let duration = Double(difference) * percentage
                data.duration = duration
            }
    }
    
    private func drawCircles() {
            let layer = CAShapeLayer()
            let currentData = data
            layer.path = self.createRectangle(startAngle: getRadians(previousStartAngle), endAngle: getRadians(data.endAngle))
            previousStartAngle = data.endAngle
            layer.lineWidth = outerArclineWidth-2
            layer.strokeColor = data.color.cgColor
            
            layer.fillColor = UIColor.clear.cgColor
            layer.name = "innerCircle\(currentIndex)"
            self.layer.addSublayer(layer)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = currentData.duration
            animation.delegate = self
            layer.add(animation, forKey: "end_\(currentIndex)")
            currentIndex = currentIndex + 1
    }
    
    private func getRadians(_ point: CGFloat) -> CGFloat {
        return (totalArcArea*point)+arcStartAngleInDegrees
    }
    
    public func configureView(with point: CGFloat) {
        resetViews()
        pointToDraw = point
        calculateDurationSlots()
        drawCircles()
    }
    
    private func createRectangle(startAngle: CGFloat, endAngle: CGFloat) -> CGPath {
        // Initialize the path.
        return UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: self.frame.size.height/2-(outerArclineWidth/2), startAngle: CGFloat(270).toRadians(), endAngle: CGFloat(-270).toRadians(), clockwise: false).cgPath
    }
    
    private func resetViews() {
        pointToDraw = 1
        numberOfArcsToBeDrawn = 0
        currentIndex = 0
        previousStartAngle = 0.0
    }
}

extension MonochromeView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        drawCircles()
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
