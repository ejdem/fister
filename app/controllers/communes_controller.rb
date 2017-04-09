class CommunesController < ApplicationController
  respond_to :json
  before_action :protect_not_json, only: [:index]
  before_action :identify_commune, only: [:show, :update]
  before_action :resque_empty_params, only: [:update]
  
  def index
    render json: Commune.all,
           root: false,
           status: 200
  end
  
  def create
    render body: nil, status: 403
  end
  
  def show
    if @commune
      render body: @commune, root: false, status: 200
    else
      render body: nil, status: 404
    end
  end
  
  def update
    @commune&.update(commune_params)
  end
  
  private

  def resque_empty_params
    render body: nil, status: 400 if params[:commune].blank?
  end
  
  def commune_params
    params.require(:commune).permit(:name, :code_insee)
  end
  
  def identify_commune
    @commune = Commune.find_by(code_insee: params[:id])
    render body: nil, status: 404 unless @commune
  end
end