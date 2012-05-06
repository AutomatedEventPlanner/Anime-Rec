class AnimesController < ApplicationController
  def index
     @animes = Anime.paginate(page: params[:page])
  end

  def new
     @anime = Anime.new
  end

  def edit
      @anime = Anime.find(params[:id])
  end

  def show
      @anime = Anime.find(params[:id])
  end

  def create
     @anime = Anime.new(params[:anime])
    
     if @anime.save
          redirect_to @anime
     else
          render 'new'
     end
  end

  def update
     @anime = Anime.find(params[:id])

     if @anime.update_attributes(params[:anime])
         redirect_to @anime
     else
         render 'edit'
     end
  end

  def destroy
      Anime.find(params[:id]).destroy
      redirect_to animes_path
  end
end
