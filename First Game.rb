require 'ruby2d'

set title: "Speed Bootcamp", resizeable: false, background: 'white',
    height: 600, width: 600, borderless: true

#All Variables
start = false
time = duration = nil

circl = Circle.new(
    x: 300, y: 300,
    radius: 250, z: -1,
    color: 'white' )

reddot = Circle.new(
    x: 300, y: 300,
    radius: 5, z: 0,
    color: 'red', opacity: 0.5 )
    
coin = Sprite.new(
    'Coin.png',
    clip_width: 84,
    width: 30, height: 30,
    x: rand(circl.x),
    y: rand(circl.y),
    time: 200, loop: true, z: 0
)

Image.new(
    'Gun.png', z: 1,
    width: Window.width,
    height: Window.height,
)

reddot.remove
circl.remove
coin.remove

#All Texts
message = Text.new( "Reaction Test > Shoot the Coin!", size: 15, x: 6, y: 6, z: 2 )
message2 = Text.new( "Click to Start / 'ESC' to Close Window", size: 15, x: 6, y: 25, z: 2 )

#All Events
on :key_down do |event|
    event.key == "escape" ? exit : ""
end

on :mouse_down do |event|
    if start
        if coin.contains?(reddot.x, reddot.y)
            
            duration = ((Time.now - time)).round(3)
            message = Text.new( "Splendid! #{duration} seconds!     **Gamer Reaction Time is about .215ms", size: 15,
                x: 6, y: 6, z: 2 )
            message2 = Text.new( "Place the Cursor at the Center and Try Again.",
                size: 15, x: 6, y: 25, z: 2 )
            
            coin.remove
            start = false
        end

    else
        
        message.remove
        message2.remove
        
        coin = Sprite.new(
            'Coin.png',
            clip_width: 84, width: 30, height: 30,
            x: rand(100..500), y: rand(100..500),
            time: 200, loop: true )
        
        coin.play

        circl.add
        reddot.add
        start = true
        time = Time.now
        
        on :mouse_move do |movement|
            coin.x -= (movement.delta_x / 1.5)
            coin.y -= (movement.delta_y / 1.5)
        end
    end
end

#Render
show