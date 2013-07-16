class GamesController < ApplicationController
  load_and_authorize_resource

  def show
    game = Game.find(params[:id])
    if params[:play]
    end
    params[:chain_to_keep] = params[:chain] == nil ? "" : params[:chain][:chain_to_keep].downcase
    params[:chain_to_remove] = params[:chain] == nil ? "" : params[:chain][:chain_to_remove].downcase

    @game = game
    @games = Game.order("updated_at").reverse
    @words = game.find(0, 50, params[:chain_to_keep], params[:chain_to_remove])
    @played = game.get_played_words
    game.touch
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @games = Game.order("updated_at").reverse
  end

  def new
    # default: render 'new' template
  end

  def create
    @game = Game.create!(:title => params[:game][:title].downcase, :title_ordered => params[:game][:title].chars.sort.join.downcase)
    @game.find_all
    @game.save
    flash[:notice] = "#{@game.title} was successfully created."
    redirect_to game_path(@game)
  end

  def edit
  end

  def update

  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    flash[:notice] = "Game '#{@game.title}' deleted."
    redirect_to games_path
  end

  def move_word
    @game = Game.find(params[:id])
    if params[:word] != nil and params[:word].length > 0
      @game.play params[:word]
    else
      @game.unplay params[:played]
    end
    @game.save
    redirect_to game_path(@game)
  end
end
