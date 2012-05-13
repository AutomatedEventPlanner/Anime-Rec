class AnimesController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy, :approve, :reject]
  before_filter :approval_check, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy, :approve, :reject]

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

  def approve
      @anime = Anime.find(params[:id])
      @anime.toggle!(:approved)

      respond_to do |format|
           format.html { render 'show' }
           format.js
      end
  end

  def reject
      @anime = Anime.find(params[:id])
      @anime.toggle!(:approved)

      respond_to do |format|
           format.html { render 'show' }
           format.js
      end
  end


  private

  def approval_check
       @anime = Anime.find(params[:id])
       if !@anime.approved?
           redirect_to nope_path, notice: "This anime is not approved and cant't be updated by non-admins." unless current_user.admin?
       end
  end
end
