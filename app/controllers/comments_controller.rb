class CommentsController < ApplicationController
	before_action :session_required
	before_action :find_post, only: [:create]

	def create
		
		@comment = current_user.comments.new(comment_params)
		@comment.post = @post
		if @comment.save
			# redirect_to @post
			# render html: "hi"
		else
			render "posts/show"
		end
	end

	def destroy
		comment = current_user.comments.find(params[:id])
    # select * from comments where id = ? and user_id = 3

		# comment.destroy
		comment.destroy #其實是update
    redirect_to comment.post, notice: '留言已刪除'
	end

	private
	def comment_params
		params.require(:comment).permit(:content)
	end

	def find_post
		@post = Post.find(params[:post_id])
	end
end
