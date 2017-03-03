class SongsController < ApplicationController
  def new
    @song = Song.new(album_id: params[:album_id])
  end
end

# refactoring

class SongsController < ApplicationController
  before_filter :grab_album_from_album_id

  def index
    @songs = @album.songs.all
  end

  def show
    @song = @album.songs.find(params[:id])
  end

  def new
    @song = @album.songs.new
  end

  def edit
    @song = @album.songs.find(params[:id])
  end

  def create
    @song = @album.songs.new(params[:song])

    if @song.save
      redirect_to(
        [@album, @song],
        notice: 'Song was successfully created.'
      )
    else
      render action: 'new'
    end
  end

  def update
    @song = @album.songs.find(params[:id])

    if @song.update_attributes(params[:song])
      redirect_to(
        [@album, @song],
        notice: 'Song was successfully updated.'
      )
    else
      render action: 'edit'
    end
  end

  def destroy
    Song.find(params[:id]).destroy
    redirect_to(album_songs_url(@album))
  end
end
  private

  def grab_album_from_album_id
    @album = Album.find(params[:album_id])
  end
end

# using un-nested resources

class SongsController < ApplicationController
  before_filter :grab_album_from_album_id

  def index
    @songs = songs.all
  end

  def show
    @song = songs.find(params[:id])
  end

  def new
    @song = songs.new
  end

  def edit
    @song = songs.find(params[:id])
  end

  def create
    @song = songs.new(params[:song])

    if @song.save
      redirect_to(@song, notice: 'Song was successfully created.')
    else
      render action: 'new'
    end
  end

  def update
    @song = songs.find(params[:id])

    if @song.update_attributes(params[:song])
      redirect_to(@song, notice: 'Song was successfully updated.')
    else
      render action: 'edit'
    end
  end

  def destroy
    Song.find(params[:id]).destroy
    redirect_to(songs_url)
  end

  private

  def songs
    @album ? @album.songs : Song
  end

  def grab_album_from_album_id
    @album = Album.find(params[:album_id]) if params[:album_id]
  end
end
