import Fluent

extension SendEvent {
    static func point(of username: String, on db: Database) async throws -> Int {
        var point: Int = 0
        try await query(on: db)
            .group(.or) { $0
                .filter(\.$from.$id == username)
                .filter(\.$to.$id == username)
            }
            .sort(\.$createdAt)
            .chunk(max: 1024) { results in
                _ = results.map { result in
                    result.map { e in
                        if e.$to.id == username {
                            point += e.point
                        } else {
                            point -= e.point
                        }
                    }
                }
            }
        return point
    }
}
