//
//  GameGridView.swift
//  project_2024
//
//  Created by 김태완 on 2021/05/19.
//

import UIKit

class GameGridView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(1)
        
        for h in 0 ... 5 {
            let horizontalOrigin = CGPoint(x: rect.minX, y: rect.minY + 1 / 4 * CGFloat(h) * rect.height)
            let horizontalTo = CGPoint(x: rect.maxX, y: horizontalOrigin.y)
            
            context.move(to: horizontalOrigin)
            context.addLine(to: horizontalTo)
        }
        
        for y in 0 ... 4 {
            let xpos = 0 + 1 / 4 * rect.width * CGFloat(y)
            context.move(to: CGPoint(x: xpos, y: 0))
            context.addLine(to: CGPoint(x: xpos, y: rect.height))
        }
//        context.move(to: CGPoint(x: 0, y: 0))
//        context.addLine(to: CGPoint(x: 0, y: rect.height))
//
//        context.move(to: CGPoint(x: 0 + 1 / 4 * rect.width, y: 0))
//        context.addLine(to: CGPoint(x: 1 / 4 * rect.width, y: rect.height))
//
//        context.move(to: CGPoint(x: 2 / 4 * rect.width, y: 0))
//        context.addLine(to: CGPoint(x: 2 / 4 * rect.width, y: rect.height))
//
//        context.move(to: CGPoint(x: 3 / 4 * rect.width, y: 0))
//        context.addLine(to: CGPoint(x: 3 / 4 * rect.width, y: rect.height))
//
//        context.move(to: CGPoint(x: rect.width, y: 0))
//        context.addLine(to: CGPoint(x: rect.width, y: rect.height))
        
        context.strokePath()
//        context.move(to: CGPoint(x: 0, y: 0))
//        context.addLine(to: CGPoint(x: rect.width, y: 0))
//
//        context.strokePath()
    }
}
