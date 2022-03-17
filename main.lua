local utf8=require('utf8')
local gc=love.graphics
love.keyboard.setKeyRepeat(true)

local needDraw=true
local sel=1

local font=gc.setNewFont('res/font.ttf',40)
local str,text='',gc.newText(font,'')
gc.setDefaultFilter('linear','linear')

local data=require('res/list')
--[[
You need create list.lua like this:

/* list.lua */
local newImg=love.graphics.newImage
return{
    {
        head=newImg('head.png'),
        bar=newImg('body.png'),
        tail=newImg('tail.png'),
        textColor={.2,.2,.2},
        headX=180,  --barX
        headY=75,   --barY
        textX=170,  --stringX
        textY=95,   --stringY
        tailY=75,   --tailY
        tailLen=30, --tailLen
    },
    {
        ...
    },
    ...
}
]]

function love.keypressed(k)
    if k=='backspace'then
        local byteoffset = utf8.offset(str,-1)
        if byteoffset then
            str=string.sub(str,1, byteoffset-1)
        end
        needDraw=true
    elseif k=='tab'then
        if love.keyboard.isDown('lshift','rshift')then
            sel=(sel-2)%#data+1
        else
            sel=sel%#data+1
        end
        needDraw=true
    end
end
function love.textinput(c)
    str=str..c
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
            if name=='quit'then return 0 end
            love.handlers[name](a)
        end
        if needDraw then
            text=gc.newText(font,str)
            local d=data[sel]
            local barLen=math.max(text:getWidth(),30)-d.tailLen
            gc.clear(.92,.93,.96)
            gc.setColor(1,1,1)
            gc.draw(d.head,20,20)
            gc.draw(d.bar,d.headX,d.headY,nil,barLen,1)
            gc.draw(d.tail,d.headX+barLen,d.tailY)
            gc.setColor(d.textColor)
            gc.draw(text,d.textX,d.textY)
            gc.present()
            needDraw=false
        end
    end
end