class SongsController < ApplicationController
  before_filter :grab_album_from_album_id

  def index
    @songs = songs.all
    respond_to do |format|
      format.xml { render xml: @songs }
    end
  end

  def show
    @song = songs.find(params[:id])
    respond_to do |format|
      format.xml { render xml: @song }
    end
  end

  def new
    @song = songs.new
    respond_to do |format|
      format.xml { render xml: @song }
    end
  end

  def create
    @song = songs.new(params[:song])
    respond_to do |format|
      if @song.save
        format.xml { render xml: @song, location: @song }
      else
        format.xml { render xml: @song.errors }
      end
    end
  end

  def update
    @song = songs.find(params[:id])
    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.xml { head :ok }
      else
        format.xml { render xml: @song.errors }
      end
    end
  end

  def destroy
    respond_to do |format|
      format.xml { head :ok }
    end
  end

  private

  def songs
    @album ? @album.songs : Song
  end

  def grab_album_from_album_id
    @album = Album.find_by_id(params[:album_id])
  end
end

# Obey the HTTP Codes

class SongsController < ApplicationController
  before_filter :grab_album_from_album_id

  def index
    @songs = songs.all
    respond_to do |format|
      format.xml { render xml: @songs }
    end
  end

  def show
    @song = songs.find(params[:id])
    respond_to do |format|
      format.xml { render xml: @song }
    end
  end

  def new
    @song = songs.new
    respond_to do |format|
      format.xml { render xml: @song }
    end
  end

  def create
    @song = songs.new(params[:song])
    respond_to do |format|
      if @song.save
        format.xml do
          render xml: @song,
                 status: :created,
                 location: @song
        end
      else
        format.xml do
          render xml: @song.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @song = songs.find(params[:id])
    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.xml { head :ok }
      else
        format.xml do
          render xml: @song.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.xml { head :ok }
    end
  end

  private

  def songs
    @album ? @album.songs : Song
  end

  def grab_album_from_album_id
    @album = Album.find_by_id(params[:album_id])
  end
end
