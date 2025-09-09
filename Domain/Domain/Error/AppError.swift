//
//  AppError.swift
//  Core
//
//  Created by Abraham Putra Lukas on 05/09/25.
//

// domain layer, 
public struct AppError {
    public let title: String
    public let code: Int
    public let message: String

    public init(title: String, code: Int, message: String) {
        self.title = title
        self.code = code
        self.message = message
    }

    public init(apiError: APIErrorResponse) {
        self.title = apiError.error.title
        self.code = apiError.error.code
        self.message = apiError.error.message
    }
}


