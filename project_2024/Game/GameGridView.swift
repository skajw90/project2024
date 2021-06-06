////
////  GameGridView.swift
////  project_2024
////
////  Created by 김태완 on 2021/05/19.
////
//
//import UIKit
//
//class GameGridView: UIView {
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        drawGridLayout(rect: rect)
//    }
//
//    func createNewNumber(at row: Int, column: Int, number: Int) {
//        let targetRect = getRectFrame(at: row, column: column)
//
//        let label = UILabel(frame: targetRect)
//        label.text = "\(number)"
//        label.textAlignment = .center
//        label.adjustsFontForContentSizeCategory = true
//        addSubview(label)
//    }
//
//    private func getRectFrame(at row: Int, column: Int) -> CGRect {
//        let width = bounds.width / CGFloat(5)
//        let height = bounds.height / CGFloat(5)
//
//        let originX = CGFloat(column) * width
//        let originY = CGFloat(row) * height
//
//        return CGRect(x: originX, y: originY, width: width, height: height)
//    }
//
//    private func drawGridLayout(rect: CGRect) {
//        let context = UIGraphicsGetCurrentContext()!
//        context.setStrokeColor(UIColor.black.cgColor)
//        context.setLineWidth(1)
//
////        for h in 0 ... 4 {
////            let horizontalOrigin = CGPoint(x: rect.minX, y: rect.minY + 1 / 4 * CGFloat(h) * rect.height)
////            let horizontalTo = CGPoint(x: rect.maxX, y: horizontalOrigin.y)
////
////            context.move(to: horizontalOrigin)
////            context.addLine(to: horizontalTo)
////        }
//
//        for y in 0 ... 5 {
//            let xpos = 0 + 1 / 5 * rect.width * CGFloat(y)
//            let ypos = 0 + 1 / 5 * rect.height * CGFloat(y)
//
//            context.move(to: CGPoint(x: xpos, y: 0))
//            context.addLine(to: CGPoint(x: xpos, y: rect.height))
//
//            context.move(to: CGPoint(x: 0, y: ypos))
//            context.addLine(to: CGPoint(x: rect.maxX, y: ypos))
//        }
////        context.move(to: CGPoint(x: 0, y: 0))
////        context.addLine(to: CGPoint(x: rect.width, y: 0))
////
////        context.move(to: CGPoint(x: 0, y: 0 + 1 / 4 * rect.height))
////        context.addLine(to: CGPoint(x: rect.width, y: 0 + 1 / 4 * rect.height))
////
////        context.move(to: CGPoint(x: 0, y: 0 + 2 / 4 * rect.height))
////        context.addLine(to: CGPoint(x: rect.width, y: 0 + 2 / 4 * rect.height))
////
////        context.move(to: CGPoint(x: 0, y: 0 + 3 / 4 * rect.height))
////        context.addLine(to: CGPoint(x: rect.width, y: 0 + 3 / 4 * rect.height))
////
////        context.move(to: CGPoint(x: 0, y: 0 + 4 / 4 * rect.height))
////        context.addLine(to: CGPoint(x: rect.width, y: 0 + 4 / 4 * rect.height))
//
////        context.move(to: CGPoint(x: 0, y: 0))
////        context.addLine(to: CGPoint(x: 0, y: rect.height))
////
////        context.move(to: CGPoint(x: 0 + 1 / 4 * rect.width, y: 0))
////        context.addLine(to: CGPoint(x: 1 / 4 * rect.width, y: rect.height))
////
////        context.move(to: CGPoint(x: 2 / 4 * rect.width, y: 0))
////        context.addLine(to: CGPoint(x: 2 / 4 * rect.width, y: rect.height))
////
////        context.move(to: CGPoint(x: 3 / 4 * rect.width, y: 0))
////        context.addLine(to: CGPoint(x: 3 / 4 * rect.width, y: rect.height))
////
////        context.move(to: CGPoint(x: rect.width, y: 0))
////        context.addLine(to: CGPoint(x: rect.width, y: rect.height))
//
//        context.strokePath()
////        context.move(to: CGPoint(x: 0, y: 0))
////        context.addLine(to: CGPoint(x: rect.width, y: 0))
////
//    }
//}

