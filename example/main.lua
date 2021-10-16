local rect1 = {}
rect1.angle = 0
rect1.centerX = 200
rect1.centerY = 200
rect1.width = 64*3
rect1.height = 48*3
rect1.dia = math.sqrt(rect1.width*rect1.width + rect1.height + rect1.height)/2
rect1.x1Angle = math.atan2(rect1.centerY - (rect1.centerY - rect1.height/2), rect1.centerX - (rect1.centerX + rect1.width/2))
rect1.x2Angle = math.atan2(rect1.centerY - (rect1.centerY - rect1.height/2), rect1.centerX - (rect1.centerX - rect1.width/2))
rect1.x1 = rect1.centerX + math.cos(rect1.x1Angle + rect1.angle)*rect1.dia
rect1.x2 = rect1.centerX + math.cos(rect1.x2Angle + rect1.angle)*rect1.dia
rect1.x3 = rect1.centerX + math.cos(rect1.x1Angle + rect1.angle - math.pi)*rect1.dia
rect1.x4 = rect1.centerX + math.cos(rect1.x2Angle + rect1.angle - math.pi)*rect1.dia
rect1.y1 = rect1.centerY + math.sin(rect1.x1Angle + rect1.angle)*rect1.dia
rect1.y2 = rect1.centerY + math.sin(rect1.x2Angle + rect1.angle)*rect1.dia
rect1.y3 = rect1.centerY + math.sin(rect1.x1Angle + rect1.angle - math.pi)*rect1.dia
rect1.y4 = rect1.centerY + math.sin(rect1.x2Angle + rect1.angle - math.pi)*rect1.dia
----
local rect2 = {}
rect2.angle = 0
rect2.centerX = 400
rect2.centerY = 400
rect2.width = 64*3
rect2.height = 48*3
rect2.dia = math.sqrt(rect2.width*rect2.width + rect2.height + rect2.height)/2
rect2.x1Angle = math.atan2(rect2.centerY - (rect2.centerY - rect2.height/2), rect2.centerX - (rect2.centerX + rect2.width/2))
rect2.x2Angle = math.atan2(rect2.centerY - (rect2.centerY - rect2.height/2), rect2.centerX - (rect2.centerX - rect2.width/2))
rect2.x1 = rect2.centerX + math.cos(rect2.x1Angle + rect2.angle)*rect2.dia
rect2.x2 = rect2.centerX + math.cos(rect2.x2Angle + rect2.angle)*rect2.dia
rect2.x3 = rect2.centerX + math.cos(rect2.x1Angle + rect2.angle - math.pi)*rect2.dia
rect2.x4 = rect2.centerX + math.cos(rect2.x2Angle + rect2.angle - math.pi)*rect2.dia
rect2.y1 = rect2.centerY + math.sin(rect2.x1Angle + rect2.angle)*rect2.dia
rect2.y2 = rect2.centerY + math.sin(rect2.x2Angle + rect2.angle)*rect2.dia
rect2.y3 = rect2.centerY + math.sin(rect2.x1Angle + rect2.angle - math.pi)*rect2.dia
rect2.y4 = rect2.centerY + math.sin(rect2.x2Angle + rect2.angle - math.pi)*rect2.dia

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

function love.update(dt)
    if love.keyboard.isDown("w") then
        rect1.centerY = rect1.centerY - 10
    elseif love.keyboard.isDown("a") then
        rect1.centerX = rect1.centerX - 10
    elseif love.keyboard.isDown("s") then
        rect1.centerY = rect1.centerY + 10
    elseif love.keyboard.isDown("d") then
        rect1.centerX = rect1.centerX + 10
    elseif love.keyboard.isDown("z") then
        rect1.angle = rect1.angle - math.pi/180
    elseif love.keyboard.isDown("c") then
        rect1.angle = rect1.angle + math.pi/180
    end
    
    if love.keyboard.isDown("up") then
        rect2.centerY = rect2.centerY - 10
    elseif love.keyboard.isDown("left") then
        rect2.centerX = rect2.centerX - 10
    elseif love.keyboard.isDown("down") then
        rect2.centerY = rect2.centerY + 10
    elseif love.keyboard.isDown("right") then
        rect2.centerX = rect2.centerX + 10
    elseif love.keyboard.isDown("b") then
        rect2.angle = rect2.angle - math.pi/180
    elseif love.keyboard.isDown("m") then
        rect2.angle = rect2.angle + math.pi/180
    end
    rect1.x1 = rect1.centerX + math.cos(rect1.x1Angle + rect1.angle)*rect1.dia
    rect1.x2 = rect1.centerX + math.cos(rect1.x2Angle + rect1.angle)*rect1.dia
    rect1.x3 = rect1.centerX + math.cos(rect1.x1Angle + rect1.angle - math.pi)*rect1.dia
    rect1.x4 = rect1.centerX + math.cos(rect1.x2Angle + rect1.angle - math.pi)*rect1.dia
    rect1.y1 = rect1.centerY + math.sin(rect1.x1Angle + rect1.angle)*rect1.dia
    rect1.y2 = rect1.centerY + math.sin(rect1.x2Angle + rect1.angle)*rect1.dia
    rect1.y3 = rect1.centerY + math.sin(rect1.x1Angle + rect1.angle - math.pi)*rect1.dia
    rect1.y4 = rect1.centerY + math.sin(rect1.x2Angle + rect1.angle - math.pi)*rect1.dia
    rect2.x1 = rect2.centerX + math.cos(rect2.x1Angle + rect2.angle)*rect2.dia
    rect2.x2 = rect2.centerX + math.cos(rect2.x2Angle + rect2.angle)*rect2.dia
    rect2.x3 = rect2.centerX + math.cos(rect2.x1Angle + rect2.angle - math.pi)*rect2.dia
    rect2.x4 = rect2.centerX + math.cos(rect2.x2Angle + rect2.angle - math.pi)*rect2.dia
    rect2.y1 = rect2.centerY + math.sin(rect2.x1Angle + rect2.angle)*rect2.dia
    rect2.y2 = rect2.centerY + math.sin(rect2.x2Angle + rect2.angle)*rect2.dia
    rect2.y3 = rect2.centerY + math.sin(rect2.x1Angle + rect2.angle - math.pi)*rect2.dia
    rect2.y4 = rect2.centerY + math.sin(rect2.x2Angle + rect2.angle - math.pi)*rect2.dia
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon("line", rect1.x1, rect1.y1, rect1.x2, rect1.y2, rect1.x3, rect1.y3, rect1.x4, rect1.y4)
    love.graphics.polygon("line", rect2.x1, rect2.y1, rect2.x2, rect2.y2, rect2.x3, rect2.y3, rect2.x4, rect2.y4)
    if rotated_rectangle_collision_detection(rect1.x1, rect1.y1, rect1.x2, rect1.y2, rect1.x3, rect1.y3, rect1.x4, rect1.y4, rect2.x1, rect2.y1, rect2.x2, rect2.y2, rect2.x3, rect2.y3, rect2.x4, rect2.y4) then
        love.graphics.setColor(1, 0, 0, 0.5)
    else
        love.graphics.setColor(0, 1, 0, 0.5)
    end
    love.graphics.polygon("fill", rect1.x1, rect1.y1, rect1.x2, rect1.y2, rect1.x3, rect1.y3, rect1.x4, rect1.y4)
    love.graphics.polygon("fill", rect2.x1, rect2.y1, rect2.x2, rect2.y2, rect2.x3, rect2.y3, rect2.x4, rect2.y4)
end