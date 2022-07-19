require 'streamio-ffmpeg'

class SummariesController < ApplicationController
  def create
    tmpfile = params[:movie]
    movie = FFMPEG::Movie.new(tmpfile.to_s)
    pp '+++++++++++++++++++++++++++'
    pp tmpfile
    pp movie
    pp '+++++++++++++++++++++++++++'
  end
end
