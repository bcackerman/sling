class QuestionsController < ApplicationController
  include RatingsHelper
  before_filter :authenticate_user!, only: %w(new create)
  respond_to :html #:json

  def select
    @question = Question.find_by_id(params[:question_select])
    @select = Post.where(:question_id => @question.id).show.like.order("likes_count DESC").first
  end

  def index
    session[:tab_select] = params[:tab_select] if params[:tab_select].present?
    if session[:tab_select] == "Newest"
      query_order = "created_at DESC"
    elsif session[:tab_select] == "Most Answered"
      query_order = "answers_count DESC"
    else
      query_order = "created_at DESC"
    end

    if session[:tab_select] == "Most Answered"
      @questions = @questions_result.answer.order(query_order).page(params[:page]).per(12)
    else
      @questions = @questions_result.order(query_order).page(params[:page]).per(12)
    end
    @quotes = Quote.show.desc
  end

  def channel
    session[:user_name] = params[:username] if params[:username].present?
    @post_user = User.find_by_name(session[:user_name]) 
    @questions = Question.desc.where(:user_id => @post_user.id).page(params[:page]).per(5)
    
    @posts_show = @posts_result.where(:user_id => @post_user.id).show
    @total_count = @posts_show.count
    @speech_count = @posts_show.where(:category => "Speech").count
    @eval_count = @posts_show.where(:category => "Evaluation").count
    @answer_count = @posts_show.where(:category => "Answer").count
    @question_count = Question.where(:user_id => @post_user.id).count
        
    @best_speech = @posts_show.where(:category => "Speech").like.order("likes_count DESC").first
    @best_eval = @posts_show.where(:category => "Evaluation").like.order("likes_count DESC").first
    @best_answer = @posts_show.where(:category => "Answer").like.order("likes_count DESC").first
    @best_question = Question.where(:user_id => @post_user.id).answer.order("answers_count DESC").first
  end

  def show
    @question = Question.find(params[:id])
    @posts_show = @posts_result.where(:question_id => @question.id).show
    @answers = @posts_show.desc.page(params[:page]).per(4)
    if @posts_show.present?
      @best = @posts_show.like.order("likes_count DESC").first
      create_metric_bar(@best)
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params[:question])
    @question.user = current_user
    @question.save
    redirect_to @question
  end

end
