class SummariesController < ApplicationController

  def new
    @summary = Summary.new
  end

  def create
    @summary = Summary.create params.require(:summary).permit(:content, :video)
    render json: @summary, status: :ok
  end

  private

  def summary_params
    params.require(:summary).permit(:content, :video)
  end
end
