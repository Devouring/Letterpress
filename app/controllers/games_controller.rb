class GamesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    game = Game.find(params[:id]) # look up movie by unique ID
   # game.find_words
    @words = game.get_words_sorted(params[:chain]) 
    @game = game
    @games = Game.order("updated_at").reverse
    game.touch
    params[:chain] = params[:chain] == nil ? "Letters to keep" : params[:chain][:letters]
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @games = Game.order("updated_at").reverse
  end

  def new
    # default: render 'new' template
  end

  def create
    @game = Game.create!(:title => params[:game][:title], :title_ordered => params[:game][:title].chars.sort.join)
    @game.find
    @game.save
    flash[:notice] = "#{@game.title} was successfully created."
    redirect_to games_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    flash[:notice] = "Game '#{@game.title}' deleted."
    redirect_to games_path
  end

end
