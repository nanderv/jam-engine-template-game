return function(x, y, vx, vy, weight, r, g, b)
    return { position = { x = x, y = y, dynamic = true }, velocity = { x = vx, y = vy }, colour = { r = r, g = g, b = b }, weight = weight }
end