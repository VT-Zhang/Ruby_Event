class CommentsController < ApplicationController
  def create
      event = Event.find(params[:id])
      comment = Comment.create(content: params[:content], user:current_user, event: event)
      if comment.valid?
          redirect_to "/events/#{event.id}/show"
      else
          flash[:errors] = comment.errors.full_messages
          redirect_to "/events/#{event.id}/show"
      end
  end
end
