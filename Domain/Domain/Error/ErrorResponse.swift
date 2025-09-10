//
//  ErrorResponse.swift
//  Core
//
//  Created by Abraham Putra Lukas on 04/09/25.
//

// data layer (parse JSON dari API)
public struct APIErrorResponse: Decodable {
    public let error: APIErrorDetail
}

public struct APIErrorDetail: Decodable {
    public let title: String
    public let code: Int
    public let message: String
}

