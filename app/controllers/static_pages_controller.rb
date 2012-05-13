class StaticPagesController < ApplicationController
  def home
      if !signed_in?
	    @interests = cookies[:interests]
	    arr = Anime.all.keep_if {|a| a.recScore(@interests) >= 50 && a.approved? }
	    @animes = arr.sort! {|a,b| b.recScore(@interests) <=> a.recScore(@interests) }

	    if (@interests.nil? || @interests.empty?)
	      #flash.now[:notice] = 'We do not currently know your interests. Please use the form to enter them.'
	      render 'home'
	    elsif (@animes.empty?)
	      #flash.now[:notice] = 'We were not able to find any animes that closely match your interests.'
	      render 'home'
	    end
        end
  end

  def help
  end

  def recommend
      if !signed_in?
	    @interests = params[:interests]
	    arr = Anime.all.keep_if {|a| a.recScore(@interests) >= 50 && a.approved? }
	    @animes = arr.sort! {|a,b| b.recScore(@interests) <=> a.recScore(@interests) }


	    if (@interests.nil? || @interests.empty?)
	      @interests = cookies[:interests]
	       respond_to do |format|
		format.html { render 'home' }
		format.js #{ flash.now[:error] = 'You cannot enter blank value for interests.' }
	      end
	    elsif (@animes.empty?)
	      cookies.permanent[:interests] = @interests
	       respond_to do |format|
		format.html { render 'home' }
		format.js #{ flash.now[:notice] = 'We were not able to find any animes that closely match your interests.' }
	      end
	    else 
	      cookies.permanent[:interests] = @interests
	      respond_to do |format|
		format.html { render 'home' }
		format.js
	      end
	    end
       end
  end

  def nope
  end
end
