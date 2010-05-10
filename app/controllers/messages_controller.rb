class MessagesController < ApplicationController
  def index
    @messages = Message.all(:order => "id DESC")
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.save
      flash[:message] = t('messages.flash.created')
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @message = Message.find(params[:id])
  end


  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:message] = t('messages.flash.updated')
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to root_path
  end

end
