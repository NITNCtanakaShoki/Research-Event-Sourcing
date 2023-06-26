import Fluent
import FluentPostgresDriver

extension SendEvent {
    struct IndexMigration: AsyncMigration {
        
        func prepare(on database: Database) async throws {
            let sql = database as! SQLDatabase
            _ = try await sql.raw("CREATE INDEX send_events_from_username_index ON send_events (from_username)").all();
            _ = try await sql.raw("CREATE INDEX send_events_to_username_index ON send_events (to_username)").all();
            _ = try await sql.raw("CREATE INDEX send_events_created_at_index ON send_events (created_at)").all();
        }
        
        func revert(on database: Database) async throws {
            let sql = database as! SQLDatabase
            _ = try await sql.raw("DROP INDEX send_events_from_username_index").all();
            _ = try await sql.raw("DROP INDEX send_events_to_username_index").all();
            _ = try await sql.raw("DROP INDEX send_events_created_at_index").all();
        }
    }
}
