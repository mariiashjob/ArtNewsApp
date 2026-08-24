// LocalNewsStorage.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 19.08.2026.

import Foundation

final class LocalNewsStorage: LocalNewsStorageProtocol {
    private let fileManager = FileManager.default

    private var fileURL: URL {
        let directory = fileManager.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        )[0]

        if !fileManager.fileExists(atPath: directory.path) {
            try? fileManager.createDirectory(
                at: directory,
                withIntermediateDirectories: true
            )
        }

        return directory.appendingPathComponent("news_cache.json")
    }

    func save(_ articles: [Article], for page: Int) throws {
        var cachedPages = try loadPages()

        cachedPages[page] = articles

        let data = try JSONEncoder().encode(cachedPages)
        try data.write(to: fileURL, options: .atomic)
    }

    func load(page: Int) throws -> [Article] {
        let pages = try loadPages()
        return pages[page] ?? []
    }

    func loadAll() throws -> [Article] {
        let pages = try loadPages()

        return pages
            .keys
            .sorted()
            .compactMap { pages[$0] }
            .flatMap { $0 }
    }

    private func loadPages() throws -> [Int: [Article]] {
        guard fileManager.fileExists(atPath: fileURL.path) else {
            return [:]
        }

        let data = try Data(contentsOf: fileURL)

        return try JSONDecoder().decode(
            [Int: [Article]].self,
            from: data
        )
    }
}
