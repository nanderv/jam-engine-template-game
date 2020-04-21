return function(x, y, dx, dy, weight, r, g, b)
    return { position = { x = x, y = y, dynamic = false }, velocity={x=dx, y=dy}, colour = { r = r, g = g, b = b }, weight = weight }
end