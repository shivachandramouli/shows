
import Vapor

class Router {
    
    var drop: Droplet!
    
    init(drop: Droplet) {
        
        self.drop = drop
        registerTicketRoutes(drop: drop)
    }
    
    func registerTicketRoutes(drop: Droplet) {
        
        let ticketController = TicketController(drop: drop)
        drop.post("addShowListings", handler: ticketController.addShows)
        drop.get("getShowListings", handler: ticketController.getShowListings)
    }
}
