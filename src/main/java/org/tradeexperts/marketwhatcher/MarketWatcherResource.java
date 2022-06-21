package org.tradeexperts.marketwhatcher;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

@Path("/MarketWatcher")
public class MarketWatcherResource {
    @GET
    @Produces("text/plain")
    public String hello() {
        return "MarketWatcher,hello World!";
    }
}