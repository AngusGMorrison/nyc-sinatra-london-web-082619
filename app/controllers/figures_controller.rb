class FiguresController < ApplicationController
  
  get "/figures" do
    erb :"/figures/index"
  end
  
  post "/figures/?" do
    figure = Figure.create(name: params[:figure][:name])

    if params[:figure][:title_ids]
      params[:figure][:title_ids].map do |title_id|
        figure.titles << Title.find(title_id)
      end
    end

    if !params[:title][:name].empty?
      figure.titles << Title.create(params[:title])
    end

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].map do |landmark_id|
        figure.landmarks << Landmark.find(landmark_id)
      end
    end

    if !params[:landmark][:name].empty?
      figure.landmarks << Landmark.create(params[:landmark])
    end

    redirect "/figures/#{figure.id}"
  end
  
  get "/figures/new" do
    @figure = Figure.new
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/new"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

  patch "/figures/:id" do
    figure = Figure.find(params[:id])
    figure.titles.clear
    figure.landmarks.clear

    figure.update(name: params[:figure][:name])

    if params[:figure][:title_ids]
      params[:figure][:title_ids].map do |title_id|
        figure.titles << Title.find(title_id)
      end
    end

    if !params[:title][:name].empty?
      figure.titles << Title.create(params[:title])
    end

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].map do |landmark_id|
        figure.landmarks << Landmark.find(landmark_id)
      end
    end

    if !params[:landmark][:name].empty?
      figure.landmarks << Landmark.create(params[:landmark])
    end

    redirect "/figures/#{figure.id}"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/edit"
  end
    
end