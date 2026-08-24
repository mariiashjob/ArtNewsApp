// NewsRepositoryProtocol.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 05.06.2026.

protocol NewsRepositoryProtocol {
    func fetchNews() async throws -> [ResponseArticle]
    func fetchNews(page: Int) async throws -> [ResponseArticle]
    func loadCachedNews() throws -> [Article]
}
