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

    redirect_to characters_path(cr: @critical, p: @target, d: 1, dmg: @dmg)
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

  private
  def char_params
    # require params(blah)
  end
end
