//
//  GameViewModel.swift
//  project_2024
//
//  Created by 김태완 on 2021/05/23.
//

enum ScrollDirection {
    case left
    case right
    case up
    case down
}

class GameViewMoel {
    var numbers: [[Int?]]
    
    var newNumber: (row: Int, column: Int, number: Int)?
    
    var isGameOver: Bool {
        get {
            for numbers in numbers {
                if numbers.contains(nil) {
                    return false
                }
            }
            return true
        }
    }
    
    init () {
        numbers = Array(repeating: Array(repeating: nil, count: 5), count: 5)
    }
    
    func createRandomNum() -> Bool {
        if isGameOver { return false }
        
        let randRow = Int.random(in: 0 ..< 5)
        let randCol = Int.random(in: 0 ..< 5)
        if numbers[randRow][randCol] != nil {
            return createRandomNum()  //recursive function
        }
        else {
            numbers[randRow][randCol] = 2
            newNumber = (randRow, randCol, 2)
            return true
        }
    }
    
    func move(direction: ScrollDirection) -> Bool {
        switch direction {
        case .up: return move()
        case .down: return move(needReverse: true)
        case .left: return move(needTranspose: true)
        case .right: return move(needReverse: true, needTranspose: true)
        }
    }
    
    func move(needReverse: Bool = false, needTranspose: Bool = false) -> Bool {
        var hasChanged = false
        if needTranspose { numbers = matrixTranspose(numbers) }
        
        for row in 0 ..< numbers.count {
            let temp: [Int?] = numbers[row].filter { $0 != nil }
            var result: [Int?] = combinedNumbers(target: needReverse ? temp.reversed() : temp, length: numbers[row].count)
            
            if needReverse { result = result.reversed() }
            //변화 체크
            if result != numbers[row] {
                numbers[row] = result
                hasChanged = true
            }
        }
        
        if needTranspose { numbers = matrixTranspose(numbers) }
        
        return hasChanged
    }
    
    private func combinedNumbers(target: [Int?], length: Int) -> [Int?] {
        if target.isEmpty {
            return Array(repeating: nil, count: length)
        }
        var result: [Int?] = []
        var i = 0
        while i < target.count {
            if i < target.count - 1 && target[i] == target[i + 1] {
                result.append(target[i]! * 2)
                i += 2
            } else {
                result.append(target[i])
                i += 1
            }
        }
        
        result.append(contentsOf: (Array(repeating: nil, count: length - result.count)))
        return result
    }
    
    private func matrixTranspose(_ matrix: [[Int?]]) -> [[Int?]] {
        if matrix.isEmpty { return matrix }
        var result = [[Int?]] ()
        for i in 0 ..< matrix.first!.count {
            result.append(matrix.map { $0[i] })
        }
        return result
    }
    
}
