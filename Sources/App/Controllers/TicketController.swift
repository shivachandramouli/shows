import Vapor
import HTTP

final class TicketController {
    
    var drop: Droplet!
    
    init(drop: Droplet) {
        
        self.drop = drop
    }
    
    func addShows(_ request: Request) throws -> ResponseRepresentable {
     
        guard let imageUrl = request.data["imageUrl"]?.string else {
            return try JSON(node: [
                "error":"Please enter image Url"
                ])
        }
        
        guard let eventName = request.data["eventName"]?.string else {
            return try JSON(node: [
                "error":"Please enter event Name"
                ])
        }
        
        guard let location = request.data["location"]?.string else {
            return try JSON(node: [
                "error":"Please enter location"
                ])
        }
        
        guard let date = request.data["date"]?.string else {
            return try JSON(node: [
                "error":"Please enter date of the format MM/DD/YYYY"
                ])
        }
        
        guard let time = request.data["time"]?.string else {
            return try JSON(node: [
                "error":"Please enter time of the format 7:30 AM"
                ])
        }
        
        guard let runningTime = request.data["runningTime"]?.string else {
            return try JSON(node: [
                "error":"Please enter description of running time"
                ])
        }
        
        guard let description = request.data["description"]?.string else {
            return try JSON(node: [
                "error":"Please enter description"
                ])
        }
        
        guard let couponCode = request.data["couponCode"]?.string else {
            return try JSON(node: [
                "error":"Please enter coupon code"
                ])
        }
        
        let ticketListing = Ticket(imageUrl: imageUrl, eventName: eventName, location: location, date: date, time: time, runningTime: runningTime, description: description, couponCode: couponCode)
        
        try ticketListing.save()
        
        return try JSON(node: [
            "response" : "New Show Created"
            ]
        )
    }
    
    func getShowListings(_request : Request) throws -> ResponseRepresentable {
        
        return try JSON(node: [
            "listings" : Ticket.all().makeJSON()
            ]
        )
    }
}
