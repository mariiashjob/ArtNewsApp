// NetworkError.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 05.06.2026.

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError
    case unknown
    
    var userMessage: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .decodingError: return "Data error"
        case .serverError: return "Server error"
        case .unknown: return "Sorry, something went wrong."
        }
    }
}


