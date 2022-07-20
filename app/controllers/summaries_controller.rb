require 'streamio-ffmpeg'
require 'tempfile'

class SummariesController < ApplicationController

  def new
    @summary = Summary.new
  end

  def create
    @summary = Summary.new(summary_params)

    video = summary_params[:video]

    local = Tempfile.open
    local.binmode
    local.write(video.tempfile)

    movie = FFMPEG::Movie.new(video.tempfile.to_s)

    pp '______________________________'
    pp video
    pp local.path
    pp '______________________________'

    output_path = "#{Rails.root}/path/to/output.mp4"
    movie.transcode(output_path, %w(-metadata:s:v rotate=180 -c copy))

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
