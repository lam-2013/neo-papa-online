class MessagesController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  respond_to :js, only: :new

  def new
    @user = User.find(params[:user])
    @message = Message.new

    if params[:message]
      subject = Message.find(params[:message]).subject
      @message.subject = "Re: #{subject}"
    end

    respond_with @user, @message
  end

  def create
    @message = Message.new
    @message.subject = params[:message][:subject]
    @message.body = params[:message][:body]
    @message.sender = User.find(params[:message][:sender])
    recipient = User.find(params[:message][:recipient])
    @message.recipient = recipient

    if @message.save
      flash[:success] = "Messaggio mandato a #{recipient.name}!"
      redirect_to :back
    else
      render 'sessions/new'
    end
  end

  def destroy
    if current_user.received_messages.find_by_id(@message.id).nil?
      @message.mark_deleted
    else
      @message.mark_deleted(current_user)
    end
    redirect_to current_user
  end

  private

  def correct_user
    @message = current_user.received_messages.find_by_id(params[:id])
    @message = current_user.sent_messages.find_by_id(params[:id]) unless @message
    redirect_to root_url if @message.nil?
  end
end
