//
//  AppError.swift
//  Core
//
//  Created by Abraham Putra Lukas on 05/09/25.
//

public struct AppError {
    public let title: String
    public let code: Int
    public let message: String

    // Public memberwise initializer
    public init(title: String, code: Int, message: String) {
        self.title = title
        self.code = code
        self.message = message
    }

    // Convenience initializer dari APIErrorResponse
    public init(apiError: APIErrorResponse) {
        self.title = apiError.error.title
        self.code = apiError.error.code
        self.message = apiError.error.message
    }
}


