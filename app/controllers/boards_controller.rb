class BoardsController < ApplicationController
  def index
  end

	def new
		@board = Board.new
  end

	def create
		clean_params = params.require(:board).permit(:title)
    @board = Board.new(clean_params)

    if @board.save
			# 成功
			flash[:notice] = "成功新增看板"
      redirect_to "/", notice: "成功新增看板"
    else
			# 失敗
			render :new #render "boards/new"
    end
end
end
