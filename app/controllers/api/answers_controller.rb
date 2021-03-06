class Api::AnswersController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!

  def index
    render json: @post.answers.all
  end

  def create
    @answer = @post.answers.new(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      render json: @answer
    else
      render json: { errors: @answer.errors }, status: :unprocessable_entity
    end
  end

  def update
    @answer = @post.answers.find(params[:id])
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: { errors: @answer.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    Answer.find(params[:id]).destroy
    render json: { message: 'Answer deleted' }
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end


end
