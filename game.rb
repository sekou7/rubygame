require 'Gosu'
require 'Sprite'
require 'Background'

include Gosu

class Game < Gosu::Window
  def initialize
    # Game Window
    super(800, 600, false)
    # Backgrounds / Cursor
    @cursor = Gosu::Image.new(self, 'media/cursor.png')
    @menu = Background.new(self, 'media\\menu.png')
    # Text
    @title = Sprite.new(self, 'media\\title.png')
    # Character
    @stand_left = Sprite.new(self,'media\\Character/stand_left.png')
    @stand_right = Sprite.new(self,'media\\Character/stand_right.png')
    @walk_left = Sprite.new(self,'media\\Character/walk_left.png')
    @walk_right = Sprite.new(self,'media\\Character/walk_right.png')
    @shoot_left = Sprite.new(self,'media\\Character/shooting_left.png')
    @shoot_right = Sprite.new(self,'media\\Character/shooting_right.png')
    @stand_right.move_to(350, 445)
    @char = @stand_right
    # Game Detection
    @score = 0
    # Game Caption
    self.caption = "Zombie Shooter - Alpha - 0.1.0"
  end

  def update
    # Start Game
    if button_down? KbReturn
      @game_start = true
        @title.hide
    end
    # Updates Sprites
   if @game_start
    @stand_left.move_to(@char.x,@char.y)
    @stand_right.move_to(@char.x,@char.y)
    @walk_right.move_to(@char.x,@char.y)
    @walk_left.move_to(@char.x,@char.y)
    @shoot_left.move_to(@char.x, @char.y)
    @shoot_right.move_to(@char.x, @char.y)
    if @dir == :left then
      @char = @stand_left
    else
      @char = @stand_right
    end
    # Movement
    if button_down? KbD
      @char.adjust_xpos(4)
      @char = @walk_right
      @dir = :right
    elsif button_down? KbA
      @char.adjust_xpos(-4)
      @char = @walk_left
      @dir = :left
    elsif button_down? KbW
      @char.adjust_ypos(-10) # Idk why we need this?
    elsif button_down? KbSpace and @dir == :left
      @char = @shoot_left
    elsif button_down? KbSpace and @dir == :right
      @char = @shoot_right
    end
   end
   #END
  end

  def draw
    @menu.see(0,0,0,1,1.25)
    @title.draw
    @char.draw
    @cursor.draw(self.mouse_x, self.mouse_y, 0)
  end
end

Game.new.show
