class MessagesController < ApplicationController
  before_filter :load_message, only: [:edit, :update, :destroy]

  def index
    @messages = current_user.messages.order(created_at: :desc)
  end

  def new
    set_available_digests
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(params.require(:message).permit(:digest, :content))
    if @message.save
      flash[:success] = "Message created successfully"
      redirect_to messages_path
    else
      set_available_digests
      render :new
    end
  end

  def edit
    set_available_digests
  end

  def update
    if @message.update_attributes(params.require(:message).permit(:digest, :content))
      flash[:success] = "Message updated successfully."
      redirect_to messages_path
    else
      set_available_digests
      render :edit
    end
  end

  def destroy
    @message.destroy
    redirect_to :back
  end

  private
  def load_message
    @message = current_user.messages.find(params[:id])
  end

  def set_available_digests
    @available_digests = Weekly::Digest::TYPES + ["-----------"]
  end
end
