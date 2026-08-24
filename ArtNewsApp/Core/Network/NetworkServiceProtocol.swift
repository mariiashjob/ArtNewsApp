// NetworkServiceProtocol.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 08.06.2026.

protocol NetworkServiceProtocol {
    func fetchNews() async throws -> [ResponseArticle]
    func fetchNews(page: Int) async throws -> [ResponseArticle]
}
