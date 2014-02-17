class MoviesController < ApplicationController
  def create
    @movie = Movie.create(movie_params)
    respond_with @movie
  end

  def movie_params
    params.require(:title).permit(:length, :director, :year)
  end
end
