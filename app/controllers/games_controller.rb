class GamesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @game = Game.find(id) # look up movie by unique ID
   # game.find_words
    chain = params[:chain] == nil ? "" : params[:chain][:letters]
    @words = WordFinder.new(@game.title).get_words_list_from_chain(chain).sort_by{|x| x.length}.reverse
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @games = Game.all.ord
  end

  def new
    # default: render 'new' template
  end

  def create
    @game = Game.create!(params[:game])
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
    puts "toto"
    @game = Game.find(params[:id])
    @game.destroy
    flash[:notice] = "Game '#{@game.title}' deleted."
    redirect_to game_path
  end

end
