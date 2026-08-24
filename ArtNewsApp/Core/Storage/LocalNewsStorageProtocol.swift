// LocalNewsStorage.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 14.08.2026.

import Foundation

protocol LocalNewsStorageProtocol {
    func save(_ articles: [Article], for page: Int) throws
    func load(page: Int) throws -> [Article]
    func loadAll() throws -> [Article]
}
