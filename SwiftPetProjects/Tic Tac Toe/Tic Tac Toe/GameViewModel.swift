//
//  GameViewModel.swift
//  Tic Tac Toe
//
//  Created by Joe Pham on 2021-05-02.
//

import SwiftUI

final class GameViewModel: ObservableObject {
	let columns: [GridItem] = [GridItem(.flexible()),
							   GridItem(.flexible()),
							   GridItem(.flexible())]
	
	@Published var moves: [Move?] = Array(repeating: nil, count: 9) // initial empty game board
	@Published var isGameboardDisabled = false
	@Published var alertItem: AlertItem?
	
	private let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
	
	func processPlayerMove(for position: Int) {
		// Process human move
		if isCircleOccupied(in: moves, forIndex: position) { return }
		moves[position] = Move(player: .human, boardIndex: position)
		
		if checkWinCondition(for: .human, in: moves) {
			alertItem = AlertContext.humanWin
			return
		}
		if checkForDraw(in: moves) {
			alertItem = AlertContext.draw
			return
		}
		isGameboardDisabled = true
		
		// Process computer move
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
			let computerPosition = determineComputerMovePosition(in: moves)
			moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
			isGameboardDisabled = false
			
			if checkWinCondition(for: .computer, in: moves) {
				alertItem = AlertContext.computerWin
				return
			}
			if checkForDraw(in: moves) {
				alertItem = AlertContext.draw
				return
			}
		}
	}
	
	func isCircleOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
		return moves.contains(where: {$0?.boardIndex == index})
	}
	
	func determineComputerMovePosition(in moves: [Move?]) -> Int {
		
		// If AI can win, then win
		let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
		let computerPositions = Set(computerMoves.map { $0.boardIndex })
		
		for pattern in winPatterns {
			let winPositions = pattern.subtracting(computerPositions)
			if winPositions.count == 1 {
				let isAvailable = !isCircleOccupied(in: moves, forIndex: winPositions.first!)
				if isAvailable { return winPositions.first! }
			}
		}
		
		// If AI can't win, then block
		let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
		let humanPositions = Set(humanMoves.map { $0.boardIndex })
		
		for pattern in winPatterns {
			let winPositions = pattern.subtracting(humanPositions)
			if winPositions.count == 1 {
				let isAvailable = !isCircleOccupied(in: moves, forIndex: winPositions.first!)
				if isAvailable { return winPositions.first! }
			}
		}
		
		// If AI can't block, then take middle circle
		let centerCircle = 4
		if !isCircleOccupied(in: moves, forIndex: centerCircle) {
			return centerCircle // when center circle is available
		}
		
		// If AI can't take middle circle, take random available circle
		var movePosition = Int.random(in: 0..<9)
		while isCircleOccupied(in: moves, forIndex: movePosition) {
			movePosition = Int.random(in: 0..<9)
		}
		return movePosition
	}
	
	func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
		let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
		let playerPositions = Set(playerMoves.map { $0.boardIndex })
		
		for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
			return true
		}
		return false
	}
	
	func checkForDraw(in moves: [Move?]) -> Bool {
		return moves.compactMap { $0 }.count == 9
	}
	
	func resetGame() {
		moves = Array(repeating: nil, count: 9)
	}
}
