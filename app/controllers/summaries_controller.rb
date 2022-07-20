require 'streamio-ffmpeg'
require 'tempfile'

class SummariesController < ApplicationController

  def new
    @summary = Summary.new
  end

  def create
    @summary = Summary.new(summary_params)
    @summary.video_url

    tempfile = Tempfile.open
    tempfile.binmode

    file = params[:video]

    pp '______________________________'
    pp file
    pp '______________________________'


    if @summary.save
      render json: @summary, status: :ok
    else
      render json: @summary.errors, status: :unprocessable_entity
    end
  end

  private

  def summary_params
    params.require(:summary).permit(:content, :video)
  end
end
