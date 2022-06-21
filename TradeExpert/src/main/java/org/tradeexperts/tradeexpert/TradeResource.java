package org.tradeexperts.tradeexpert;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

@Path("/hello-world")
public class TradeResource {
    @GET
    @Produces("text/plain")
    public String hello() {
        return "Hello, World!";
    }
}
