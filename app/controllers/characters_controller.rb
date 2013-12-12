class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(char_params)
    @character.assign_attributes(

      level: 1,
      gender: 'male',

      max_hp: 100,
      max_mp: 50,
      current_hp: 100,
      current_mp: 50, 
      stat_strength: 4 + rand(2), 
      stat_dex: 4 + rand(2), 
      stat_luck: 4 + rand(2), 
      stat_int: 4 + rand(2)
      )

    if current_user.selected_character
      @character.selected = false
    else
      @character.selected = true
    end

    if @character.save

      @character.attacks << Attack.find_by(title: 'punch')
      @character.attacks << Attack.find_by(title: 'kick')

      current_user.characters << @character

      redirect_to user_path(current_user.id), message: "Character Created!"
    else
      redirect_to user_path(current_user.id), message: "Could not create character"
    end

  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])
  end

  def destroy
    @character = Character.find(params[:id])
  end

  def attack

    @target = Character.find(params[:id])
    @base_dmg = 5
    @critical = true if rand > 0.8
    @dmg = (@base_dmg + rand(5))
    @dmg = (@dmg * 1.8).round if @critical

    @target.current_hp -= @dmg if @target.current_hp > 0

    @target.current_hp = 0 if @target.current_hp < 0

    @target.save

    # redirect_to characters_path(cr: @critical, p: @target, d: 1, dmg: @dmg)

    redirect_to :back
  end

  def reset
    @characters = Character.all

    @characters.each do |char|
      char.current_hp = char.max_hp
      char.current_mp = char.max_mp

      char.save
    end

    redirect_to :root
  end

  def select_character
    @character = Character.find(params[:id])

    current_user.select_character_id = @character.id
    current_user.save
  end

  private
  def char_params
    params.require(:character).permit(:name, :gender)
  end
end
