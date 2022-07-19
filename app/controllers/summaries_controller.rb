require 'streamio-ffmpeg'
class SummariesController < ApplicationController

  def new
    @summary = Summary.new
  end

  def create
    @summary = Summary.new(summary_params)

    tmpfile = @summary.video_url
    video = FFMPEG::Movie.new(tmpfile)
    pp '______________________________'
    pp tmpfile = @summary.video_url
    pp video
    pp '______________________________'



    if @summary.save
      render json: @summary, methods: [:video_url]
    else
      render json: @summary.errors, status: :unprocessable_entity
    end
  end

  private

  def summary_params
    params.require(:summary).permit(:content, :video)
  end
end
