class WikisController < ApplicationController

  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create]

  def index
    @wikis = Wiki.all
    authorize @wiki
  end

  def show
    authorize @wiki
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki

  end

  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki
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

  def authorize_user
    wiki = Wiki.find(params[:id])

    unless current_user == wiki.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to [wiki]
    end
  end
end
