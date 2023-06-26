import Vapor
import Fluent
import PostgresKit

struct ResetController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.delete("reset", use: reset)
    }
    
    func reset(req: Request) async throws -> HTTPStatus {
        guard
            let auth = req.headers.first(name: "Authentication"),
            auth == "Reset-Force"
        else {
            throw Abort(.unauthorized)
        }
        try await SendEvent.query(on: req.db).delete()
        try await User.query(on: req.db).delete()
        return .ok
    }
}


fileprivate struct Point: Content {
    var point: Int
}
