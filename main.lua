local loader = require('jam-engine/helpers/loadScripts')
local scripts = loader("scripts")
for k, v in pairs(scripts) do

    print(k)
    print(v)
end
local p1 = scripts.entities.planet(300, 300, 0, 30, 10, 1, 0, 0)
local s1 = scripts.entities.star(500, 310, 0, -10, 10, 1, 0, 0)

local sys = require("jam-engine/efs/construct")()
sys:addFilter("object", { "position.x", "position.x", "weight" })
sys:addFilter("movingObject", { "position.x", "position.x", "velocity.x", "velocity.y" })
sys:addFilter("drawableObject", { "_object", "colour.r", "colour.g", "colour.b" })
sys:addFilter("dynamicObject", { "_object", "position.dynamic" })

sys:addEntity(p1)
sys:addEntity(s1)

function love.update(dt)
    for _, v in ipairs(sys.filteredEntitiesAsLists["movingObject"]) do
        v.position.x = v.position.x + v.velocity.x * dt
        v.position.y = v.position.y + v.velocity.y * dt
    end
    for _, v in ipairs(sys.filteredEntitiesAsLists["dynamicObject"]) do
        for _, w in ipairs(sys.filteredEntitiesAsLists["object"]) do
            if v ~= w then
                local grav = v.weight * w.weight / 10 * dt
                local dx = v.position.x - w.position.x
                local dy = v.position.y - w.position.y

                local dist = math.sqrt(dx * dx + dy * dy)

                local ddx = dx/dist * grav
                local ddy = dy/dist * grav

                v.velocity.x = v.velocity.x-ddx
                v.velocity.y = v.velocity.y-ddy
            end
        end
    end
end

function love.draw()
    for _, v in ipairs(sys.filteredEntitiesAsLists["drawableObject"]) do
        love.graphics.setColor(v.colour.r, v.colour.g, v.colour.b)
        love.graphics.circle("fill", v.position.x, v.position.y, v.weight)
    end
end

