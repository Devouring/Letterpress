class WordsController < ApplicationController
  include ApplicationHelper
  def index
    if params[:offset] == nil then params[:offset] = 0 end
    @words = Word.order("text").offset(params[:offset]).limit(50)
    params[:showPrev] = params[:showNext] = false
    if params[:offset] > 0 then params[:showPrev] = true end
    if params[:offset] + 50 < Word.count then params[:showNext] = true end
  end

  def new
  end

  def create
    @word = Word.create!(:text => params[:word][:text],:letter_hash => generate_hash(params[:word][:text]))
    flash[:notice] = "Word #{@word.text} added"
    redirect_to words_path
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    flash[:notice] = "Word #{@word.text} removed"
    redirect_to words_path
  end

  def show
    @word = Word.find(params[:id])
  end

  def generate
    duplicate = 0
    added = 0
    read_file do |word|
      unless Word.exists?(:text => word) then
        Word.create!(:text => word, :letter_hash => generate_hash(word))
      added += 1
      else
      duplicate += 1
      end
    end
    flash[:notice] = "Words generated, #{added} added, #{duplicate} duplicate"
    redirect_to words_path
  end

  def remove_duplicate
    cpt = 0
    word_hash = Hash.new
    Word.all.each do |word|
      if word_hash[word.text.to_sym] == nil
        word_hash[word.text.to_sym] = 1
      else
        word.destroy
        cpt += 1
      end
    end
    flash[:notice] = "#{cpt} words deleted"
    redirect_to words_path
  end

end