import Vapor
import FluentProvider
import HTTP

final class Ticket: Model {
    let storage = Storage()
    
    // MARK: Properties and database keys
    
    /// The content of the Ticket
    var imageUrl: String
    var eventName: String
    var location: String
    var date: String
    var time: String
    var runningTime: String
    var description: String
    var couponCode: String
    
    /// The column names for `id` and `content` in the database
    struct Keys {
        static let id = "id"
        static let imageUrl = "imageUrl"
        static let eventName = "eventName"
        static let location = "location"
        static let date = "date"
        static let time = "time"
        static let runningTime = "runningTime"
        static let description = "description"
        static let couponCode = "couponCode"
    }
    
    /// Creates a new Ticket
    init(imageUrl: String, eventName: String, location: String, date: String
        , time: String, runningTime: String, description: String, couponCode: String) {
        self.imageUrl = imageUrl
        self.eventName = eventName
        self.location = location
        self.date = date
        self.time = time
        self.runningTime = runningTime
        self.description = description
        self.couponCode = couponCode
    }
    
    // MARK: Fluent Serialization
    
    /// Initializes the Ticket from the
    /// database row
    init(row: Row) throws {
        imageUrl = try row.get(Ticket.Keys.imageUrl)
        eventName = try row.get(Ticket.Keys.eventName)
        location = try row.get(Ticket.Keys.location)
        date = try row.get(Ticket.Keys.date)
        time = try row.get(Ticket.Keys.time)
        runningTime = try row.get(Ticket.Keys.runningTime)
        description = try row.get(Ticket.Keys.description)
        couponCode = try row.get(Ticket.Keys.couponCode)
    }
    
    // Serializes the Ticket to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Ticket.Keys.imageUrl, imageUrl)
        try row.set(Ticket.Keys.eventName, eventName)
        try row.set(Ticket.Keys.location, location)
        try row.set(Ticket.Keys.date, date)
        try row.set(Ticket.Keys.time, time)
        try row.set(Ticket.Keys.runningTime, runningTime)
        try row.set(Ticket.Keys.description, description)
        try row.set(Ticket.Keys.couponCode, couponCode)
        return row
    }
}

extension Ticket: Preparation {
    /// Prepares a table/collection in the database
    /// for storing Tickets
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Ticket.Keys.imageUrl)
            builder.string(Ticket.Keys.eventName)
            builder.string(Ticket.Keys.location)
            builder.string(Ticket.Keys.date)
            builder.string(Ticket.Keys.time)
            builder.string(Ticket.Keys.runningTime)
            builder.string(Ticket.Keys.description)
            builder.string(Ticket.Keys.couponCode)
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

// MARK: JSON

// How the model converts from / to JSON.
// For example when:
//     - Creating a new Ticket (POST /Tickets)
//     - Fetching a Ticket (GET /Tickets, GET /Tickets/:id)
//
extension Ticket: JSONConvertible {
    convenience init(json: JSON) throws {
        self.init(
            imageUrl: try json.get(Ticket.Keys.imageUrl),
            eventName: try json.get(Ticket.Keys.eventName),
            location: try json.get(Ticket.Keys.location),
            date: try json.get(Ticket.Keys.date),
            time: try json.get(Ticket.Keys.time),
            runningTime: try json.get(Ticket.Keys.runningTime),
            description: try json.get(Ticket.Keys.description),
            couponCode: try json.get(Ticket.Keys.couponCode)
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Ticket.Keys.id, id)
        try json.set(Ticket.Keys.imageUrl, imageUrl)
        try json.set(Ticket.Keys.eventName, eventName)
        try json.set(Ticket.Keys.location, location)
        try json.set(Ticket.Keys.date, date)
        try json.set(Ticket.Keys.time, time)
        try json.set(Ticket.Keys.runningTime, runningTime)
        try json.set(Ticket.Keys.description, description)
        try json.set(Ticket.Keys.couponCode, couponCode)
        return json
    }
}
