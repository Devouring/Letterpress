class GamesController < ApplicationController
  @@chain_to_keep = ''
  @@chain_to_remove = ''
  before_filter :authenticate_user!
  def show
    @game = Game.find(params[:id])

    @words = @game.find(0, 50, @@chain_to_keep, @@chain_to_remove)

    params[:chain_to_keep] = @@chain_to_keep
    params[:chain_to_remove] = @@chain_to_remove
    @@chain_to_remove = ''
    @@chain_to_keep = ''
    @played = @game.get_played_words

    @game.touch
    @games = Game.order("updated_at").reverse

  # will render app/views/movies/show.<extension> by default
  end

  def index
    @games = Game.order("updated_at").reverse
  end

  def new
    # default: render 'new' template
  end

  def create
    @game = Game.create(:title => params[:game][:title].downcase, :title_ordered => params[:game][:title].chars.sort.join.downcase)
    if @game.valid?
      @game.find_all
      @game.save
      flash[:notice] = "#{@game.title} was successfully created."
      redirect_to game_path(@game)
    else
      flash[:danger] = @game.errors[:title]
      redirect_to games_path
    end

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

  def filter
    @game = Game.find(params[:id])
    if params[:play] != nil
      @game.play params[:chain][:word_played]
    end
    if params[:unplay] != nil
      @game.unplay params[:chain][:word_played]
    end
    @game.save

    @@chain_to_keep = params[:chain] == nil ? "" : params[:chain][:chain_to_keep].downcase
    @@chain_to_remove = params[:chain] == nil ? "" : params[:chain][:chain_to_remove].downcase
    redirect_to game_path(@game)
  end
end