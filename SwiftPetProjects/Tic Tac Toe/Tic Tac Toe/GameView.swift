//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Joe Pham on 2021-05-01.
//

import SwiftUI

struct GameView: View {
	@StateObject private var viewModel = GameViewModel()
	
    var body: some View {
		GeometryReader { geometry in
			VStack {
				Spacer()
				LazyVGrid(columns: viewModel.columns, spacing: 5) {
					ForEach(0..<9) { i in
						ZStack {
							GameCircleView(proxy: geometry)
							PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
						}
						.onTapGesture {
							viewModel.processPlayerMove(for: i)
							if viewModel.isGameboardDisabled { self.hapticOnTap() }
						}
					}
				}
				Spacer()
			}
			.disabled(viewModel.isGameboardDisabled)
			.padding()
			.alert(item: $viewModel.alertItem) { alertItem in
				Alert(title: alertItem.title,
					  message: alertItem.message,
					  dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() }))
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		GameView()
    }
}

