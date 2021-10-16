local function onSegment(px, py, qx, qy, rx, ry)
    if (qx <= math.max(px, rx) and qx >= math.min(px, rx) and qy <= math.max(py, ry) and qy >= math.min(py, ry)) then
        return true
    end
    return false
end

local function orientation(px, py, qx, qy, rx, ry)
    local val = (qy - py) * (rx - qx) - (qx - px) * (ry - qy)
    if val == 0 then return 0 end
    if val > 0 then return 1 else return 2 end
end

local function doIntersect(p1x, p1y, q1x, q1y, p2x, p2y, q2x, q2y)
    local o1 = orientation(p1x, p1y, q1x, q1y, p2x, p2y)
    local o2 = orientation(p1x, p1y, q1x, q1y, q2x, q2y)
    local o3 = orientation(p2x, p2y, q2x, q2y, p1x, p1y)
    local o4 = orientation(p2x, p2y, q2x, q2y, q1x, q1y)
    if o1 ~= o2 and o3 ~= o4 then return true end
    if o1 == 0 and onSegment(p1x, p1y, p2x, p2y, q1x, q1y) then return true end
    if o2 == 0 and onSegment(p1x, p1y, q2x, q2y, q1x, q1y) then return true end
    if o3 == 0 and onSegment(p2x, p2y, p1x, p1y, q2x, q2y) then return true end
    if o4 == 0 and onSegment(p2x, p2y, q1x, q1y, q2x, q2y) then return true end
    return false
end

local function rotated_rectangle_collision_detection(ax, ay, bx, by, cx, cy, dx, dy, ex, ey, fx, fy, gx, gy, hx, hy)
    if doIntersect(ax, ay, bx, by, ex, ey, fx, fy) or 
       doIntersect(ax, ay, bx, by, gx, gy, fx, fy) or 
       doIntersect(ax, ay, bx, by, gx, gy, hx, hy) or 
       doIntersect(ax, ay, bx, by, ex, ey, hx, hy) or 
       doIntersect(bx, by, cx, cy, ex, ey, fx, fy) or 
       doIntersect(bx, by, cx, cy, gx, gy, fx, fy) or 
       doIntersect(bx, by, cx, cy, gx, gy, hx, hy) or 
       doIntersect(bx, by, cx, cy, ex, ey, hx, hy) or 
       doIntersect(cx, cy, dx, dy, ex, ey, fx, fy) or 
       doIntersect(cx, cy, dx, dy, gx, gy, fx, fy) or 
       doIntersect(cx, cy, dx, dy, gx, gy, hx, hy) or 
       doIntersect(cx, cy, dx, dy, ex, ey, hx, hy) or 
       doIntersect(ax, ay, dx, dy, ex, ey, fx, fy) or 
       doIntersect(ax, ay, dx, dy, gx, gy, fx, fy) or 
       doIntersect(ax, ay, dx, dy, gx, gy, hx, hy) or 
       doIntersect(ax, ay, dx, dy, ex, ey, hx, hy) then return true else return false end
end
