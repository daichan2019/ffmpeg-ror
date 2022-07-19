require 'streamio-ffmpeg'
require 'tempfile'

class SummariesController < ApplicationController

  def new
    @summary = Summary.new
  end

  def create
    @summary = Summary.new(summary_params)

    local = Tempfile.open
    local.binmode

    video = @summary.video_url

    local.write(video)

    ffmpeg = FFMPEG::Movie.new(local.path)

    ffmpeg.transcode("tmp/movie_#{Time.current}.mp4")

    pp '______________________________'
    pp ffmpeg
    pp '______________________________'


    # @summary.video = ffmpeg

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