//
//  GameGridView.swift
//  project_2024
//
//  Created by Jiwon Nam on 5/19/21.
//

import UIKit

struct NumberLabelComponent {
    var column: Int
    var row: Int
    var value: Int
    var label: UILabel
}

// MARK: - Game Grid View

class GameGridView: UIView {
    let lineWidth: CGFloat = 2
    let division: Int = 5
    
    var numberLabels: [NumberLabelComponent] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawGridLayout(rect: rect)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - row: <#row description#>
    ///   - column: <#column description#>
    ///   - number: <#number description#>
    func createNewNumber(at row: Int, column: Int, number: Int) {
        let targetRect = getRectFrame(at: row, column: column)
        
        let label = UILabel(frame: targetRect)
        label.text = "\(number)"
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        addSubview(label)
        numberLabels.append(NumberLabelComponent(column: column, row: row, value: number, label: label))
    }
    
    func move(direction: ScrollDirection, complete: @escaping () -> Void) {
        switch direction {
        case .left: moveLeft(complete: complete)
        case .right: moveRight(complete: complete)
        case .up: moveUp(complete: complete)
        case .down: moveDown(complete: complete)
        }
    }
    
    func combineNumbers() {
        
    }
    
    func moveLabel(index: Int, column: Int, row: Int) {
        self.numberLabels[index].column = column
        self.numberLabels[index].row = row
        
        UIView.animate(withDuration: 0.5, animations: {
            self.numberLabels[index].label.frame = self.getRectFrame(at: row, column: column)
        })
    }
    
    
    private func moveLeft(complete: @escaping () -> Void) {
        for i in 0 ..< numberLabels.count {
            moveLabel(index: i, column: 0, row: numberLabels[i].row)
        }
    }
    
    private func moveRight(complete: @escaping () -> Void) {
        for i in 0 ..< numberLabels.count {
            moveLabel(index: i, column: division - 1, row: numberLabels[i].row)
        }
    }
    
    private func moveUp(complete: @escaping () -> Void) {
        for i in 0 ..< numberLabels.count {
            moveLabel(index: i, column: numberLabels[i].column, row: 0)
        }
    }
    
    private func moveDown(complete: @escaping () -> Void) {
        for i in 0 ..< numberLabels.count {
            moveLabel(index: i, column: numberLabels[i].column, row: division - 1)
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - row: <#row description#>
    ///   - column: <#column description#>
    /// - Returns: <#description#>
    private func getRectFrame(at row: Int, column: Int) -> CGRect {
        
        let lineWidths = CGFloat(division + 1) * lineWidth
        let diameter = (bounds.width - lineWidths) / CGFloat(division)
        let originX = CGFloat(column) * (diameter + lineWidth) + lineWidth
        let originY = CGFloat(row) * (diameter + lineWidth) + lineWidth
        
   
        return CGRect(
            origin: CGPoint(x: originX, y: originY),
            size: CGSize(width: diameter, height: diameter))
    }
    
    private func drawGridLayout(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(lineWidth)
        
        let yFrom = rect.minY + lineWidth / 2
        let yTo = rect.minY + rect.height - lineWidth / 2
        let height = yTo - yFrom
        
        let xFrom = rect.minX + lineWidth / 2
        let xTo = rect.minX + rect.width - lineWidth / 2
        let width = xTo - xFrom
        for i in 0 ..< division + 1 {
            let xOrigin = CGPoint(x: rect.minX, y: 1 / CGFloat(division) * CGFloat(i) * height + yFrom)
            let xLineTo = CGPoint(x: rect.maxX, y: xOrigin.y)
            
            context.move(to: xOrigin)
            context.addLine(to: xLineTo)
            
            let yOrigin = CGPoint(x: 1 / CGFloat(division) * CGFloat(i) * width + xFrom, y: rect.minY)
            let yLineTo = CGPoint(x: yOrigin.x, y: rect.maxY)
            
            context.move(to: yOrigin)
            context.addLine(to: yLineTo)
        }
        
        context.strokePath()
    }
    
}
