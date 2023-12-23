//
//  FinalMovieQuizTests.swift
//  FinalMovieQuizTests
//
//  Created by Никита Долгов on 23.12.23.
//

import XCTest

@testable import MovieQuiz

final class FinalMovieQuizTests: XCTestCase {
    
    final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
        
        func showImageBorder() {
            
        }
        
        func disableButtons() {
            
        }
        
        func enableButtons() {
            
        }
        
        func deleteImageBorder() {
            
        }
        
        func imageToNil() {
            
        }
        
        func show(quiz step: QuizStepViewModel) {
            
        }
        
        func show(quiz result: QuizResultsViewModel) {
            
        }
        
        func highlightImageBorder(isCorrectAnswer: Bool) {
            
        }
        
        func showLoadingIndicator() {
            
        }
        
        func hideLoadingIndicator() {
            
        }
        
        func showNetworkError(message: String) {
            
        }
    }
    
    final class MovieQuizPresenterTests: XCTestCase {
        func testPresenterConvertModel() throws {
            let viewControllerMock = MovieQuizViewControllerMock()
            let sut = MovieQuizPresenter(viewController: viewControllerMock)
            
            let emptyData = Data()
            let question = QuizQuestion(image: emptyData, text: "Question Text", correctAnswer: true)
            let viewModel = sut.convert(model: question)
            
            XCTAssertNotNil(viewModel.image)
            XCTAssertEqual(viewModel.question, "Question Text")
            XCTAssertEqual(viewModel.questionNumber, "1/10")
        }
        
        
    }
}
