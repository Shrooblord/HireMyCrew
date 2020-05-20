----Hire My Crew Copyright (C) 2020 Shrooblord

-- 1.  send list of required crew to Ship you give the Order to
-- 2.  divide each amount by either 1.5 (fill up Crew with profs right now) or 2.5 (fill up Crew with profs once they're fully levelled) based on a toggle in the UI
-- 3.  use this to generate a list of Crew that we're looking for
-- 4.  poll each Station in the Sector for what Crew you can hire there
-- 5.  do any of these match one or more of the types of Crew we're looking for?
-- 6.  do they still have Crew of that type available?
-- 7.  are they closer than other candidates?
-- 8.  go there
-- 9.  hire the Crew
-- 10. return to the Ship/Station from where this Order was given; get really close (<= 0.15 km)
-- 11. Transfer the Crew

--here's an example of how to add a new OrderChain entry from a different mod:
function OrderChain.addDiscoverWormholeOrder()
    if onClient() then
        invokeServerFunction("addDiscoverWormholeOrder")
        return
    end

    if callingPlayer then
        local owner, _, player = checkEntityInteractionPermissions(Entity(), AlliancePrivilege.ManageShips)
        if not owner then
            local player = Player(callingPlayer)
            player:sendChatMessage("", ChatMessageType.Error, "You don't have permission to do that."%_T)
            return
        end
    end

    local shipX, shipY = Sector():getCoordinates()

    for _, action in pairs(OrderChain.chain) do
        if action.action == OrderType.Jump or action.action == OrderType.FlyThroughWormhole then
            shipX = action.x
            shipY = action.y
        end
    end

    if callingPlayer then
        local player = Player(callingPlayer)
        if player:knowsSector(shipX, shipY) or player.alliance:knowsSector(shipX, shipY) then
            local sectorView = player:getKnownSector(shipX, shipY) or player.alliance:getKnownSector(shipX, shipY)

            local wormholeDestinations = {sectorView:getWormHoleDestinations()}
            for _, dest in pairs(wormholeDestinations) do
                local order = {action = OrderType.FlyThroughWormhole, x = dest.x, y = dest.y, gate = false}
                if OrderChain.canEnchain(order) then
                    OrderChain.enchain(order)
                end
                return
            end
        else
            OrderChain.sendError("Sector %i:%i has not been discovered yet."%_T, shipX, shipY)
            return
        end
    end

    OrderChain.sendError("No Wormhole found in Sector %i:%i!"%_T, shipX, shipY)
end
callable(OrderChain, "addDiscoverWormholeOrder")
