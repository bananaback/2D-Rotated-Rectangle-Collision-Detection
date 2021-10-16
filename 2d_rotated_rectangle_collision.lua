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

local function rotated_rectangle_collision_detection(x1_1, y1_1, x2_1, y2_1, x3_1, y3_1, x4_1, y4_1,  x1_2, y1_2, x2_2, y2_2, x3_2, y3_2, x4_2, y4_2)
    if doIntersect(x1_1, y1_1, x2_1, y2_1, x1_2, y1_2, x2_2, y2_2) or 
       doIntersect(x1_1, y1_1, x2_1, y2_1, x3_2, y3_2, x2_2, y2_2) or 
       doIntersect(x1_1, y1_1, x2_1, y2_1, x3_2, y3_2, x4_2, y4_2) or 
       doIntersect(x1_1, y1_1, x2_1, y2_1, x1_2, y1_2, x4_2, y4_2) or 
       doIntersect(x2_1, y2_1, x3_1, y3_1, x1_2, y1_2, x2_2, y2_2) or 
       doIntersect(x2_1, y2_1, x3_1, y3_1, x3_2, y3_2, x2_2, y2_2) or 
       doIntersect(x2_1, y2_1, x3_1, y3_1, x3_2, y3_2, x4_2, y4_2) or 
       doIntersect(x2_1, y2_1, x3_1, y3_1, x1_2, y1_2, x4_2, y4_2) or 
       doIntersect(x3_1, y3_1, x4_1, y4_1, x1_2, y1_2, x2_2, y2_2) or 
       doIntersect(x3_1, y3_1, x4_1, y4_1, x3_2, y3_2, x2_2, y2_2) or 
       doIntersect(x3_1, y3_1, x4_1, y4_1, x3_2, y3_2, x4_2, y4_2) or 
       doIntersect(x3_1, y3_1, x4_1, y4_1, x1_2, y1_2, x4_2, y4_2) or 
       doIntersect(x1_1, y1_1, x4_1, y4_1, x1_2, y1_2, x2_2, y2_2) or 
       doIntersect(x1_1, y1_1, x4_1, y4_1, x3_2, y3_2, x2_2, y2_2) or 
       doIntersect(x1_1, y1_1, x4_1, y4_1, x3_2, y3_2, x4_2, y4_2) or 
       doIntersect(x1_1, y1_1, x4_1, y4_1, x1_2, y1_2, x4_2, y4_2) then return true else return false end
end