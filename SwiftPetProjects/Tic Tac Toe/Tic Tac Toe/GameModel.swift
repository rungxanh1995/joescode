//
//  GameModel.swift
//  Tic Tac Toe
//
//  Created by Joe Pham on 2021-05-02.
//

import SwiftUI

enum Player {
	case human
	case computer
}

struct Move {
	let player: Player
	let boardIndex: Int
	var indicator: String {
		return player == .human ? "xmark" : "circle"
	}
}

struct GameCircleView: View {
	var proxy: GeometryProxy
	var body: some View {
		Circle()
			.foregroundColor(.red).opacity(0.9)
			.frame(width: proxy.size.width / 3 - 15, height: proxy.size.width / 3 - 15)
	}
}

struct PlayerIndicator: View {
	var systemImageName: String
	var body: some View {
		Image(systemName: systemImageName)
			.resizable()
			.foregroundColor(.white)
			.frame(width: 40, height: 40)
	}
}
