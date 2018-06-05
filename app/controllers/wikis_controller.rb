class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki).order("title ASC")
    authorize @wikis
  end

  def show
     @wiki = Wiki.find(params[:id])
     unless !@wiki.private? || (current_user.admin? || current_user.premium?)
       flash[:alert] = "You must be a premium user to view private wikis."
       redirect_to(request.referrer || root_path)
     end
   end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki
    @wiki.private(wiki_private_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)
    @wiki.private(wiki_private_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end

  def wiki_private_params
    params.require(:wiki).permit(:private)
  end

end
