class SurveysController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]
  
  # GET /surveys
  # GET /surveys.json
  def index
    @title = t('view.surveys.index_title')
    @surveys = Survey.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @surveys }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    @title = t('view.surveys.show_title')
    @survey = Survey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @survey }
    end
  end

  # GET /surveys/new
  # GET /surveys/new.json
  def new
    @title = t('view.surveys.new_title')
    @survey = Survey.new
    @survey.travel_lines.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @survey }
    end
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @title = t('view.surveys.new_title')
    @survey = Survey.new(params[:survey])

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: t('view.surveys.correctly_created') }
        format.json { render json: @survey, status: :created, location: @survey }
      else
        format.html { render action: 'new' }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end
end
