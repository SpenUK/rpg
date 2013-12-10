class MessagesController < ApplicationController

  def index
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def message_params
    params.require(:message).permit(:title, :body)
  end
end
