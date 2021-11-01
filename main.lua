local gc,utf8=love.graphics,require("utf8")
love.keyboard.setKeyRepeat(true)

local needDraw=true
local sel=1

local f=gc.setNewFont("font.ttf",40)
local s,t="",gc.newText(f,"")
gc.setDefaultFilter("linear","linear")

local S=require("list")
--[[
You need create list.lua like this:

/* list.lua */
local newImg=love.graphics.newImage
return{
    {
        head=newImg("head.png"),
        bar=newImg("body.png"),
        tail=newImg("tail.png"),
        textColor={.2,.2,.2},
        headX=180,    --barX
        headY=75,    --barY
        textX=170,    --stringX
        textY=95,    --stringY
        tailY=75,    --tailY
        tailLen=30,    --tailLen
    },
    {
        ...
    },
    ...
}
]]

function love.keypressed(k)
    if k=="backspace"then
        local byteoffset = utf8.offset(s,-1)
        if byteoffset then
            s=string.sub(s,1, byteoffset-1)
        end
        needDraw=true
    elseif k=="tab"then
        sel=sel%#S+1
        needDraw=true
    end
end
function love.textinput(c)
    s=s..c
    needDraw=true
end
function love.resize()
    needDraw=true
end
function love.run()
    -- gc.scale(.8)
    return function()
        love.event.pump()
        for name,a in love.event.poll()do
            if name=="quit"then return 0 end
            love.handlers[name](a)
        end
        if needDraw then
            t=gc.newText(f,s)
            local str=S[sel]
            local barLen=math.max(t:getWidth(),30)-str.tailLen
            gc.clear(.92,.93,.96)
            gc.setColor(1,1,1)
            gc.draw(str.head,20,20)
            gc.draw(str.bar,str.headX,str.headY,nil,barLen,1)
            gc.draw(str.tail,str.headX+barLen,str.tailY)
            gc.setColor(str.textColor)
            gc.draw(t,str.textX,str.textY)
            gc.present()
            needDraw=false
        end
    end
end