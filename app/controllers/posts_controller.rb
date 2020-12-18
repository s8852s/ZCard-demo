class PostsController < ApplicationController
  before_action :session_required, only: [:create, :edit, :update]
  before_action :set_board, only: [:new, :create]
  before_action :set_post, only: [:show]

	def show
		@post = Post.friendly.find(params[:id])
		@comment = Comment.new

		@comments = @post.comments.where(deleted_at: nil).order(id: :desc).includes(:user).page(params[:page]).per(5)
		# .includes(:user) 解決N+1問題 發生在用迴圈 從不同資料表撈資料時
		# select * from posts where id = 7
		# select * from users where id in (3, 5, 8)
		# /posts/7?aa=2&cc=3
    # params[:aa]
    # params[:cc]
	end

	def new
		@post = Post.new
	end

  def create
		# @post = Post.new(post_params)
		# @post.board = @board
		# @post.user = current_user

		# 從看板角度新增
		# @post = @board.posts.new(post_params)
		# @post.user = current_user

		# 從使用者角度新增
		@post = current_user.posts.new(post_params)
		@post.board = @board
		if @post.save
			redirect_to @board, notice: "新增文章成功"
			# redirect_to board_path(@board)
		else
			render :new
		end
	end

	def edit
		# @post = Post.find_by!(id: params[:id], user: current_user)
		# 找不到就噴404  所以要加!
		# ??

		@post = current_user.posts.find(params[:id])
	end

	def update
		@post = current_user.posts.find(params[:id])
		  if @post.update(post_params)
			  redirect_to @post, nitice: "文章更新成功"
			else
				render :edit
		  end
	end

	def favorite
		post = Post.find(params[:id])
		if current_user.favorite?(post)
      # 移除我的最愛
      current_user.my_favorites.destroy(post)
      render json: { status: "removed"}
    else
      # 加到我的最愛
      current_user.my_favorites << post
      render json: { status: "added"}
    end
	end


	private 
		def post_params
			params.require(:post).permit(:title, :content)
		end
		
		def set_board
			@board = Board.find(params[:board_id])
		end

		def set_post
			@post = Post.friendly.find(params[:id])
		end

end
