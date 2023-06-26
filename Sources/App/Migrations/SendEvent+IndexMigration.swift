import Fluent
import FluentPostgresDriver

extension SendEvent {
    struct IndexMigration: AsyncMigration {
        
        static let schema = "send_events"
        
        func prepare(on database: Database) async throws {
            let sql = database as! SQLDatabase
            _ = try await sql.raw("CREATE INDEX from_username_index ON \(raw: Self.schema) (from_username)").all();
            _ = try await sql.raw("CREATE INDEX to_username_index   ON \(raw: Self.schema) (to_username)").all();
            _ = try await sql.raw("CREATE INDEX created_at_index    ON \(raw: Self.schema) (created_at)").all();
        }
        
        func revert(on database: Database) async throws {
            let sql = database as! SQLDatabase
            _ = try await sql.raw("DROP INDEX from_username_index").all();
            _ = try await sql.raw("DROP INDEX to_username_index").all();
            _ = try await sql.raw("DROP INDEX created_at_index").all();
        }
    }
}
