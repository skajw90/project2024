//
//  GameViewController.swift
//  project_2024
//
//  Created by 김태완 on 2021/05/19.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var gameView: GameGridView!
    let viewModel = GameViewMoel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()

        
//        for _ in 0 ... 10 {
//            viewModel.createRandomNum()
//        }
//        print(viewModel.numbers)
    }
    private func configuration() {
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(gameViewScroll))
        gameView.addGestureRecognizer(gesture)
        viewModel.createRandomNum()
        gameView.layoutIfNeeded()

        guard let newNum = viewModel.newNumber else { return }
        gameView.createNewNumber(at: newNum.row, column: newNum.column, number: newNum.number)
    }
    
    @objc func gameViewScroll(gesture: UIPanGestureRecognizer) {
        let verticalVelocity = gesture.velocity(in: gameView).y
        let horizontalVelocity = gesture.velocity(in: gameView).x
        
        let threshold: CGFloat = 100
        
        if abs(verticalVelocity) > abs(horizontalVelocity) && abs(verticalVelocity) > threshold {
            if viewModel.move(direction: verticalVelocity < 0 ? .up : .down) {
                gameView.move(direction: verticalVelocity < 0 ? .up : .down)
                
                viewModel.createRandomNum()
                
                guard let newNum = viewModel.newNumber else { return }
                gameView.createNewNumber(at: newNum.row, column: newNum.column, number: newNum.number)
            }
            
        } else if abs(horizontalVelocity) > abs(verticalVelocity) && abs(horizontalVelocity) > threshold {
            if viewModel.move(direction: horizontalVelocity < 0 ? .left : .right) {
                gameView.move(direction: horizontalVelocity < 0 ? .left : .right)
                
                viewModel.createRandomNum()
                
                guard let newNum = viewModel.newNumber else { return }
                gameView.createNewNumber(at: newNum.row, column: newNum.column, number: newNum.number)
            }
        }
    }
}
