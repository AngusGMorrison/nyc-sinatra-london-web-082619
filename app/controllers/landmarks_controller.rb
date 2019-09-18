class LandmarksController < ApplicationController
  
  get "/landmarks" do
    erb :"landmarks/index"
  end

  post "/landmarks/?" do
    new_landmark = Landmark.new
    new_landmark.name = params[:landmark][:name]
    new_landmark.year_completed = params[:landmark][:year_completed]

    if !params[:figure][:name].empty?
      new_figure = Figure.create(params[:figure])
      new_landmark.figure = new_figure
    elsif params[:landmark][:figure]
      existing_figure = Figure.find(params[:landmark][:figure])
      new_landmark.figure = existing_figure
    end

    new_landmark.save

    redirect "/landmarks/#{new_landmark.id}"
  end

  get "/landmarks/new" do
    @landmark = Landmark.new
    erb :"landmarks/new"
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    erb :"landmarks/show"
  end

  patch "/landmarks/:id" do
    landmark = Landmark.find(params[:id])
    landmark.update(
      name: params[:landmark][:name],
      year_completed: params[:landmark][:year_completed]
    )

    if !params[:figure][:name].empty?
      figure = Figure.create(params[:figure])
      landmark.figure = figure
    elsif params[:landmark][:figure]
      figure = Figure.find(params[:landmark][:figure])
      landmark.figure = figure
    end

    redirect "/landmarks/#{landmark.id}"
  end 

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find(params[:id])
    erb :"landmarks/edit"
  end
end
